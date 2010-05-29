class English

  def self.present_participle(word)
    plural = plural_verb(word.to_s, 2)

    plural.sub!( /ie$/, 'y' ) or
      plural.sub!( /ue$/, 'u' ) or
      plural.sub!( /([auy])e$/, '$1' ) or
      plural.sub!( /i$/, '' ) or
      plural.sub!( /([^e])e$/, "\\1" ) or
      /er$/.match( plural ) or
      plural.sub!( /([^aeiou][aeiouy]([bdgmnprst]))$/, "\\1\\2" )

    return "#{plural}ing"
  end

  #alias_method :part_pres, :present_participle

end

