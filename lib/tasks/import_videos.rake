# lib/tasks/import_videos.rake
namespace :movies do
  desc "Import videos from JSON file to the database"
  task import_videos: :environment do
    puts "Importing videos from JSON file..."

    # Path to the JSON file with video IDs
    json_path = "public/movie_media/videos/video_ids.json"

    unless File.exist?(json_path)
      puts "ERROR: Video IDs JSON file not found at #{json_path}"
      exit
    end

    # Load the JSON data
    begin
      video_data = JSON.parse(File.read(json_path))
      puts "Successfully parsed JSON data with #{video_data.keys.count} movies."
    rescue JSON::ParserError => e
      puts "ERROR: Failed to parse JSON file: #{e.message}"
      exit
    end

    # Track progress
    total_movies = video_data.keys.count
    total_videos_added = 0
    total_videos_skipped = 0
    total_errors = 0

    # Process each movie's videos
    video_data.each do |movie_id, video_ids|
      movie = Movie.find_by(id: movie_id)

      if movie.nil?
        puts "ERROR: Movie not found with ID: #{movie_id}"
        total_errors += 1
        next
      end

      puts "Processing videos for movie: #{movie.title} (ID: #{movie_id})"

      # Process each video ID for this movie
      video_ids.each_with_index do |youtube_id, index|
        # Skip if this video already exists
        if movie.videos.exists?(url: youtube_id)
          puts "  SKIPPED: Video with ID #{youtube_id} already exists for this movie"
          total_videos_skipped += 1
          next
        end

        # Create a new video using the association
        video = movie.videos.build(
          url: youtube_id  # Store just the YouTube ID
        )

        if video.save
          puts "  ADDED: Video #{index + 1} (#{youtube_id}) for #{movie.title}"
          total_videos_added += 1
        else
          puts "  ERROR: Failed to save video: #{video.errors.full_messages.join(', ')}"
          total_errors += 1
        end
      end
    end

    puts "\nVideo import completed!"
    puts "Processed #{total_movies} movies"
    puts "Added #{total_videos_added} videos"
    puts "Skipped #{total_videos_skipped} existing videos"
    puts "Encountered #{total_errors} errors"
  end
end