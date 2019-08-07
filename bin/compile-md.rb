#!/usr/bin/env observr

verbose = !!ENV['VERBOSE']

Signal.trap(:INT) { abort("\n") }

watch('(.*).md') do |match|
  file = match[0]
  html = file.gsub(/md$/, 'html')
  system("pandoc -o #{html} #{file}")
  puts "#{file} -> #{html}" if verbose
end
