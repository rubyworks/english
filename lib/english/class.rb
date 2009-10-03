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

  # Can't subclass b/c no #new.
  #
  class Integer #< ::Integer
    instance_methods{ |m| private m unless /^__/ =~ m.to_s }
    #
    def self.instance(integer)
      @cache ||= {}
      @cache[integer] = new(integer)
    end
    #
    def initialize(integer)
      @integer = integer
    end
    #
    def to_i
      @integer
    end
    #
    def method_missing(s,*a,&b)
      @integer.__send__(s,*a,&b)
    end
  end

end

