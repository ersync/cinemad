namespace :movies do
  desc "Attach cover images to all Movie records from downloaded files"
  task attach_cover: :environment do

    # Base directory where all movie covers are stored
    BASE_DIR = "public/movie_media/covers"

    puts "Starting cover attachment process..."
    puts "Looking for cover files in: #{BASE_DIR}"

    # Check if the base directory exists
    unless Dir.exist?(BASE_DIR)
      puts "ERROR: Base directory not found: #{BASE_DIR}"
      exit
    end

    # Get all movie cover files
    cover_files = Dir.glob("#{BASE_DIR}/*.jpg")

    # Debug: List all found files
    puts "Found #{cover_files.count} cover files:"
    cover_files.each do |file|
      puts "  - #{file} (#{File.basename(file)})"
    end

    if cover_files.empty?
      puts "No movie cover files found in #{BASE_DIR}"
      exit
    end

    # Debug: Check how many movies exist in the database
    total_db_movies = Movie.count
    puts "Total movies in database: #{total_db_movies}"

    # List movie IDs that don't have covers
    db_movie_ids = Movie.pluck(:id)
    file_movie_ids = cover_files.map { |file| File.basename(file, '.jpg').to_i }
    missing_covers = db_movie_ids - file_movie_ids

    puts "Movies without cover files: #{missing_covers.count}"
    puts "Missing movie IDs: #{missing_covers.join(', ')}" if missing_covers.any?

    total_files = cover_files.count
    total_attached = 0
    total_failed = 0

    cover_files.each_with_index do |cover_path, index|
      movie_id = File.basename(cover_path, '.jpg')
      puts "Processing movie ID #{movie_id} (#{index + 1}/#{total_files})"

      # Find the movie with this ID
      movie = Movie.find_by(id: movie_id)

      if movie.nil?
        puts "  ERROR: Movie not found with ID: #{movie_id}"
        total_failed += 1
        next
      end

      begin
        # Skip if cover is already attached
        if movie.cover.attached?
          puts "  SKIPPED: Cover already attached to #{movie.title}"
          next
        end

        # Attach the cover to the movie
        movie.cover.attach(
          io: File.open(cover_path),
          filename: "cover.jpg",
          content_type: 'image/jpeg'
        )

        # Save the movie to ensure the attachment is saved
        if movie.save
          puts "  SUCCESS: Attached cover to #{movie.title}"
          total_attached += 1
        else
          puts "  ERROR: Failed to save movie after attaching cover: #{movie.errors.full_messages.join(', ')}"
          total_failed += 1
        end
      rescue => e
        puts "  ERROR: Exception while attaching cover for #{movie.title || 'unknown movie'}: #{e.message}"
        total_failed += 1
      end
    end

    puts "\nCover attachment process completed!"
    puts "Processed #{total_files} cover files"
    puts "Successfully attached covers to #{total_attached} movies"
    puts "Failed to process #{total_failed} movies"
  end
end