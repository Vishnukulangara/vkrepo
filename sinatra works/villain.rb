#!/usr/bin ruby
class Viking
	attr_accessor :name, :age, :health, :attack, :wealth
    def initialize(name, age, health, attack, wealth)
        @@name = name
        @@age = age
        @@health = health
        @@attack = attack
        @@wealth = wealth
    end
    def attack
    	@@wealth += @@attack
    	puts "yeehaa"
    	puts @@wealth
    	puts @@name
    end
    def take_damage #(enemy)
    	#@@enemy=enemy
    	#@@health-=@@attack
    	puts "ouch"
    	puts @@health
   	end
    	
end

giant=Viking.new("giant",60,200,50,0)
wizard=Viking.new("wizard",30,300,30,0)
giant.attack
wizard.attack
wizard.take_damage
wizard.take_damage
wizard.health
