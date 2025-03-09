namespace :assets do
  desc "Download demo assets from remote server"
  task download: :environment do
    require 'pastel'

    ASSETS_REPO = "git@github.com:ersync/cinemad-assets.git"
    ASSETS_DIR = Rails.root.join('tmp', 'demo_assets')
    FINAL_DIR = Rails.root.join('public', 'demo_assets')

    pastel = Pastel.new

    puts pastel.cyan("\n▶ Checking for demo assets...")

    # Check if assets already exist and are complete
    if Dir.exist?(FINAL_DIR)
      # Check for specific media directories to ensure completeness
      media_dirs = ["media/covers", "media/backgrounds", "media/posters", "media/backdrops", "media/videos"]
      missing_dirs = media_dirs.select { |dir| !Dir.exist?("#{FINAL_DIR}/#{dir}") || Dir.empty?("#{FINAL_DIR}/#{dir}") }

      if missing_dirs.empty?
        puts pastel.green("  ✓ Assets already downloaded and complete")
        puts pastel.dim("    Use assets:force_download to refresh")
        next
      else
        puts pastel.yellow("  ! Some asset directories are missing or empty:")
        missing_dirs.each { |dir| puts pastel.yellow("    - #{dir}") }
        puts pastel.yellow("  ! Downloading complete assets...")

        # Remove incomplete assets
        FileUtils.rm_rf(FINAL_DIR)
      end
    else
      puts pastel.yellow("  ! Demo assets not found. Downloading...")
    end

    puts pastel.cyan("\n▶ Downloading demo assets...")

    # Create tmp directory if it doesn't exist
    FileUtils.mkdir_p(Rails.root.join('tmp'))

    # Clone repository with depth=1 for faster download (shallow clone)
    puts pastel.cyan("  ▶ Cloning assets repository...")
    success = system("git clone --depth=1 --single-branch #{ASSETS_REPO} #{ASSETS_DIR}")

    if success
      puts pastel.green("  ✓ Download complete")

      # Move files to their final locations
      puts pastel.cyan("  ▶ Setting up asset directories...")
      FileUtils.mkdir_p(FINAL_DIR)
      FileUtils.cp_r(File.join(ASSETS_DIR, 'cast'), FINAL_DIR)
      FileUtils.cp_r(File.join(ASSETS_DIR, 'media'), FINAL_DIR)

      # Cleanup git repository
      FileUtils.rm_rf(ASSETS_DIR)

      puts pastel.green("\n✓ Demo assets ready to use!")
    else
      puts pastel.red("\n✗ Error downloading assets")
      puts pastel.yellow("  Try running the task again or check your internet connection.")
    end
  end

  desc "Force redownload of demo assets"
  task force_download: :environment do
    require 'pastel'

    pastel = Pastel.new
    puts pastel.yellow("Removing existing demo assets...")

    FileUtils.rm_rf(Rails.root.join('public', 'demo_assets'))
    Rake::Task["assets:download"].invoke
  end
end