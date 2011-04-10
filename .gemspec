--- !ruby/object:Gem::Specification 
name: english
version: !ruby/object:Gem::Version 
  hash: 0
  prerelease: false
  segments: []

  version: ""
platform: ruby
authors: 
- Thomas Sawyer
autorequire: 
bindir: bin
cert_chain: []

date: 2011-04-10 00:00:00 -04:00
default_executable: 
dependencies: 
- !ruby/object:Gem::Dependency 
  version_requirements: &id001 !ruby/object:Gem::Requirement 
    none: false
    requirements: 
    - - ">="
      - !ruby/object:Gem::Version 
        hash: 3
        segments: 
        - 0
        version: "0"
  requirement: *id001
  prerelease: false
  type: :runtime
  name: language
description: English is an general purpose English language processing library. It includes a number of useful libraries, such as inflect.rb, metaphone.rb, ordinal.rb, and so on.
email: transfire@gmail.com
executables: []

extensions: []

extra_rdoc_files: 
- README.rdoc
files: 
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
has_rdoc: true
homepage: http://rubyworks.github.com/english
licenses: 
- MIT
post_install_message: 
rdoc_options: 
- --title
- English API
- --main
- README.rdoc
require_paths: 
- lib
required_ruby_version: !ruby/object:Gem::Requirement 
  none: false
  requirements: 
  - - ">="
    - !ruby/object:Gem::Version 
      hash: 3
      segments: 
      - 0
      version: "0"
required_rubygems_version: !ruby/object:Gem::Requirement 
  none: false
  requirements: 
  - - ">="
    - !ruby/object:Gem::Version 
      hash: 3
      segments: 
      - 0
      version: "0"
requirements: []

rubyforge_project: english
rubygems_version: 1.3.7
signing_key: 
specification_version: 3
summary: English Code Kit
test_files: 
- test/test_dresner.rb
- test/test_infinitive.rb
- test/test_inflect.rb
- test/test_metaphone.rb
- test/test_namecase.rb
- test/test_porter.rb
- test/test_soundex.rb
