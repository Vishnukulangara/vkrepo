#!/usr/bin ruby
n=ARGV[0].to_i
i=1
fact=1
while i<=n
  fact*=i
  i+=1
end  
puts fact
puts "#{fact}".length
