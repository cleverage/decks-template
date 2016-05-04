class SlideMetaDataGenerator < Jekyll::Generator
  def generate(site)
    site.collections["slides"].docs.each do |slide|
      slide.data["depth"] = slide.relative_path.split('/').size
    end
  end
end
