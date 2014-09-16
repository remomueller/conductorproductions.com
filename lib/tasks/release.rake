desc 'Create and rename assets'
task release: :environment do

  date_today = Date.today.strftime("%Y%m%d")

  puts "Removing public/assets folder..."

  FileUtils.rm_rf('public/assets')
  FileUtils.rm_rf("public/#{date_today}")

  puts "Compiling assets..."

  Rake::Task["assets:precompile"].invoke

  puts "Renaming application-*.js to application-#{date_today}.js"

  FileUtils.mv Dir.glob("public/assets/application-*.js").first, "public/assets/application-#{date_today}.js"

  puts "Renaming application-*.css to application-#{date_today}.css"

  FileUtils.mv Dir.glob("public/assets/application-*.css").first, "public/assets/application-#{date_today}.css"

  puts "Copying to release folder: #{date_today}"

  FileUtils.mkdir_p "public/#{date_today}/assets"

  FileUtils.cp_r 'public/assets', "public/#{date_today}"

  puts "Pruning unneeded files from release folder."

  FileUtils.rm Dir.glob("public/#{date_today}/assets/*.css.gz")
  FileUtils.rm Dir.glob("public/#{date_today}/assets/*.js.gz")
  FileUtils.rm Dir.glob("public/#{date_today}/assets/*.psd")
  FileUtils.rm Dir.glob("public/#{date_today}/assets/*.json")


  ['png', 'jpg', 'ico', 'woff', 'eot', 'svg', 'ttf'].each do |file_type|
    asset_files = Dir.glob("public/#{date_today}/assets/**/*.#{file_type}")
    puts "Removing hash from #{file_type.upcase} #{asset_files.count} file#{'s' if asset_files.count != 1}"

    asset_files.each do |file|
      FileUtils.mv file, file.gsub(/-[^-\/]*\.#{file_type}$/, ".#{file_type}")
    end
  end

  FileUtils.rm "public/#{date_today}/assets/news-work-lines.png"

end
