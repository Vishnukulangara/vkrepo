class Viking
	attr_accessor :name, :health, :age, :strength
    def initialize(name, health, age, strength)
    	@n=name
    	@h=health
    	@a=age
    	@s=strength
    end
    def group
    	a=[]<<@n<<@s<<@a<<@h
    	puts a
    end
end
n=gets
h=gets
a=gets
s=gets
giant=Viking.new(n,h,a,s)
giant.group
