class Class
  def get_subclass name
    name.is_a?(Class) ? ((name < self) && name) : (descendants.detect { |kla| kla.name == name })
  end

  def get_subclass! name
    get_subclass(name) || (raise "unknown subclass #{name.inspect} of #{self.name}")
  end
end
