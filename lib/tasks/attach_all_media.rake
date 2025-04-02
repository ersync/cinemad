namespace :movies do
  desc "Attach all media (covers, backgrounds, posters, backdrops, videos) to movies"
  task attach_all_media: :environment do
    original_verbose = $VERBOSE
    $VERBOSE = nil
    require 'pastel'
    pastel = Pastel.new

    ENV['VIPS_WARNING'] = 'disable'

    puts pastel.cyan.bold("\n=== STARTING COMPLETE MEDIA ATTACHMENT PROCESS ===\n")

    puts pastel.cyan("▶ Checking for required assets...")
    Rake::Task["assets:download"].invoke
    puts pastel.cyan("\n")

    def run_task(task_name)
      if Object.const_defined?(:BASE_DIR)
        old_base_dir = BASE_DIR
        Object.send(:remove_const, :BASE_DIR)
      end

      Rake::Task[task_name].invoke

      Rake::Task[task_name].reenable

      if Object.const_defined?(:BASE_DIR)
        Object.send(:remove_const, :BASE_DIR)
      end

      if defined?(old_base_dir)
        Object.const_set(:BASE_DIR, old_base_dir)
      end
    end

    run_task("movies:attach_cover")
    puts pastel.cyan("\n")

    run_task("movies:attach_background")
    puts pastel.cyan("\n")

    run_task("movies:attach_posters")
    puts pastel.cyan("\n")

    run_task("movies:attach_backdrops")
    puts pastel.cyan("\n")

    run_task("movies:attach_videos")
    puts pastel.cyan("\n")

    run_task("people:attach_images")


    puts pastel.green.bold("\n=== COMPLETE MEDIA ATTACHMENT PROCESS FINISHED ===")

    covers_count = Movie.all.count { |m| m.cover.attached? }
    backgrounds_count = Movie.all.count { |m| m.background.attached? }
    posters_count = Movie.all.count { |m| m.posters.attached? }
    backdrops_count = Movie.all.count { |m| m.backdrops.attached? }
    videos_count = defined?(Video) ? Video.count : 0
    people_images_count = Person.all.count { |p| p.image.attached? }


    total_posters = ActiveStorage::Attachment.where(name: 'posters').count
    total_backdrops = ActiveStorage::Attachment.where(name: 'backdrops').count

    puts pastel.cyan("\n▶ Final Attachment Summary:")
    puts pastel.cyan("  • Movies with covers: #{covers_count}")
    puts pastel.cyan("  • Movies with backgrounds: #{backgrounds_count}")
    puts pastel.cyan("  • Movies with posters: #{posters_count} (#{total_posters} total poster files)")
    puts pastel.cyan("  • Movies with backdrops: #{backdrops_count} (#{total_backdrops} total backdrop files)")
    puts pastel.cyan("  • Total videos: #{videos_count}")
    puts pastel.cyan("  • People with images: #{people_images_count}")

    total_size_bytes = ActiveStorage::Blob.sum(:byte_size)
    total_size_mb = (total_size_bytes.to_f / 1.megabyte).round(2)

    puts pastel.cyan("  • Total storage used: #{total_size_mb} MB")
    puts pastel.green("  • All attachments completed successfully!")
    $VERBOSE = original_verbose
  end
end