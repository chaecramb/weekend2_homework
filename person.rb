class Person
  attr_accessor :name

  def initialize(options= {})
    self.name = options.fetch(:name)
  end

end