def get_name
  puts "file name?"
  gets.chomp
end

def open_and_shuffle(file_name)
  arr = []

  File.foreach (file_name) do |line|
    arr << line.chomp
  end
  arr.shuffle
end

def write(file_name, arr)
  File.open("#{file_name[0...-4]}-shuffled.txt", "w") do |f|
    arr.each do |line|
      f.puts line
    end
  end
end

def file_shuffler
  file_name = get_name
  arr = open_and_shuffle(file_name)
  write(file_name,arr)
end

file_shuffler
