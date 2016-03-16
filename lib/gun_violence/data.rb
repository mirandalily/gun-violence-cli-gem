class GunViolence::Data

  attr_accessor :name, :url, :date, :state, :city, :deaths, :injured, :source

  def self.scrape_data_choice
    doc = Nokogiri::HTML(open("http://www.gunviolencearchive.org/reports"))
    choices = []
    doc.css(".reports-list .depth-1 a").map do |a|
      data = self.new
      data.name = a.text
      data.url = "http://www.gunviolencearchive.com" << doc.search(".reports-list .depth-1 a").attr("href").value
      choices << data
    end
    choices.each.with_index(1) do |data, i|
    end
  end

  def self.data_from_choice(data)
    doc = Nokogiri::HTML(open("http://www.gunviolencearchive.org/#{data.url}"))
    occurances = []
    doc.css("tbody").map do |a|
      data = self.new
      data.date = doc.css("td")[0].text
      data.state = doc.css("td")[1].text
      data.city = doc.css("td")[2].text
      data.deaths = doc.css("td")[4].text
      data.injured = doc.css("td")[5].text
      data.source = doc.search(".links li.last a").attr("href").value
      occurances << data
    end
    occurances.each do |data|
    end
  end
end
