#!/usr/bin ruby -w
class House
   attr_accessor :type
   def initialize( k )
      @type = k
      @size="big"
   end
end
   
aa=House.new "concrete"
puts aa.type
   	

