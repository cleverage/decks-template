require "rubygems"
require "bundler/setup"
require "json"
require "yaml"

namespace :prebuild do

  task :test => ["test:doctor", "test:cursus", "test:decks", "test:slides"]

  namespace :test do

    desc "Executes the jekyll doctor"
    task :doctor do |t, args|
      jekyll("doctor")
    end

    desc "Test if the Front-Matter of cursus is YAML-valid"
    task :cursus do
      puts "#{test_folder('_cursus')} valid cursus"
    end

    desc "Test if the Front-Matter of decks is YAML-valid"
    task :decks do
      puts "#{test_folder('_decks')} valid decks"
    end

    desc "Test if the Front-Matter of slides is YAML-valid"
    task :slides do
      puts "#{test_folder('_slides')} valid slides"
    end

  end

  # launch jekyll
  def test_folder(folder)
    @items = []
    Dir.glob(folder + '/**/*.{md,markdown}').each do |p|
        @items << p
    end
    @items.each do |item|
      begin
        YAML.load_file(item)
      rescue Exception => e
        puts item.path
        puts e.message
        raise "Item syntax is not valid"
      end
    end
    @items.size
  end

  # launch jekyll
  def jekyll(directives = '')
    sh 'jekyll ' + directives
  end

end
