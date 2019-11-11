require 'JSON'
require 'rest-client'
require 'pry'

class ReadingList
  def initialize
    # array to hold all of the users saved books
    @reading_list = [] 
    @API = GBooksAPI.new
  end

  def run_app
    # puts "app is running"  
    puts "Welcome to MyReadingList powered by Google Books"
    
    mode = view_add_exit

    while mode != 3
      if mode == 1
        add_to_list
      elsif mode == 2
        view_list
      end

      #updates mode to the user's desired path
      mode = view_add_exit
    end

    puts "Closing app. Thanks for using."
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

  def add_to_list
    print "Enter query to find book: "
    query = gets.chomp

    results = @API.query_book(query)
    # binding.pry
    puts "Enter the number of the book you want to add to your list"

    results.each_with_index { |book, i| print_book(book, i) }

    book_selection = nil
    #validation
    while !(1..5).include?(book_selection)
      print "Please enter the number of book you want to add: "
      book_selection = gets.chomp.to_i
    end

    # add book to reading list
    @reading_list << results[book_selection-1]
    
    puts "#{results[book_selection-1]['volumeInfo']['title']} has been added to your Reading List"

  end

  def view_list

  end

  def print_book(book, i)
    # binding.pry
    puts "#{i+1}."
    puts "\tTitle: #{book['volumeInfo']['title'] ? book['volumeInfo']['title'] : "N/A"}"
    # puts "\tAuthor: #{book['volumeInfo']['authors'].first}"
    puts "\tAuthor: #{book['volumeInfo']['authors'] ? book['volumeInfo']['authors'].first : "N/A"}"

    # book['volumeInfo']['authors'] ? puts "\tAuthor: #{book['volumeInfo']['authors'].first}" : puts "\t Authors: N/A"
    puts "\tPublishing Company: #{book['volumeInfo']['publisher'] ? book['volumeInfo']['publisher'] : "N/A"}"
  end

end

#API Class Handler
class GBooksAPI

  def initialize
    @url = "https://www.googleapis.com/books/v1/volumes?q="
  end
  
  def query_book(query)
    #returns the top 5 books based on the api response
    formatted_query = formatter(query)
    JSON.parse(RestClient.get(@url+formatted_query+@key))['items'][0..4] #returns the top 5 results
    # puts @url+formatted_query+@key
  end

  def formatter(query)
    #replaces any spaces between words with a plus(+) to adhere to google's api requirements
    query.gsub(/\s+/,"+")
  end
end

rlist = ReadingList.new
rlist.run_app #starts the cli app