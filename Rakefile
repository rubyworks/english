#!/usr/bin/env ruby

desc 'generate rdocs'
task :rdoc do
  cmd = %[rdoc --op=doc/rdoc --title="English" --main=README --merge --inline-source [A_Z]* lib]
  sh cmd
end

desc 'run tests'
task :test do
  unless EVN['LIVE']
    $LOAD_PATH.unshift(File.expand_path('lib'))
  end

  puts "Ruby Version: #{RUBY_VERSION}"

  #if find = ARGV.select{|e| e !~ /^[-]/ }[0]
  #  unless File.file?(find)
  #    find = File.join(find, '**', 'test_*.rb')
  #  end
  #else
    find = 'test/**/test_*.rb'
  #end

  files = Dir.glob(find)
  files.each do |file|
    next if File.directory?(file)
    begin
      puts "Loading: #{file}" if $DEBUG
      load(file)
    rescue LoadError
      puts "Error loading: #{file}"
    end
  end
end

