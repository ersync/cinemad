require 'ruby-progressbar'
require 'pastel'

namespace :movies do
  desc "Attach backdrop images to all Movie records from downloaded files"
  task attach_backdrops: :environment do
    ActiveRecord::Base.logger.level = Logger::INFO
    original_verbose = $VERBOSE
    $VERBOSE = nil
    pastel = Pastel.new

    BASE_DIR = "public/demo_assets/media/backdrops"

    puts pastel.cyan("\n▶ Starting backdrop attachment process...")

    unless Dir.exist?(BASE_DIR)
      puts pastel.red("\n✗ Base directory not found: #{BASE_DIR}")

      if !Dir.exist?("public/demo_assets")
        puts pastel.yellow("  ! Demo assets not found. Running assets:download task first...")
        Rake::Task["assets:download"].invoke

        unless Dir.exist?(BASE_DIR)
          puts pastel.red("  ✗ Backdrop directory still not found after downloading assets")
          exit 1
        end
      else
        exit 1
      end
    end

    movie_dirs = Dir.glob("#{BASE_DIR}/*").select { |d| File.directory?(d) }

    if movie_dirs.empty?
      puts pastel.yellow("\n! No movie backdrop directories found in #{BASE_DIR}")
      exit 0
    end

    puts pastel.cyan("  • Found #{movie_dirs.count} movie directories")

    total_db_movies = Movie.count
    puts pastel.cyan("  • Total movies in database: #{total_db_movies}")

    db_movie_ids = Movie.pluck(:id)
    dir_movie_ids = movie_dirs.map { |dir| File.basename(dir).to_i }
    missing_dirs = db_movie_ids - dir_movie_ids

    if missing_dirs.any?
      puts pastel.yellow("  • Movies without backdrop directories: #{missing_dirs.count}")
      if missing_dirs.count <= 10
        puts pastel.yellow("    Missing IDs: #{missing_dirs.join(', ')}")
      else
        puts pastel.yellow("    First 10 missing IDs: #{missing_dirs.take(10).join(', ')}...")
      end
    end

    total_movies = movie_dirs.count
    total_attached = 0
    total_failed = 0
    total_skipped = 0
    total_backdrops = 0

    progress = ProgressBar.create(
      title: "Processing Movies",
      total: total_movies,
      format: "%t: |%B| %c/%u %p%% %e",
      output: $stdout
    )

    movie_dirs.each do |movie_dir|
      movie_id = File.basename(movie_dir)

      movie = Movie.find_by(id: movie_id)

      if movie.nil?
        total_failed += 1
        progress.increment
        next
      end

      backdrop_files = Dir.glob("#{movie_dir}/*.jpg")

      if backdrop_files.empty?
        progress.increment
        next
      end

      begin
        backdrop_count = 0
        backdrop_files.each do |backdrop_path|
          # Skip if this exact file is already attached
          filename = File.basename(backdrop_path)
          if movie.backdrops.any? { |b| b.filename.to_s == filename }
            total_skipped += 1
            next
          end

          movie.backdrops.attach(
            io: File.open(backdrop_path),
            filename: filename,
            content_type: 'image/jpeg'
          )
          backdrop_count += 1
        end

        if movie.save
          total_attached += 1
          total_backdrops += backdrop_count
        else
          total_failed += 1
        end
      rescue => e
        total_failed += 1
      end

      progress.increment
    end

    puts pastel.green("\n✓ Backdrop attachment process completed!")
    puts pastel.cyan("\n▶ Results:")
    puts pastel.cyan("  • Processed #{total_movies} movies")
    puts pastel.green("  • Successfully attached backdrops to #{total_attached} movies")
    puts pastel.green("  • Total backdrops attached: #{total_backdrops}")
    puts pastel.cyan("  • Already attached (skipped): #{total_skipped}")
    puts pastel.yellow("  • Failed to process: #{total_failed}")
    $VERBOSE = original_verbose
  end
end