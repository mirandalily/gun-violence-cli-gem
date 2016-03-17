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
  end

  def menu
    input = nil
    while input != "exit"
      puts "Enter the number of the data you would like to see, type 'list' to view the menu again, or type 'exit':"
      input = gets.strip.downcase

      if input.to_i > 0
        the_data = @data[input.to_i-1]
        puts "#{the_data.name}"
        @choice_data = GunViolence::Data.data_from_choice(the_data.url)
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
