class ReadingList
  def initialize
    # array to hold all of the users saved books
    @reading_list = [] 
  end

  def run_app
    # puts "app is running"  
    puts "Welcome to MyReadingList powered by Google Books"
    
    mode = view_add_exit

  end

  def view_add_exit    
    #top level menu that gives the user the option to add, view, or leave the app
    puts "Please Enter: \n1 to add to library \n2 to view your Reading List\n3 or to Exit"
    input = gets.chomp.to_i

    #a validation to ensure correct input
    while !(1..3).include?(input)
      puts "Please enter a valid number"
      input = gets.chomp.to_i
    end

    input   
  end

end

rlist = ReadingList.new
rlist.run_app #starts the cli app