require "nokogiri"

class SlideMetaDataGenerator < Jekyll::Generator
  def generate(site)
    parser = Jekyll::Converters::Markdown.new(site.config)
    #p site.collections
    site.collections.each do |key, collection|
      if key == "slides"
        collection.docs.each do |slide|

          # Get title from slide
          doc = Nokogiri::HTML(parser.convert(slide.content))

          xmlElement = doc.css('h1').first
          xmlElement = doc.css('h2').first unless xmlElement
          xmlElement = doc.css('h3').first unless xmlElement
          xmlElement = doc.css('h4').first unless xmlElement
          xmlElement = doc.css('h5').first unless xmlElement
          xmlElement = doc.css('h6').first unless xmlElement
          slide.data["title"] = xmlElement.content

          # Get depth from slide path
          arrayFilePath = slide.relative_path.split('/');
          slide.data["depth"] = arrayFilePath.size - 2
        end
      end
    end
  end
end
