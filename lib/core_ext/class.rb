class Class
  def get_subclass name
    descendants.detect { |kla| kla.name == name }
  end

  def get_subclass! name
    get_subclass(name) || (raise "unknown subclass #{name.inspect} of #{self.name}")
  end
end
