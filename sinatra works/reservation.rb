#!/usr/bin ruby
class Reservation
	attr_accessor :name 
	attr_accessor :frm_date 
	attr_accessor :to_date
	require "date"
	
end
a=[]
i=0
while i<10 do
	obj=Reservation.new
	obj.name="guest#{i+1}"
	require "date"
	obj.frm_date=Date.new(2016,06,22)+(2*i)
	obj.to_date=Date.new(2016,06,26)+(2*i)
	a<<[obj.name,obj.frm_date,obj.to_date]
	i=i+1
	end


fd_new = ARGV[0]
td_new = ARGV[1]

i=0
while i<10 do 
	if(a[i][2]>=Date.strptime(fd_new,"%Y%m%d") && a[i]     [1]<=Date.strptime(td_new,"%Y%m%d"))
		puts a[i]
	end
	i=1+i
end

