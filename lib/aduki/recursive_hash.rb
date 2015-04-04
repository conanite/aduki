class RecursiveHash < Hash
  def []= key, value
    return super(key, value) unless key.is_a? String

    k0, k1 = key.split(/\./, 2)
    return super(key, value) if k1.nil?

    existing = self[k0]
    subhash = (existing.is_a? Hash) ? existing : RecursiveHash.new
    subhash[k1] = value
    super k0, subhash
  end
end