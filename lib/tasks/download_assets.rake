namespace :assets do
  desc "Download demo assets from remote server"
  task download: :environment do
    require 'pastel'

    ASSETS_REPO = "https://github.com/ersync/cinemad-assets.git"
    ASSETS_DIR = Rails.root.join('tmp', 'demo_assets')
    FINAL_DIR = Rails.root.join('public', 'demo_assets')

    pastel = Pastel.new

    puts pastel.cyan("\n▶ Checking for demo assets...")

    if Dir.exist?(ASSETS_DIR)
      puts pastel.yellow("  ! Removing temporary assets directory...")
      FileUtils.rm_rf(ASSETS_DIR)
    end
    
    if Dir.exist?(FINAL_DIR)
      puts pastel.yellow("  ! Removing existing demo assets...")
      FileUtils.rm_rf(FINAL_DIR)
    end

    puts pastel.cyan("\n▶ Downloading demo assets...")

    FileUtils.mkdir_p(Rails.root.join('tmp'))

    puts pastel.cyan("  ▶ Cloning assets repository...")
    success = system("git clone --depth=1 --single-branch #{ASSETS_REPO} #{ASSETS_DIR}")

    if success
      puts pastel.green("  ✓ Download complete")

      puts pastel.cyan("  ▶ Setting up asset directories...")
      FileUtils.mkdir_p(FINAL_DIR)
      FileUtils.cp_r(File.join(ASSETS_DIR, 'cast'), FINAL_DIR)
      FileUtils.cp_r(File.join(ASSETS_DIR, 'media'), FINAL_DIR)

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