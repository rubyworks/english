--- 
name: english
spec_version: 1.0.0
repositories: 
  public: git://github.com/rubyworks/english.git
title: English
contact: trans <transfire@gmail.com>
requires: 
- group: []

  name: language
  version: 0+
- group: 
  - build
  name: syckle
  version: 0+
resources: 
  code: http://github.com/rubyworks/english
  mail: http://groups.google.com/group/rubyworks-mailinglist
  host: http://rubygems.org/english
  home: http://rubyworks.github.com/english
suite: rubyworks
manifest: 
- .ruby
- lib/en.rb
- lib/english/censor.rb
- lib/english/class.rb
- lib/english/conjunction.rb
- lib/english/dresner.rb
- lib/english/infinitive.rb
- lib/english/inflect.rb
- lib/english/jumble.rb
- lib/english/metaphone.rb
- lib/english/mixin.rb
- lib/english/namecase.rb
- lib/english/numeral.rb
- lib/english/ordinal.rb
- lib/english/participle.rb
- lib/english/porter.rb
- lib/english/soundex.rb
- lib/english/words.rb
- lib/english.rb
- test/fixture/double_metaphone.txt
- test/fixture/metaphone.txt
- test/fixture/metaphone_lp.txt
- test/fixture/porter_stemming_input.txt
- test/fixture/porter_stemming_output.txt
- test/fixture/soundex.txt
- test/test_dresner.rb
- test/test_infinitive.rb
- test/test_inflect.rb
- test/test_metaphone.rb
- test/test_namecase.rb
- test/test_porter.rb
- test/test_soundex.rb
- Rakefile
- HISTORY.rdoc
- PROFILE
- LICENSE
- README.rdoc
- AUTHORS
- Gemfile
- NOTICE
- Syckfile
version: ""
licenses: 
- MIT
copyright: Copyright (c) 2007 Thomas Sawyer
description: English is an general purpose English language processing library. It includes a number of useful libraries, such as inflect.rb, metaphone.rb, ordinal.rb, and so on.
summary: English Code Kit
authors: 
- Thomas Sawyer
created: 2007-08-01
