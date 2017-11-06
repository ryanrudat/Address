require_relative '../models/address_book'

class MenuController
  attr_reader :address_book

  def initialize
    @address_book = AddressBook.new
  end

  def main_menu

    puts "Main Menu - #{address_book.entries.count} entries"
    puts "1 - View all entries"
    puts "2 - Create an entry"
    puts "3 - Search for an entry"
    puts "4 - Import entries from CSV"
    puts "5 - Exit"
    print "Enter your selection: "

    selection = gets.to_i
    # puts "You pick #{selection}"

    # use a case statement operator to determin the proper responseto user's input
    case selection
      when 1
        system "clear"
        view_all_entries
        main_menu
      when 2
        system "clear"
        create_entry
        main_menu
      when 3
        system "clear"
        search_entries
        main_menu
      when 4
        system "clear"
        read_csv
        main_menu
      when 5
        puts "Good-bye!"

        # terminate the program (0) signals the program is exiting without an error
        exit(0)

        # to catch invalid user input and prompt the user to retry
      else
        system "clear"
        puts "Sorry, that is not a valid input"
        main_menu
      end
    end

      # stub the rest of the methods called in main_menu
    def view_all_entries

      # iterate through all entries in AddressBook using each
      address_book.entries.each do |entry|
        system "clear"
        puts entry.to_s

      # wel call entry_submenu to display a submenu for each entry,
      # then add this method at the bottom of MenuController
        entry_submenu(entry)
      end

      #
      system "clear"
      puts "End of entries"
    end

      # clear screen before displaying create entry prompts
    def create_entry
      system "clear"
      puts "New AddressBloc Entry"

      # use print to prompt the user for each Entry attribute
      print "Name: "
      name = gets.chomp
      print "Phone number: "
      phone = gets.chomp
      print "Email: "
      email = gets.chomp

      # add a new entry to address_book using add_entry to ensure
      # that the new entry is added in proper order
      address_book.address_book(name, phone, email)

      system "clear"
      puts "New entry created"
    end

    def search_entries

      print "Search by name: "
      name = gets.chomp

      match = address_book.binary_search(name)
      system "clear"

      if match
        puts match.to_s
        search_submenu(match)
      else
        puts "No match found for #{name}"
      end
    end

    def read_csv

      print "Enter CSV file to import: "
      file_name = gets.chomp

      if file_name.empty?
        system "clear"
        puts "No CSV file read"
        main_menu
      end

      begin
        entry_count = address_book.import_from_csv(file_name).count
        system "clear"
        puts "#{entry_count} new entries added from #{file_name}"
      rescue
        puts "#{file_name} is not a valid CSV file, please enter the name of a valid CSV file"
        read_csv
      end
    end

    def entry_submenu(entry)
      #display the submenu options
      puts "n - next entry"
      puts "d - delete entry"
      puts "e - edit this entry"
      puts "m - return to main menu"

      # `Chomp` removes any trailing whitespace from the string
      # `gets` returns
      selection = gets.chomp

      case selection
      # when the user asks to see the next entry
      # we can do nothing and control will be
      # returned to `view_all_entries`
      when "n"
      when "d"

        #when a user is viewing the submenu and they press "d", we call delete_entry.
        #After the entry is deleted, control will return to view_all_entries and the next entry will be displayed
        delete_entry(entry)
      when "e"

        #edit_entry when a user presses "e". We then display a sub-menu with
        #entry_submenu for the entry under edit
        edit_entry(entry)
        entry_submenu(entry)

      # return user to the main menu
      when "m"
        system "clear"
        main_menu
      else
        system "clear"
        puts "#{selection} is not a valid input"
        entry_submenu(entry)
      end
    end

    def delete_entry(entry)
      address_book.entries.delete(entry)
      puts "#{entry.name} has been deleted"
    end

    def edit_entry(entry)

      print "Updated name: "
      name = gets.chomp
      print "Updated phone number: "
      phone_number = gets.chomp
      print "Updated email: "
      email = gets.chomp

      entry.name = name if !name.empty?
      entry.phone_number = phone_number if !phone_number.empty?
      entry.email = email if !email.empty?
      system "clear"

      puts "Updated entry:"
      puts entry
    end

  end
