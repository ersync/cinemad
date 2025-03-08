# lib/tasks/attach_movie_posters.rake
namespace :movies do
  desc "Attach poster images to all Movie records from downloaded files"
  task attach_posters: :environment do
    # Base directory where all movie posters are stored
    BASE_DIR = "public/movie_media/posters"

    puts "Starting poster attachment process for all movies..."

    # Get all movie poster directories
    movie_dirs = Dir.glob("#{BASE_DIR}/*").select { |d| File.directory?(d) }

    if movie_dirs.empty?
      puts "No movie poster directories found in #{BASE_DIR}"
      exit
    end

    total_movies = movie_dirs.count
    total_attached = 0
    total_failed = 0
    total_posters = 0

    movie_dirs.each_with_index do |movie_dir, index|
      movie_id = File.basename(movie_dir)
      puts "Processing movie ID #{movie_id} (#{index + 1}/#{total_movies})"

      # Find the movie with this ID
      movie = Movie.find_by(id: movie_id)

      if movie.nil?
        puts "  ERROR: Movie not found with ID: #{movie_id}"
        total_failed += 1
        next
      end

      # Get all poster files for this movie
      poster_files = Dir.glob("#{movie_dir}/*.jpg")

      if poster_files.empty?
        puts "  WARNING: No poster files found for #{movie.title}"
        next
      end

      begin
        # Attach each poster to the movie
        poster_count = 0
        poster_files.each do |poster_path|
          # Skip if this exact file is already attached
          filename = File.basename(poster_path)
          if movie.posters.any? { |p| p.filename.to_s == filename }
            puts "  SKIPPED: Poster #{filename} already attached to #{movie.title}"
            next
          end

          movie.posters.attach(
            io: File.open(poster_path),
            filename: filename,
            content_type: 'image/jpeg'
          )
          poster_count += 1
        end

        # Save the movie to ensure the attachments are saved
        if movie.save
          puts "  SUCCESS: Attached #{poster_count} posters to #{movie.title}"
          total_attached += 1
          total_posters += poster_count
        else
          puts "  ERROR: Failed to save movie after attaching posters: #{movie.errors.full_messages.join(', ')}"
          total_failed += 1
        end
      rescue => e
        puts "  ERROR: Exception while attaching posters for #{movie.title || 'unknown movie'}: #{e.message}"
        total_failed += 1
      end
    end

    puts "\nPoster attachment process completed!"
    puts "Processed #{total_movies} movies"
    puts "Successfully attached posters to #{total_attached} movies"
    puts "Total posters attached: #{total_posters}"
    puts "Failed to process #{total_failed} movies"
  end
end