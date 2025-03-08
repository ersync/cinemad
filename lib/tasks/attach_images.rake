# lib/tasks/attach_images.rake
namespace :people do
  desc "Attach images to Person records from downloaded files"
  task attach_images: :environment do
    # Script to attach images to Person records using Active Storage
    # This version processes ALL movie directories

    # Base directory where all movie data is stored
    BASE_DIR = "public/movie_cast_data"

    puts "Starting image attachment process for all movies..."

    # Get all movie directories
    movie_dirs = Dir.glob("#{BASE_DIR}/*").select { |d| File.directory?(d) }

    if movie_dirs.empty?
      puts "No movie directories found in #{BASE_DIR}"
      exit
    end

    total_movies = movie_dirs.count
    total_attached = 0
    total_failed = 0

    movie_dirs.each_with_index do |movie_dir, index|
      movie_name = File.basename(movie_dir)
      puts "Processing movie #{index + 1}/#{total_movies}: #{movie_name}"

      # Path to the images directory for this movie
      images_dir = File.join(movie_dir, "images")

      if !Dir.exist?(images_dir)
        puts "  Images directory not found for #{movie_name}, skipping"
        next
      end

      # Process each image in the directory
      Dir.glob("#{images_dir}/*.jpg").each do |image_path|
        image_filename = File.basename(image_path)

        # Find the person with this image filename
        person = Person.find_by(image_filename: image_filename)

        if person.nil?
          puts "  ERROR: Person not found for image: #{image_filename}"
          total_failed += 1
          next
        end

        begin
          # Check if image already attached to avoid duplicates
          if person.image.attached?
            puts "  SKIPPED: Image already attached for #{person.name}"
            next
          end

          # Attach the image to the person
          person.image.attach(
            io: File.open(image_path),
            filename: image_filename,
            content_type: 'image/jpeg'
          )

          # Save the person to ensure the attachment is saved
          if person.save
            puts "  SUCCESS: Attached image to #{person.name}"
            total_attached += 1
          else
            puts "  ERROR: Failed to save person after attaching image: #{person.errors.full_messages.join(', ')}"
            total_failed += 1
          end
        rescue => e
          puts "  ERROR: Exception while attaching image for #{person.name}: #{e.message}"
          total_failed += 1
        end
      end
    end

    puts "\nImage attachment process completed!"
    puts "Processed #{total_movies} movies"
    puts "Successfully attached #{total_attached} images"
    puts "Failed to attach #{total_failed} images"
  end

end