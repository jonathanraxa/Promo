#!/usr/bin/env ruby
# AUTHOR - Jonathan Raxa

require 'rubygems'
require 'roo'

xlsx = Roo::Spreadsheet.open('new.xlsx')
xlsx = Roo::Excelx.new("new.xlsx")


cids = Array.new(6)
tempOldPrices = Array.new(6)
oldPrices = Array.new(6)
your_file = ARGV[0]
oldAffid = ""
newAffid = ""
oldCulture = ""
newCulture = ""
newCid1 = ""
newCid2 = ""
newCid3 = ""
newPrice1 = ""
newPrice2 = ""
newPrice3 = ""
strikePrice1 = ""
strikePrice2 = ""
strikePrice3 = ""
newStrikePrice1 = ""
newStrikePrice2 = ""
newStrikePrice3 = ""
newSavePrice1 = ""
newSavePrice2 = ""
newSavePrice3 = ""
oldCountry = ""
newCountry = ""
oldPercentOff = ""
newPercentOff = ""

# NEED TO CHANGE NUMBERS TO STRINGS
newCid1.to_s
newCid2.to_s
newCid3.to_s

file = File.open(your_file)
txt = file.read()

# SPLITS CID AT "=" AND PUSHES NUMBER TO ARRAY
txt.scan(/cid=\d\d\d\d\d\d/) do |line|
    line.split("=")
    cids.push(line[4..9])
end

txt.scan(/affid=\d\d\d\d/) do |line|
     line.split("=")
     oldAffid = (line[6..9])
end

# FOR SOME REASON MATCH WORKS INSTEAD OF SCAN
txt.match(/culture=[a-zA-Z]{2}-[a-zA-Z]{2}/) do |line|
     newline = line.to_s.split("=")
     oldCulture = (newline[1])
end

# SCAN FOR PRICES
txt.scan(/[a-zA-Z]*[$]\d*.\d*/) do |line|
     newline = line.to_s.split("$")
     tempOldPrices.push(newline[1])
end

# TAKING THE COUNTRY INITIALS (ie. NZ)
txt.match(/[A-Z]*[$]\d*/) do |line|
     newline = line.to_s.split("$")
     oldCountry = (newline[0])
end

# PERCENT OFF
txt.scan(/\d\d%\s/) do |line|
  newline = line.to_s.split("%")
  oldPercentOff = (newline[0])
end

oldPrices = tempOldPrices.reject { |a| a.nil? }

oldPrice1 = oldPrices[0].gsub("<", "")
oldPrice2 = oldPrices[6].gsub("<", "")
oldPrice3 = oldPrices[9].gsub("<", "")

strikePrice1 = oldPrices[1].gsub("<", "")
strikePrice2 = oldPrices[5].gsub("<", "")
strikePrice3 = oldPrices[8].gsub("<", "")

oldSavePrice1 = oldPrices[4].gsub("<", "")
oldSavePrice2 = oldPrices[7].gsub("<", "")
oldSavePrice3 = oldPrices[10].gsub("<", "")

file.close

# CREATE AN ARRAY OF CIDS TO BE REPLACED
# not entirely necessary but may be useful for future use
temp_cids = cids.reject { |a| a.nil? }
puts
oldCid1 = temp_cids[1]
oldCid2 = temp_cids[2]
oldCid3 = temp_cids[3]

print "\n\n"

puts "MODIFYING FILE: #{your_file}\n\n"

print "_________________CURRENT VALUES_________________\n\n\n"


print "Current Country: #{oldCountry}\n\n"
print "Current Prices\n" + "#{oldPrice1}\n#{oldPrice2}\n#{oldPrice3}\n\n" 
print "Current MSRP Prices\n" + "#{strikePrice1}\n#{strikePrice2}\n#{strikePrice3}\n\n" 
print "Current AFFID: " + oldAffid + "\n\n" 
print "Current Culture: " + oldCulture.to_s + "\n\n"
print "Current CIDs\n" + "1) #{oldCid1}\n2) #{oldCid2}\n3) #{oldCid3}\n\n" 

print "_________________YOUR INPUTS_________________\n\n\n"

print "IF NO CHANGE TO VALUE, TYPE 'no' TO SKIP SECTION \n\n"

# DEFINE ALL THE OLD VALUES WITHIN THE PAGE WITH COUNTRY AND MONEY SYMBOL
oldSavePrice1 = oldCountry+"$"+oldSavePrice1
oldSavePrice2 = oldCountry+"$"+oldSavePrice2
oldSavePrice3 = oldCountry+"$"+oldSavePrice3

oldPrice1     = oldCountry+"$"+oldPrice1
oldPrice2     = oldCountry+"$"+oldPrice2
oldPrice3     = oldCountry+"$"+oldPrice3

strikePrice1  = oldCountry+"$"+ strikePrice1
strikePrice2  = oldCountry+"$"+ strikePrice2
strikePrice3  = oldCountry+"$"+ strikePrice3

puts


values = Hash.new
values['Price1']       = xlsx.cell(2,'B')
values['Price2']       = xlsx.cell(3,'B')
values['Price3']       = xlsx.cell(4,'B')
values['Culture'] 	   = xlsx.cell(2,'D')
values['CultureCode']  = xlsx.cell(2,'E')
values['Affiliate']    = xlsx.cell(2,'F')
values['CampaignID1']  = xlsx.cell(2,'G')
values['CampaignID2']  = xlsx.cell(3,'G')
values['CampaignID3']  = xlsx.cell(4,'G')
values['MSRP1']  	   = xlsx.cell(2,'C')
values['MSRP2']  	   = xlsx.cell(3,'C')
values['MSRP3']  	   = xlsx.cell(4,'C')

puts 
newCulture 		= values['CultureCode'].to_s
newAffid		= values['Affiliate'].to_s
newCountry 		= values['Culture'].to_s 
newPrice1 		= values['Price1'].to_s
newPrice2 		= values['Price2'].to_s
newPrice3 		= values['Price3'].to_s
newStrikePrice1 = values['MSRP1'].to_s
newStrikePrice2 = values['MSRP2'].to_s
newStrikePrice3 = values['MSRP3'].to_s
newCid1 		= values['CampaignID1'].to_s
newCid2 		= values['CampaignID2'].to_s
newCid3 		= values['CampaignID3'].to_s


# ALL THIS ORDEAL FOR A PERCENTAGE CALCULATION
if ( newStrikePrice1 == "" && newPrice1 == "" )


else
    newPercentOff = 0.0
    newPercentOff = [newPrice1.to_f / newStrikePrice1.to_f]*100
    newPercentOff = (newPercentOff[0]*10).round/10.0
    newPercentOff = newPercentOff*100
    newPercentOff = 100-newPercentOff
    newPercentOff = newPercentOff.to_i
    oldPercentOff = oldPercentOff.to_s+"%"+" "
    newPercentOff = newPercentOff.to_s+"%"+" "
    newSavePrice1 = newStrikePrice1.to_i - newPrice1.to_i

end

    # PRICE ON HOW MUCH YOU'LL BE SAVING
    if (newStrikePrice2 == "" && newPrice2 == "") then else newSavePrice2 = newStrikePrice2.to_i - newPrice2.to_i end
    if (newStrikePrice3 == "" && newPrice3 == "") then else newSavePrice3 = newStrikePrice3.to_i - newPrice3.to_i end
    if (newSavePrice1 == "") then else newSavePrice1 = newCountry+"$"+newSavePrice1.to_s end
    if (newSavePrice2 == "") then else newSavePrice2 = newCountry+"$"+newSavePrice2.to_s end
    if (newSavePrice3 == "") then else newSavePrice3 = newCountry+"$"+newSavePrice3.to_s end
    if (newPrice1 == "") then else newPrice1 = newCountry+"$"+newPrice1 end
    if (newPrice2 == "") then else newPrice2 = newCountry+"$"+newPrice2 end
    if (newPrice3 == "") then else newPrice3 = newCountry+"$"+newPrice3 end
    if (newStrikePrice1 == "") then else newStrikePrice1 = newCountry+"$"+newStrikePrice1 end
    if (newStrikePrice2 == "") then else newStrikePrice2 = newCountry+"$"+newStrikePrice2 end
    if (newStrikePrice3 == "") then else newStrikePrice3 = newCountry+"$"+newStrikePrice3 end



puts 

print "_________________NEW VALUES_________________\n\n\n"


if !newPrice1.empty? || !newPrice2.empty? || !newPrice3.empty? then print "New Prices: " + "\n" else end
if newPrice1.empty? then else puts "1) " + newPrice1 end
if newPrice2.empty? then else puts "2) " + newPrice2 end
if newPrice3.empty? then else puts "3) " + newPrice3 end

puts

if !newStrikePrice1.empty? || !newStrikePrice2.empty? || !newStrikePrice3.empty? then print "New MSRP: " + "\n" else end
if newStrikePrice1.empty? then else puts "1) " + newStrikePrice1 end
if newStrikePrice2.empty? then else puts "2) " + newStrikePrice2 end
if newStrikePrice3.empty? then else puts "3) " + newStrikePrice3 end

puts

if newAffid.empty? then else print "New AFFID: " + newAffid + "\n\n" end 
if newCulture.empty? then else print "New Culture: " + newCulture + "\n\n" end

if !newCid1.empty? || !newCid2.empty? || !newCid3.empty? then print "New CIDs: " + "\n" else end
if newCid1.empty? then else puts "1) " + newCid1 end
if newCid2.empty? then else puts "2) " + newCid2 end
if newCid3.empty? then else puts "3) " + newCid3 end

puts 


# WHERE ALL CIDs/AFFID/CULTURE CODES ARE REPLACED
files = Dir[your_file]
files.each do |filename|
  file_content = IO.read(filename)

    if newCid1         == "" then print "No change to CID #1\n" else file_content.gsub!(oldCid1,newCid1) end
    if newCid2         == "" then print "No change to CID #2\n" else file_content.gsub!(oldCid2,newCid2) end
    if newCid3         == "" then print "No change to CID #3\n" else file_content.gsub!(oldCid3,newCid3) end
    if newAffid        == "" then print "No change to AFFID\n" else file_content.gsub!(oldAffid,newAffid) end
    if newCulture      == "" then print "No change to CULTURE\n" else file_content.gsub!(oldCulture.to_s, newCulture.to_s) end
    if newPrice1       == "" then print "No change to PRICE #1\n" else file_content.gsub!(oldPrice1, newPrice1) end
    if newPrice2       == "" then print "No change to PRICE #2\n" else file_content.gsub!(oldPrice2, newPrice2) end
    if newPrice3       == "" then print "No change to PRICE #3\n" else file_content.gsub!(oldPrice3, newPrice3) end
    if newStrikePrice1 == "" then print "No change to MSRP #1\n" else file_content.gsub!(strikePrice1, newStrikePrice1) end
    if newStrikePrice2 == "" then print "No change to MSRP #2\n" else file_content.gsub!(strikePrice2, newStrikePrice2) end 
    if newStrikePrice3 == "" then print "No change to MSRP #3\n" else file_content.gsub!(strikePrice3, newStrikePrice3) end
    if newSavePrice1   == "" then else file_content.gsub!(oldSavePrice1, newSavePrice1) end
    if newSavePrice2   == "" then else file_content.gsub!(oldSavePrice2, newSavePrice2) end
    if newSavePrice3   == "" then else file_content.gsub!(oldSavePrice3, newSavePrice3) end
    if newPercentOff   == "" then else file_content.gsub!(oldPercentOff, newPercentOff) end

  output = File.open(filename,'w')
  output.write(file_content)
  output.close
end
exit