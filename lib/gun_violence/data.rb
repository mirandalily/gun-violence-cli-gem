class GunViolence::Data

  attr_accessor :name, :url, :date, :state, :city, :deaths, :injured, :source

  def self.scrape_data_choice
    doc = Nokogiri::HTML(open("http://www.gunviolencearchive.org/reports"))
    @choices = []
    doc.css(".reports-list .depth-1 a").map do |a|
      data = self.new
      data.name = a.text
      data.url = "http://www.gunviolencearchive.org" << doc.search(".reports-list .depth-1 a").attr("href").value
      @choices << data
    end
    @choices.each.with_index(1) do |data, i|
    end
  end

  def self.data_from_choice(choice)
    doc = Nokogiri::HTML(open(choice))
    @occurances = []
    doc.xpath("//tr").each do |x|
      date = doc.css("td")[0].text
      state = doc.css("td")[1].text
      city = doc.css("td")[2].text
      deaths = doc.css("td")[4].text
      injured = doc.css("td")[5].text
      source = doc.search(".links li.last a").attr("href").value
      @occurances << {:date => date, :state => state, :city => city, :deaths => deaths, :injured => injured, :source => source}
    end
    @occurances
  end
end
