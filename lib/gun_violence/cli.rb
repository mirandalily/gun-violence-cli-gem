class GunViolence::CLI

  def call
    list_violence_categories
    menu
  end

  def list_violence_categories
    puts "Current Gun Violence Events in the United States"
    @data = GunViolence::Data.scrape_data_choice
    @data.each.with_index(1) do |data, i|
      puts "#{i}. #{data.name}"
    end
    @choice_data = GunViolence::Data.data_from_choice(@data)
    @choice_data.each do |data|
      puts "Date: #{data.date}, State: #{data.state}, City/County: #{data.city}, Deaths: #{data.deaths}, Injured: #{data.injured}, Source Link: #{data.source}"
    end
    binding.pry
  end

  def menu
    input = nil
    while input != "exit"
      puts "Enter the number of the data you would like to see, type 'list' to view the menu again, or type 'exit':"
      input = gets.strip.downcase

      if input.to_i > 0
        the_data = @data[input.to_i-1]
        data_details = @choice_data
        puts "#{the_data.name}"
        puts "#{data_details}"
      elsif input == "list"
        list_violence_categories
      elsif input == "exit"
        goodbye
      else
        puts "Not sure what you want, please type your choice again."
      end
    end
  end

  def goodbye
    puts "Data is always changing, come back anytime to see more."
  end

end
