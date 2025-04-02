require 'ruby-progressbar'
require 'pastel'

namespace :movies do
  desc "Attach cover images to all Movie records from downloaded files"
  task attach_cover: :environment do
    ActiveRecord::Base.logger.level = Logger::INFO
    original_verbose = $VERBOSE
    $VERBOSE = nil
    pastel = Pastel.new

    BASE_DIR = "public/demo_assets/media/covers"

    puts pastel.cyan("\n▶ Starting cover attachment process...")

    unless Dir.exist?(BASE_DIR)
      puts pastel.red("\n✗ Base directory not found: #{BASE_DIR}")
      exit 1
    end

    cover_files = Dir.glob("#{BASE_DIR}/*.jpg")

    if cover_files.empty?
      puts pastel.yellow("\n! No movie cover files found in #{BASE_DIR}")
      exit 0
    end

    puts pastel.cyan("  • Found #{cover_files.count} cover files")

    total_db_movies = Movie.count
    puts pastel.cyan("  • Total movies in database: #{total_db_movies}")

    db_movie_ids = Movie.pluck(:id)
    file_movie_ids = cover_files.map { |file| File.basename(file, '.jpg').to_i }
    missing_covers = db_movie_ids - file_movie_ids

    if missing_covers.any?
      puts pastel.yellow("  • Movies without cover files: #{missing_covers.count}")
      if missing_covers.count <= 10
        puts pastel.yellow("    Missing IDs: #{missing_covers.join(', ')}")
      else
        puts pastel.yellow("    First 10 missing IDs: #{missing_covers.take(10).join(', ')}...")
      end
    end

    total_files = cover_files.count
    total_attached = 0
    total_failed = 0
    total_skipped = 0

    progress = ProgressBar.create(
      title: "Attaching Covers",
      total: total_files,
      format: "%t: |%B| %c/%u %p%% %e",
      output: $stdout
    )

    cover_files.each do |cover_path|
      movie_id = File.basename(cover_path, '.jpg')

      movie = Movie.find_by(id: movie_id)

      if movie.nil?
        total_failed += 1
        progress.increment
        next
      end

      begin
        if movie.cover.attached?
          total_skipped += 1
          progress.increment
          next
        end

        movie.cover.attach(
          io: File.open(cover_path),
          filename: "cover.jpg",
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

    puts pastel.green("\n✓ Cover attachment process completed!")
    puts pastel.cyan("\n▶ Results:")
    puts pastel.cyan("  • Processed #{total_files} cover files")
    puts pastel.green("  • Successfully attached: #{total_attached}")
    puts pastel.cyan("  • Already attached (skipped): #{total_skipped}")
    puts pastel.yellow("  • Failed to process: #{total_failed}")
    $VERBOSE = original_verbose
    
  end
end