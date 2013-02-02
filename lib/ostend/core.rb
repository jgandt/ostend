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

  def ostend_create_attributes( hash )
    ostend_filterd_hash( hash ).each do |key,value|
      self.instance_variable_set("@#{key}", value)
      self.class.send("attr_#{@ostend_attr_type}", key)
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
