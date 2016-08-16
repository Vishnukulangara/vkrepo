#!/usr/bin ruby
class Subs
  def sub(x,y)
	@x=x
	@y=y
	@diff=x-y
	puts @diff
  end
end
a=gets
b=gets
a=a.to_i
b=b.to_i
first=Subs.new
first.sub(a,b)
