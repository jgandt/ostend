module ObjectifyFromHash
  def objectify( hash )
    hash.each do |k,v|
      self.instance_variable_set("@#{k}", v)
      # tcocca was playing with this an noticed that manually defining the methods was both slow and silly. Thanks to Tom for this update: https://gist.github.com/tcocca
      # Use attr_accessor if you want to allow read-write privileges on the variables.
      self.class.send(:attr_accessor, key)

      # Use attr_reader if you only want to allow READ privileges on the variables.
      #self.class.send(:attr_reader, key)

      # Use attr_writer if you only want to allow WRITE privileges on the variables.
      #self.class.send(:attr_writer, key)

    end
  end
end

