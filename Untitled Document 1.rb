#!/usr/bin ruby
i=0
n=10
while i<n do
	obj=Reservation.new
	obj.name="guest1"
	obj.frm_date="21-06-2016"
	obj.to_date="28-06-2016"
	a=[]<<[obj.name,obj.frm_date,obj.to_date]
	i++
 end
