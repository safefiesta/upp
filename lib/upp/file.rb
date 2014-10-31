module Upp
  class File < ::File
    HEADER = "UnityPrf"
    VERSION1 = 0x10000
    VERSION2 = 0x100000
    TYPE_STRING = 0x80
    TYPE_FLOAT = 0xFD
    TYPE_INT = 0xFE
  
    def expected_header?
      header = read(HEADER.length)
      header == HEADER
    end

    def expected_version?
      version1 = read_int
      version2 = read_int
      version1 == VERSION1 && version2 == VERSION2
    end
  
    def read_byte
      read(1).unpack("C").first
    end
  
    def read_float
      read(4).unpack("F").first
    end
  
    def read_int
      read(4).unpack("V").first
    end
 
    def read_player_pref
      name_length = read_byte
      name = read(name_length)
      type = read_byte
      if type < TYPE_STRING
        value = read(type)
      elsif type == TYPE_STRING
        length = read_int
        value = read(length)
      elsif type == TYPE_FLOAT
        value = read_float
      elsif type == TYPE_INT
        value = read_int
      else
        return nil
      end
      { :name => name, :value => value }
    end
  
    def write_header
      write(HEADER)
    end
  
    def write_version
      write_int(VERSION1)
      write_int(VERSION2)
    end
  
    def write_byte(value)
      write([value].pack("C"))
    end
  
    def write_float(value)
      write([value].pack("F"))
    end
  
    def write_int(value)
      write([value].pack("V"))
    end
  
    def write_player_pref(name, value)
      write_byte(name.length)
      write(name)
      type = value.class
      if type == String
        if value.length < 128
          write_byte(value.length)
        else
          write_byte(TYPE_STRING)
          write_int(value.length)
        end
        write(value)
      elsif type == Float
        write_byte(TYPE_FLOAT)
        write_float(value)
      elsif type == Fixnum
        write_byte(TYPE_INT)
        write_int(value)
      end
    end
  end
end