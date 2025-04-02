require 'ruby-progressbar'
require 'pastel'

namespace :movies do
  desc "Purge all attachments (covers, backgrounds, posters, backdrops) and videos from all movies"
  task purge_attachments: :environment do
    ActiveRecord::Base.logger.level = Logger::INFO
    pastel = Pastel.new

    puts pastel.cyan("\n▶ Starting attachment purge process...")

    initial_counts = {
      covers: Movie.all.count { |m| m.cover.attached? },
      backgrounds: Movie.all.count { |m| m.background.attached? },
      posters: Movie.all.count { |m| m.posters.attached? },
      backdrops: Movie.all.count { |m| m.backdrops.attached? },
      total_posters: ActiveStorage::Attachment.where(name: 'posters').count,
      total_backdrops: ActiveStorage::Attachment.where(name: 'backdrops').count,
      videos: defined?(Video) ? Video.count : 0,
      total_storage: ActiveStorage::Blob.sum(:byte_size)
    }

    puts pastel.cyan("  • Initial state:")
    puts pastel.cyan("    - Movies with covers: #{initial_counts[:covers]}")
    puts pastel.cyan("    - Movies with backgrounds: #{initial_counts[:backgrounds]}")
    puts pastel.cyan("    - Movies with posters: #{initial_counts[:posters]} (#{initial_counts[:total_posters]} total poster files)")
    puts pastel.cyan("    - Movies with backdrops: #{initial_counts[:backdrops]} (#{initial_counts[:total_backdrops]} total backdrop files)")
    puts pastel.cyan("    - Total videos: #{initial_counts[:videos]}")
    puts pastel.cyan("    - Total storage used: #{(initial_counts[:total_storage].to_f / 1.megabyte).round(2)} MB")

    total_movies = Movie.count
    progress = ProgressBar.create(
      title: "Purging Attachments",
      total: total_movies,
      format: "%t: |%B| %c/%u %p%% %e",
      output: $stdout
    )

    Movie.find_each do |movie|
      # Purge all attachment types
      movie.cover.purge if movie.cover.attached?
      movie.background.purge if movie.background.attached?
      movie.posters.purge if movie.posters.attached?
      movie.backdrops.purge if movie.backdrops.attached?

      progress.increment
    end

    if defined?(Video)
      puts pastel.cyan("\n  ▶ Purging videos...")
      Video.delete_all
    end

    final_counts = {
      covers: Movie.all.count { |m| m.cover.attached? },
      backgrounds: Movie.all.count { |m| m.background.attached? },
      posters: Movie.all.count { |m| m.posters.attached? },
      backdrops: Movie.all.count { |m| m.backdrops.attached? },
      total_posters: ActiveStorage::Attachment.where(name: 'posters').count,
      total_backdrops: ActiveStorage::Attachment.where(name: 'backdrops').count,
      videos: defined?(Video) ? Video.count : 0,
      total_storage: ActiveStorage::Blob.sum(:byte_size)
    }

    puts pastel.green("\n✓ Attachment purge process completed!")
    puts pastel.cyan("\n▶ Results:")
    puts pastel.cyan("  • Purged from movies:")
    puts pastel.cyan("    - Covers: #{initial_counts[:covers] - final_counts[:covers]}")
    puts pastel.cyan("    - Backgrounds: #{initial_counts[:backgrounds] - final_counts[:backgrounds]}")
    puts pastel.cyan("    - Posters: #{initial_counts[:total_posters] - final_counts[:total_posters]} files from #{initial_counts[:posters]} movies")
    puts pastel.cyan("    - Backdrops: #{initial_counts[:total_backdrops] - final_counts[:total_backdrops]} files from #{initial_counts[:backdrops]} movies")
    puts pastel.cyan("    - Videos: #{initial_counts[:videos] - final_counts[:videos]}")

    storage_freed = (initial_counts[:total_storage] - final_counts[:total_storage]).to_f / 1.megabyte
    puts pastel.cyan("  • Storage freed: #{storage_freed.round(2)} MB")

    if final_counts.values.all?(&:zero?)
      puts pastel.green("  • All attachments successfully purged!")
    else
      puts pastel.yellow("  ! Warning: Some attachments may remain:")
      puts pastel.yellow("    - Remaining covers: #{final_counts[:covers]}")
      puts pastel.yellow("    - Remaining backgrounds: #{final_counts[:backgrounds]}")
      puts pastel.yellow("    - Remaining poster files: #{final_counts[:total_posters]}")
      puts pastel.yellow("    - Remaining backdrop files: #{final_counts[:total_backdrops]}")
      puts pastel.yellow("    - Remaining videos: #{final_counts[:videos]}")
    end
  end
end