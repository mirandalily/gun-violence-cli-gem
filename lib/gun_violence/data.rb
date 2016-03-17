class GunViolence::Data

  attr_accessor :name, :url, :date, :state, :city, :deaths, :injured, :source, :link

  def self.scrape_data_choice
    doc = Nokogiri::HTML(open("http://www.gunviolencearchive.org/reports"))
    @choices = []
    doc.css(".reports-list .depth-1 a").map do |a|
      data = self.new
      data.name = a.text
      data.link = a.values
      data.url = "http://www.gunviolencearchive.org#{data.link[0]}"
      @choices << data
    end
    @choices.each.with_index(1) do |data, i|
    end
  end

  def self.data_from_choice(choice)
    doc = Nokogiri::HTML(open(choice))
    @occurances = []
    doc.xpath('//tr').each do |x|
      data = self.new
      data.date = x.xpath("td//text()")[0]
      if data.date.class == String
        data.date = data.date.text
      end
      data.state = x.xpath("td//text()")[1]
      if data.state.class == String
        data.state = data.state.text
      end
      data.city = x.xpath("td//text()")[2]
      if data.city.class == String
        data.city = data.city.text
      end
      data.deaths = x.xpath("td//text()")[4]
      if data.deaths.class == String
        data.deaths = data.deaths.text
      end
      data.injured = x.xpath("td//text()")[5]
      if data.injured.class == String
        data.injured = data.injured.text
      end
      data.source = x.xpath("td//a//@href")
      if data.source.class == String
        data.source = data.source.value
      end
      @occurances << data
    end
    @occurances.each.with_index(1) do |event, i|
      puts "#{i}. Date: #{event.date}, Location: #{event.city} #{event.state}, Deaths: #{event.deaths}, Injured: #{event.injured}, Source: #{event.source}

      "
    end
  end
end

#GunViolence::Data.data_from_choice("http://www.gunviolencearchive.org/children-killed")
