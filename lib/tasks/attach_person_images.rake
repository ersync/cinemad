require 'ruby-progressbar'
require 'pastel'

namespace :people do
  desc "Attach images to Person records from demo assets"
  task attach_images: :environment do
    ActiveRecord::Base.logger.level = Logger::INFO
    original_verbose = $VERBOSE
    $VERBOSE = nil
      pastel = Pastel.new

    DEMO_ASSETS_DIR = Rails.root.join('public', 'demo_assets')
    PEOPLE_CAST_DIR = File.join(DEMO_ASSETS_DIR, 'cast')

    puts pastel.cyan("\n▶ Starting image attachment process...")

    begin
      if Dir.exist?(DEMO_ASSETS_DIR) && Dir.exist?(PEOPLE_CAST_DIR)
        puts pastel.green("  ✓ Using existing demo assets")
      else
        puts pastel.yellow("  ! Demo assets not found, downloading them first...")
        Rake::Task["assets:download"].invoke

        unless Dir.exist?(DEMO_ASSETS_DIR) && Dir.exist?(PEOPLE_CAST_DIR)
          puts pastel.red("\n✗ Failed to download required assets")
          exit 1
        end
      end

      movie_dirs = Dir.glob("#{PEOPLE_CAST_DIR}/*").select { |d| File.directory?(d) }

      total_movies = movie_dirs.count
      total_attached = 0
      total_failed = 0
      total_skipped = 0

      movies_progress = ProgressBar.create(
        title: "Processing Movies",
        total: total_movies,
        format: "%t: |%B| %c/%u %p%% %e",
        output: $stdout
      )

      movie_dirs.each do |movie_dir|
        movie_name = File.basename(movie_dir)
        images_dir = File.join(movie_dir, "images")

        unless Dir.exist?(images_dir)
          movies_progress.increment
          next
        end

        images = Dir.glob("#{images_dir}/*.jpg")

        images.each do |image_path|
          image_filename = File.basename(image_path)
          person = Person.find_by(image_filename: image_filename)

          if person&.image&.attached?
            total_skipped += 1
            next
          end

          begin
            if person
              person.image.attach(
                io: File.open(image_path),
                filename: image_filename,
                content_type: 'image/jpeg'
              )
              total_attached += 1
            else
              total_failed += 1
            end
          rescue => e
            puts pastel.red("  ! Error attaching image #{image_filename}: #{e.message}")
            total_failed += 1
          end
        end

        movies_progress.increment
      end

      puts pastel.green("\n✓ Task completed successfully!")
      puts pastel.cyan("\n▶ Results:")
      puts pastel.cyan("  • Movies Processed: #{total_movies}")
      puts pastel.green("  • Images Attached: #{total_attached}")
      puts pastel.yellow("  • Failed Attempts: #{total_failed}")
      puts pastel.cyan("  • Already Attached (Skipped): #{total_skipped}")

    rescue => e
      puts pastel.red("\n✗ Error: #{e.message}")
    end
    $VERBOSE = original_verbose
  end
end