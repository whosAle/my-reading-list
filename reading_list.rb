class ReadingList
  def initialize
    # array to hold all of the users saved books
    @reading_list = [] 
  end

  def run_app
    puts "app is running"        
  end

end

rlist = ReadingList.new
rlist.run_app #starts the cli app