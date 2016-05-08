require "nokogiri"

class SlideMetaDataGenerator < Jekyll::Generator
  def generate(site)
    parser = Jekyll::Converters::Markdown.new(site.config)

		site.collections["cursus"].docs.each do |cursus|
      cursus.data["key"] = File.basename(cursus.relative_path, ".md")
			cursus.data["decks"] = []
		end

    site.collections["decks"].docs.each do |deck|
      arrayFilePath = deck.relative_path.split('/');
  		cursus_key = arrayFilePath[1];

      cursus = site.collections["cursus"].docs.find {|cursus| cursus.data["key"] == cursus_key}
      deck.data["cursus"] = cursus

      cursus.data["decks"].push(deck)

      deck.data["key"] = to_deck_absolute_key(cursus_key, File.basename(deck.relative_path, ".md"))
			deck.data["slides"] = []
    end

    site.collections["slides"].docs.each do |slide|

      basename = File.basename(slide.relative_path, ".md")

      # Get depth from slide path
      arrayFilePath = slide.relative_path.split('/');
      slide.data["depth"] = arrayFilePath.size - 3

      cursus_key = arrayFilePath[1];
		  slide.data["cursus"] = site.collections["cursus"].docs.find {|cursus| cursus.data["key"] == cursus_key}

      deck_key = to_deck_absolute_key(arrayFilePath[1], arrayFilePath[2])
      deck = site.collections["decks"].docs.find {|deck| deck.data["key"] == deck_key}
      slide.data["deck"] = deck
      deck.data["slides"].push(slide)

      # Get title from slide if not define in Front Matter
      if slide.data["has_deck_title"] == true
				slide.data["title"] = deck.data["title"]
			elsif slide.data["title"] == basename
      	doc = Nokogiri::HTML(parser.convert(slide.content))
	      xmlElement = doc.css('h1').first
	      xmlElement = doc.css('h2').first unless xmlElement
	      xmlElement = doc.css('h3').first unless xmlElement
	      xmlElement = doc.css('h4').first unless xmlElement
	      xmlElement = doc.css('h5').first unless xmlElement
	      xmlElement = doc.css('h6').first unless xmlElement
	      slide.data["title"] = xmlElement.content
			end
    end
  end
  def to_deck_absolute_key(cursus_self_key, deck_self_key)
    cursus_self_key + "-" + deck_self_key
  end
end
