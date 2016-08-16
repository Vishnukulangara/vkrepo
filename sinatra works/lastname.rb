#!/usr/bin ruby 
names = ["John Smith", "Dan Boone", "Jennifer Jane", "Charles Lindy", "Jennifer Eight", "Rob Roy","Reby Roy","A B de Villiers"]
sorted=names.sort_by do |i|
  i.split(" ").reverse.join.upcase
end
puts sorted
