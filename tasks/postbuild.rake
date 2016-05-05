require "rubygems"
require "bundler/setup"
require "json"
require "yaml"

namespace :postbuild do

  task :test => ["test:kiss"]

  namespace :test do

    desc "Test if generated website is valid (do not test external links)"
    task :kiss do
      htmlproofer('--disable-external --empty-alt-ignore true')
    end

    desc "Test the generated website external links"
    task :externals do
      htmlproofer('--empty-alt-ignore true')
    end

    desc "Test the generated website alt messages on images"
    task :alt do
      htmlproofer('--disable-external')
    end

    # launch jekyll
    def htmlproofer(directives = '')
      sh 'htmlproofer ./_site ' + directives + ' --file-ignore /./_site/assets/revealjs/*/'
    end

  end

end
