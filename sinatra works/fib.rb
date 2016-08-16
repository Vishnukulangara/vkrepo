#!/usr/bin ruby
fib_array=[0,1,1]
cur=1
prev=1
while cur<1000
  temp=cur+prev
  prev=cur
  cur=temp
  fib_array<<temp
  end
puts fib_array
