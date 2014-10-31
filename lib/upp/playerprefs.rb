require "pp"
require "forwardable"

module Upp
  class PlayerPrefs
    extend Forwardable
  
    def_delegators :@player_prefs, :each
  
    def initialize
      @player_prefs = []
    end
  
    def list(name = nil)
      pp @player_prefs.select { |player_pref| player_pref[:name] =~ /#{name}/i }
    end
  
    def set(name, value)
      if index = find_index(name)
        @player_prefs[index][:value] = value
      else
        @player_prefs.push(:name => name, :value => value)
      end
    end
  
    def delete(name)
      @player_prefs.delete_if { |player_pref| player_pref[:name] == name }
    end
  
    private
  
    def find_index(name)
      @player_prefs.index { |player_pref| player_pref[:name] == name }
    end
  end
end