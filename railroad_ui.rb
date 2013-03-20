require 'sqlite3'
require './lib/road'
DB = SQLite3::Database.open( "railroad" )
DB.results_as_hash = true


def welcome
  puts "Welcome!"
  menu
end

def menu
  choice = nil
  until choice == 'e'
    puts "Press 'l' to list lines or stations, 'a' to add a line or station "
    puts "Press 'e' to exit."
    choice = gets.chomp
    case choice
      when 'l'
        Road.new.look
      when 'a'
        Road.new.add
      when 'e'
        exit
      else
        invalid
    end
  end
end

def list
  Task.new.all
end

def invalid
  puts "Invalid value!!!"
end

welcome
