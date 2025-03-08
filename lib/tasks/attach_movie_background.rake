namespace :movies do
  desc "Attach background images to all Movie records from downloaded files"
  task attach_background: :environment do
    # Base directory where all movie backdrops are stored
    BASE_DIR = "public/movie_media/backgrounds"

    puts "Starting background attachment process..."
    puts "Looking for backdrop files in: #{BASE_DIR}"

    unless Dir.exist?(BASE_DIR)
      puts "ERROR: Base directory not found: #{BASE_DIR}"
      exit
    end

    # Get all backdrop files
    backdrop_files = Dir.glob("#{BASE_DIR}/*.jpg")

    puts "Found #{backdrop_files.count} backdrop files"

    total_movies = Movie.count
    puts "Total movies in database: #{total_movies}"

    total_attached = 0
    total_failed = 0

    backdrop_files.each do |backdrop_path|
      movie_id = File.basename(backdrop_path, '.jpg')
      puts "Processing movie ID #{movie_id}"

      movie = Movie.find_by(id: movie_id)

      if movie.nil?
        puts "  ERROR: Movie not found with ID: #{movie_id}"
        total_failed += 1
        next
      end

      begin
        # Skip if background is already attached
        if movie.background.attached?
          puts "  SKIPPED: Background already attached to #{movie.title}"
          next
        end

        # Attach the background
        movie.background.attach(
          io: File.open(backdrop_path),
          filename: "background.jpg",
          content_type: 'image/jpeg'
        )

        if movie.save
          puts "  SUCCESS: Attached background to #{movie.title}"
          total_attached += 1
        else
          puts "  ERROR: Failed to save movie after attaching background: #{movie.errors.full_messages.join(', ')}"
          total_failed += 1
        end
      rescue => e
        puts "  ERROR: Exception while attaching background for #{movie.title}: #{e.message}"
        total_failed += 1
      end
    end

    puts "\nBackground attachment process completed!"
    puts "Successfully attached backgrounds to #{total_attached} movies"
    puts "Failed to process #{total_failed} movies"
  end
end