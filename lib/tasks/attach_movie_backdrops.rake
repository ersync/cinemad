# lib/tasks/attach_movie_backdrops.rake
namespace :movies do
  desc "Attach backdrop images to all Movie records from downloaded files"
  task attach_backdrops: :environment do
    # Base directory where all movie backdrops are stored
    BASE_DIR = "public/movie_media/backdrops"

    puts "Starting backdrop attachment process..."
    puts "Looking for backdrop directories in: #{BASE_DIR}"

    # Check if the base directory exists
    unless Dir.exist?(BASE_DIR)
      puts "ERROR: Base directory not found: #{BASE_DIR}"
      exit
    end

    # Get all movie backdrop directories
    movie_dirs = Dir.glob("#{BASE_DIR}/*").select { |d| File.directory?(d) }

    # Debug: List all found directories
    puts "Found #{movie_dirs.count} movie directories:"
    movie_dirs.each do |dir|
      puts "  - #{dir} (#{File.basename(dir)})"
    end

    if movie_dirs.empty?
      puts "No movie backdrop directories found in #{BASE_DIR}"
      exit
    end

    # Debug: Check how many movies exist in the database
    total_db_movies = Movie.count
    puts "Total movies in database: #{total_db_movies}"

    # List movie IDs that don't have directories
    db_movie_ids = Movie.pluck(:id)
    dir_movie_ids = movie_dirs.map { |dir| File.basename(dir).to_i }
    missing_dirs = db_movie_ids - dir_movie_ids

    puts "Movies without backdrop directories: #{missing_dirs.count}"
    puts "Missing movie IDs: #{missing_dirs.join(', ')}" if missing_dirs.any?

    total_movies = movie_dirs.count
    total_attached = 0
    total_failed = 0
    total_backdrops = 0

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

      # Get all backdrop files for this movie
      backdrop_files = Dir.glob("#{movie_dir}/*.jpg")

      if backdrop_files.empty?
        puts "  WARNING: No backdrop files found for #{movie.title}"
        next
      end

      begin
        # Attach each backdrop to the movie
        backdrop_count = 0
        backdrop_files.each do |backdrop_path|
          # Skip if this exact file is already attached
          filename = File.basename(backdrop_path)
          if movie.backdrops.any? { |b| b.filename.to_s == filename }
            puts "  SKIPPED: Backdrop #{filename} already attached to #{movie.title}"
            next
          end

          movie.backdrops.attach(
            io: File.open(backdrop_path),
            filename: filename,
            content_type: 'image/jpeg'
          )
          backdrop_count += 1
        end

        # Save the movie to ensure the attachments are saved
        if movie.save
          puts "  SUCCESS: Attached #{backdrop_count} backdrops to #{movie.title}"
          total_attached += 1
          total_backdrops += backdrop_count
        else
          puts "  ERROR: Failed to save movie after attaching backdrops: #{movie.errors.full_messages.join(', ')}"
          total_failed += 1
        end
      rescue => e
        puts "  ERROR: Exception while attaching backdrops for #{movie.title || 'unknown movie'}: #{e.message}"
        total_failed += 1
      end
    end

    puts "\nBackdrop attachment process completed!"
    puts "Processed #{total_movies} movies"
    puts "Successfully attached backdrops to #{total_attached} movies"
    puts "Total backdrops attached: #{total_backdrops}"
    puts "Failed to process #{total_failed} movies"
  end
end