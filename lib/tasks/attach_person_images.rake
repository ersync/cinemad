namespace :people do
  desc "Attach images to Person records from downloaded files"
  task attach_images: :environment do
    BASE_DIR = "public/movie_cast_data"

    puts "Starting person image attachment process..."

    unless Dir.exist?(BASE_DIR)
      puts "ERROR: Base directory not found: #{BASE_DIR}"
      exit
    end

    # Get all movie directories
    movie_dirs = Dir.glob("#{BASE_DIR}/*").select { |d| File.directory?(d) }

    puts "Found #{movie_dirs.count} movie directories:"
    movie_dirs.each { |dir| puts "  - #{File.basename(dir)}" }

    total_processed = 0
    total_attached = 0
    total_failed = 0
    total_skipped = 0
    failed_cases = []

    movie_dirs.each do |movie_dir|
      movie_name = File.basename(movie_dir)
      images_dir = "#{movie_dir}/images"

      unless Dir.exist?(images_dir)
        puts "\nSKIPPED MOVIE: #{movie_name} - no images directory found at #{images_dir}"
        next
      end

      puts "\nProcessing images from movie: #{movie_name}"
      image_files = Dir.glob("#{images_dir}/*.jpg")

      if image_files.empty?
        puts "  WARNING: No jpg files found in #{images_dir}"
        next
      end

      puts "  Found #{image_files.count} image files:"
      image_files.each { |f| puts "    - #{File.basename(f)}" }

      image_files.each do |image_path|
        total_processed += 1
        person_name = File.basename(image_path, '.jpg').gsub('_', ' ')

        # Simple case-insensitive partial match
        person = Person.where("LOWER(name) LIKE ?", "%#{person_name.downcase}%").first

        # If no match found, try removing special characters from search
        if person.nil?
          clean_name = person_name.downcase.gsub(/[.,'"]/, '')
          person = Person.all.find { |p| p.name.downcase.gsub(/[.,'"]/, '') == clean_name }
        end

        if person.nil?
          error_msg = "Person not found in database"
          puts "    ERROR: #{error_msg}"
          failed_cases << {
            name: person_name,
            movie: movie_name,
            reason: error_msg,
            path: image_path
          }
          total_failed += 1

          # Debug: Show similar names in database
          similar_names = Person.where("LOWER(name) LIKE ?", "%#{person_name.downcase.split(' ').last}%")
          if similar_names.any?
            puts "    Similar names found in database:"
            similar_names.each { |p| puts "      - #{p.name}" }
          end
          next
        end

        puts "    Found person in database with ID: #{person.id}"

        if person.image.attached?
          puts "    SKIPPED: Image already attached"
          total_skipped += 1
          next
        end

        begin
          unless File.exist?(image_path)
            error_msg = "Image file not found at path"
            puts "    ERROR: #{error_msg}"
            failed_cases << {
              name: person_name,
              movie: movie_name,
              reason: error_msg,
              path: image_path
            }
            total_failed += 1
            next
          end

          # Check if file is readable and not empty
          unless File.readable?(image_path) && File.size(image_path) > 0
            error_msg = "Image file is not readable or empty"
            puts "    ERROR: #{error_msg}"
            failed_cases << {
              name: person_name,
              movie: movie_name,
              reason: error_msg,
              path: image_path
            }
            total_failed += 1
            next
          end

          person.image.attach(
            io: File.open(image_path),
            filename: "#{person_name.parameterize}.jpg",
            content_type: 'image/jpeg'
          )

          if person.save
            puts "    SUCCESS: Attached image"
            total_attached += 1
          else
            error_msg = "Failed to save: #{person.errors.full_messages.join(', ')}"
            puts "    ERROR: #{error_msg}"
            failed_cases << {
              name: person_name,
              movie: movie_name,
              reason: error_msg,
              path: image_path
            }
            total_failed += 1
          end
        rescue => e
          error_msg = "Exception: #{e.message}\n#{e.backtrace.first(3).join("\n")}"
          puts "    ERROR: #{error_msg}"
          failed_cases << {
            name: person_name,
            movie: movie_name,
            reason: error_msg,
            path: image_path
          }
          total_failed += 1
        end
      end
    end

    puts "\n----------------------------------------"
    puts "Person image attachment process completed!"
    puts "Total processed: #{total_processed}"
    puts "Successfully attached: #{total_attached}"
    puts "Already had images (skipped): #{total_skipped}"
    puts "Failed to process: #{total_failed}"

    if failed_cases.any?
      puts "\nFailed cases summary:"
      failed_cases.each do |failure|
        puts "\n  Person: #{failure[:name]}"
        puts "  Movie: #{failure[:movie]}"
        puts "  Reason: #{failure[:reason]}"
        puts "  Path: #{failure[:path]}"
        puts "  ----------------------------------------"
      end
    end
  end
end