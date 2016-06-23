#!/usr/bin ruby
class Reservation
	#attr_accessor :name,:frm_date, :to_date
	#attr_accessor :frm_date 
	#attr_accessor :to_date
	
end
a=[]
i=0
n=10
while i<n do
	obj=Reservation.new
	require "date"
	obj={("name"+(i+1).to_s) => ("guest"+(i+1).to_s), ("frm_date"+(i+1).to_s )=>(Date.new(2016,06,22)+(i)), ("to_date"(i+1).to_s) =>(Date.new(2016,06,26)+(i))}
	a << obj
	i=i+1
	end
