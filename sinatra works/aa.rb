#!/usr/bin ruby
 class Army
   def name(name, place)
     @n=name
     @p=place
     puts "#{@n} is in #{@p}"
     end
   end
n= gets
n=n.chomp
p= gets
a=Army.new
a.name(n,p)
