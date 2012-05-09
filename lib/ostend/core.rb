module Ostend
  def ostend_accessors( hash )
    hash.each do |key,value|
      self.instance_variable_set("@#{key}", value)
      self.class.send(:attr_accessor, key)
    end
  end

  def ostend_readers( hash )
    hash.each do |key,value|
      self.instance_variable_set("@#{key}", value)
      self.class.send(:attr_reader, key)
    end
  end

  def ostend_writers( hash )
    hash.each do |key,value|
      self.instance_variable_set("@#{key}", value)
      self.class.send(:attr_writer, key)
    end
  end
end
