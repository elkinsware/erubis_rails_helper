Dir.glob("template/*_test.rb").sort.each do |file_path|
  puts "#{file_path}\n"
  require file_path
end