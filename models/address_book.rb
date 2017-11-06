require_relative 'entry'
require "csv"

class AddressBook
  attr_reader :entries

  def initialize
    @entries = []
  end


  def add_entry(name, phone_number, email)
    puts "><><><>< #{name} - #{phone_number} - #{email}"
    index = 0
    @entries.each do |entry|

      if name < entry.name
        break
      end
      index += 1
    end

    @entries.insert(index, Entry.new(name, phone_number, email))

  end

  def remove_entry(name, phone, email)
    delete_entry = nil

    @entries.each do |entry|
      if name == entry.name && phone == entry.phone_number && email == entry.email
        delete_entry = entry
      end
    end
    @entries.delete(delete_entry)
  end

  def import_from_csv(file_name)

    csv_text = File.read(file_name)
    csv = CSV.parse(csv_text, headers: true, skip_blanks: true)

    csv.each do |row|
      row_hash = row.to_hash
      add_entry(row_hash["name"], row_hash["phone_number"], row_hash["email"])
    end
  end

  def binary_search(name)

      #save the index of the leftmost item in the array in a variable named lower
      #and the index of the rightmost item in the array in upper
    lower = 0
    upper = entries.length - 1

      #loop while our lower index is less than or equal to our upper index
    while lower <= upper

      #find the middle index by taking th sum of lower and upper and dividing it by two. Ruby will truncate any decimal number,
      # so if upper is five and lower is zero then mid will get set to two. Then we retrieve the name of the entry
      #at the middle index and store it in mid_name
      mid = (lower + upper) / 2
      mid_name = entries[mid].name

      #compare the name that we are searching for, name, to the name of the middle index, mid_name. We use == operator
      #when comparing the names which makes the search case sensitive
      if name == mid_name
        return entries[mid]
      elsif name < mid_name
        upper = mid - 1
      elsif name > mid_name
        lower = mid + 1
      end
    end

    return nil
  end


  def iterative_search(name)
    @entries.each do |item|
      if item.name == name
        return item
      end
    end
  return nil  
  end
end
