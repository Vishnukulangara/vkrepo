#!/usr/bin ruby
class Reservation
	attr_accessor :name 
	attr_accessor :frm_date 
	attr_accessor :to_date
	
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

require "date"
def filtr(x,y)
	@fd=Date.strptime(x,"%Y%m%d")
	@td=Date.strptime(y,"%Y%m%d")
	puts @fd
	puts @td
	end	
#puts a
#b=Reservation.new
#b.filtr("20160626","20160701")
i=0
while i<10 do 
	if(a[i][2]>= #{@fd} && a[i][1]<= #{@td})
		puts a[i][0]
	end
	i=1+i
end
		
	
