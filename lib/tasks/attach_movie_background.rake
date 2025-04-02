require 'ruby-progressbar'
require 'pastel'

namespace :movies do
  desc "Attach background images to all Movie records from downloaded files"
  task attach_background: :environment do
    ActiveRecord::Base.logger.level = Logger::INFO
    original_verbose = $VERBOSE
    $VERBOSE = nil
    pastel = Pastel.new

    BASE_DIR = "public/demo_assets/media/backgrounds"

    puts pastel.cyan("\n▶ Starting background attachment process...")

    unless Dir.exist?(BASE_DIR)
      puts pastel.red("\n✗ Base directory not found: #{BASE_DIR}")

      if !Dir.exist?("public/demo_assets")
        puts pastel.yellow("  ! Demo assets not found. Running assets:download task first...")
        Rake::Task["assets:download"].invoke

        unless Dir.exist?(BASE_DIR)
          puts pastel.red("  ✗ Background directory still not found after downloading assets")
          exit 1
        end
      else
        exit 1
      end
    end

    background_files = Dir.glob("#{BASE_DIR}/*.jpg")

    if background_files.empty?
      puts pastel.yellow("\n! No movie background files found in #{BASE_DIR}")
      exit 0
    end

    puts pastel.cyan("  • Found #{background_files.count} background files")

    total_db_movies = Movie.count
    puts pastel.cyan("  • Total movies in database: #{total_db_movies}")

    db_movie_ids = Movie.pluck(:id)
    file_movie_ids = background_files.map { |file| File.basename(file, '.jpg').to_i }
    missing_backgrounds = db_movie_ids - file_movie_ids

    if missing_backgrounds.any?
      puts pastel.yellow("  • Movies without background files: #{missing_backgrounds.count}")
      if missing_backgrounds.count <= 10
        puts pastel.yellow("    Missing IDs: #{missing_backgrounds.join(', ')}")
      else
        puts pastel.yellow("    First 10 missing IDs: #{missing_backgrounds.take(10).join(', ')}...")
      end
    end

    total_files = background_files.count
    total_attached = 0
    total_failed = 0
    total_skipped = 0

    progress = ProgressBar.create(
      title: "Attaching Backgrounds",
      total: total_files,
      format: "%t: |%B| %c/%u %p%% %e",
      output: $stdout
    )

    background_files.each do |background_path|
      movie_id = File.basename(background_path, '.jpg')

      movie = Movie.find_by(id: movie_id)

      if movie.nil?
        total_failed += 1
        progress.increment
        next
      end

      begin
        if movie.background.attached?
          total_skipped += 1
          progress.increment
          next
        end

        movie.background.attach(
          io: File.open(background_path),
          filename: "background.jpg",
          content_type: 'image/jpeg'
        )

        if movie.save
          total_attached += 1
        else
          total_failed += 1
        end
      rescue => e
        total_failed += 1
      end

      progress.increment
    end

    puts pastel.green("\n✓ Background attachment process completed!")
    puts pastel.cyan("\n▶ Results:")
    puts pastel.cyan("  • Processed #{total_files} background files")
    puts pastel.green("  • Successfully attached: #{total_attached}")
    puts pastel.cyan("  • Already attached (skipped): #{total_skipped}")
    puts pastel.yellow("  • Failed to process: #{total_failed}")
    $VERBOSE = original_verbose
  end
end