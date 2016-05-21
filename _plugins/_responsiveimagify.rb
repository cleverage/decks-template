class ResponsiveImageify < Jekyll::Converter
  priority :high

  def matches(ext)
    ext.downcase == ".md"
  end

  def convert(content)
    content.gsub(/\!\[(.+)\]\((.+) "(.+)"\)/, '{% img \2 alt:"\1" title:"\3" %}').gsub(/\!\[(.+)\]\((.+)\)/, '{% img \2 alt:"\1" %}')
  end
end
