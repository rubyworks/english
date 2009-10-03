module English

  # = English::String
  #
  class String < ::String
    #
    def self.instance(string)
      @cache ||= {}
      @cache[string] = new(string)
    end
    #
    def initialize(string)
      super()
      replace(string)
    end
  end

  # = English::Array
  #
  class Array < ::Array
    #
    def self.instance(array)
      @cache ||= {}
      @cache[array] = new(array)
    end
    #
    def initialize(string)
      super()
      replace(string)
    end
  end

  # TODO: How to handle?
  #class Integer < ::Integer
  #end

end

