require 'ruby-progressbar'
require 'pastel'

namespace :movies do
  desc "Attach videos to all Movie records from downloaded files"
  task attach_videos: :environment do
    ActiveRecord::Base.logger.level = Logger::INFO
    original_verbose = $VERBOSE
    $VERBOSE = nil
    pastel = Pastel.new

    BASE_DIR = "public/demo_assets/media/videos"

    puts pastel.cyan("\n▶ Starting video import process...")

    json_path = "#{BASE_DIR}/video_ids.json"

    unless File.exist?(json_path)
      puts pastel.red("\n✗ Video IDs JSON file not found at #{json_path}")

      if !Dir.exist?("public/demo_assets")
        puts pastel.yellow("  ! Demo assets not found. Running assets:download task first...")
        Rake::Task["assets:download"].invoke

        unless File.exist?(json_path)
          puts pastel.red("  ✗ Video IDs file still not found after downloading assets")
          exit 1
        end
      else
        exit 1
      end
    end

    begin
      video_data = JSON.parse(File.read(json_path))
      puts pastel.cyan("  • Successfully parsed JSON data with #{video_data.keys.count} movies")
    rescue JSON::ParserError => e
      puts pastel.red("  ✗ Failed to parse JSON file: #{e.message}")
      exit 1
    end

    total_movies = video_data.keys.count
    total_videos_added = 0
    total_videos_skipped = 0
    total_errors = 0

    progress = ProgressBar.create(
      title: "Processing Movies",
      total: total_movies,
      format: "%t: |%B| %c/%u %p%% %e",
      output: $stdout
    )

    video_data.each do |movie_id, video_ids|
      movie = Movie.find_by(id: movie_id)

      if movie.nil?
        total_errors += 1
        progress.increment
        next
      end

      video_ids.each do |youtube_id|
        if movie.videos.exists?(url: youtube_id)
          total_videos_skipped += 1
          next
        end

        video = movie.videos.build(
          url: youtube_id
        )

        if video.save
          total_videos_added += 1
        else
          total_errors += 1
        end
      end

      progress.increment
    end

    puts pastel.green("\n✓ Video import process completed!")
    puts pastel.cyan("\n▶ Results:")
    puts pastel.cyan("  • Processed #{total_movies} movies")
    puts pastel.green("  • Added #{total_videos_added} videos")
    puts pastel.cyan("  • Skipped #{total_videos_skipped} existing videos")
    puts pastel.yellow("  • Encountered #{total_errors} errors")
    $VERBOSE = original_verbose
  end
end