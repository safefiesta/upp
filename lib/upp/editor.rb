require "forwardable"

module Upp
  class Editor
    extend Forwardable
  
    def_delegators :@player_prefs, :list, :set, :delete
  
    def initialize(file_name = nil, options = {})
      @player_prefs = PlayerPrefs.new
      open(file_name) if file_name
      prompt if options[:prompt]
    end
  
    def open(file_name)
      if file_name
        @file_name = file_name
        Upp::File.open(file_name, "rb") do |file|
          if file.expected_header? && file.expected_version?
            @player_prefs = PlayerPrefs.new
            while !file.eof?
              player_pref = file.read_player_pref
              @player_prefs.set(player_pref[:name], player_pref[:value])
            end
          else
            puts "unexpected file"
          end
        end
      else
        puts "no input file specified"
      end
    end
  
    def save(file_name = @file_name)
      if file_name
        @file_name ||= file_name
        Upp::File.open(file_name, "wb") do |file|
          file.write_header
          file.write_version
          @player_prefs.each { |player_pref| file.write_player_pref(player_pref[:name], player_pref[:value]) }
        end
      else
        puts "no input file specified"
      end
    end
  
    def help
      puts <<-eos
        UPP Editor Command list
      
        help
        exit
      
        open <file_name>
        save [<file_name>]
      
        list [<key_name>]
        set <key_name>, <value>
        delete <key_name>, <value>
      eos
    end
  
    private
  
    def prompt
      print "> "
      if input = $stdin.gets
        begin
          eval(input.chomp)
        rescue Exception => ex
          if ex.message == "exit"
            exit
          else
            puts ex.message
          end
        end
        prompt
      else
        puts
      end
    end
  end
end