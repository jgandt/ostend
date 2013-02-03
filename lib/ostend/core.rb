module Ostend
  def self.included(base)
    base.send(:attr_writer, :ostend_attr_type)
    base.send(:attr_writer, :ostend_attr_filter)
    base.send(:attr_writer, :ostend_strict)
  end

  def ostendify( hash )
    @ostend_attr_type ||= :accessor
    @ostend_attr_filter ||= nil
    @ostend_strict ||= false

    ostend_raise_disallowed_attrs( hash ) if @ostend_attr_filter && @ostend_strict
    ostend_create_attributes( hash )
  end

  private

  def ostend_create_attributes( hash )
    ostend_filterd_hash( hash ).each do |key,value|
      temp_type = @ostend_attr_type
      self.instance_variable_set("@#{key}", value)
      # self.class.send("attr_#{@ostend_attr_type}", key)
      # I'm basically trying to do the above.
      #   However, there is an issue with the above send in that it modifies the core class
      #   We really want to access the instance's single class like below.
      #   I really want this to be simple but it end up being rediculous to modify the singleton class while honoring scoped variables
      #   To get everything I needed into scope I have to retrieve the singleton class
      #   and then class_eval on it.
      #   Also, instance vars don't evaluate so I had to create a temporary value which will properly scope in the class_eval block.
      #   Hlurg
      (class << self; self; end).class_eval do
        send("attr_#{temp_type}", key)
      end
    end
  end

  def ostend_filterd_hash( hash )
    return hash unless @ostend_attr_filter.respond_to?(:include?)
    hash.keep_if{|key, val| @ostend_attr_filter.include?( key ) }
  end

  def ostend_raise_disallowed_attrs( hash )
    disallowed_attrs = hash.delete_if{|key, val| @ostend_attr_filter.include?( key ) }
    return if disallowed_attrs.empty?
    raise "The following are not allowed attributes: #{disallowed_attrs}" 
  end

end
