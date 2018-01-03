#!/usr/bin/ruby

directory = ""
arg2 = "" 
arg3 = ""
answer = ""
answer2 = ""
currentPromo = ""
newPromo = ""
currentPromoContext = ""
newPromoContext = ""
promo = false

# GET USER INPUT
print "Directory name: "
directory = $stdin.gets.chomp()


#CHECK IF ARGUMENT IS A DIRECTORY
if (File::directory?( directory ))
  print "Success, processing directory: " + directory
else
  print "Sorry, not a directory"
end

puts 

# ASK FOR PROMO
print "Are you changing a PROMO code? (y/n): "
answer =  $stdin.gets.chomp()
if answer == "y"
	promo = true
end

# HANDLE FOR PROMO CODES
if (promo == true)

	print "Current PROMO: "
	currentPromo = $stdin.gets.chomp()
	currentPromo = currentPromo.upcase

	print "New PROMO: "
	newPromo = $stdin.gets.chomp()
	newPromo = newPromo.upcase
	
	currentPromoContext = "name=\"promo\" value=\""+ currentPromo +"\""
    newPromoContext 	= "name=\"promo\" value=\""+ newPromo +"\""
    
    currentCommentPromoCode = "<!--promocode-->" + currentPromo
    newCommentPromoCode = "<!--promocode-->"+ newPromo

    currentPromo = "promo="+currentPromo
    newPromo = "promo="+newPromo


	# GLOB files handled: txt,cfm,html,asp,js,php
	Dir.glob(directory+"**/**/*.{txt,cfm,html,asp,js,php}") do |file|
		puts "Searching: #{file}"
		
		File.open(file) { |source_file|
			contents = source_file.read
		 	contents.gsub!(currentPromo, newPromo)
		 	contents.gsub!(currentPromoContext, newPromoContext)
		 	contents.gsub!(currentCommentPromoCode, newCommentPromoCode)
			File.open(file, "w+") { |f| f.write(contents) }

		} # end file-open 
	end # end Dir.glob

puts "\n\n__________________NEW VALUES____________________\n\n"
    puts "Replaced: " + currentPromo
    puts "Replaced with: " + newPromo
    puts "Replaced: " + currentPromoContext
    puts "Replaced with: " + newPromoContext
    puts "Replaced: " + currentCommentPromoCode
    puts "Replaced with: "+newCommentPromoCode

	puts
	
	print "Do you want to replace more items? (y/n): "
	answer2 =  $stdin.gets.chomp()

end 

if (answer2 == "n")
	abort("\nAll finished Sir/Mam!")
end

puts

# GENERAL REPLACEMENT
print "To Replace: "
arg2 = gets.chomp()

print "Replace With: "
arg3 = gets.chomp()



# GLOB files handled: txt,cfm,html,asp,js,php
Dir.glob(directory+"**/**/*.{txt,cfm,html,asp,js,php}") do |file|
	puts "Searching: #{file}"
	
	File.open(file) { |source_file|
		contents = source_file.read
	 	contents.gsub!(arg2, arg3)
		File.open(file, "w+") { |f| f.write(contents) }
		
	} # end file-open 
end # end Dir.glob

abort("\nAll finished Sir/Mam!")

