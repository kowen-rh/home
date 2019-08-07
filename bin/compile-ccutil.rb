#!/usr/bin/env observr

Signal.trap(:INT) { abort("\n") }

watch('.*/(.+)\.adoc$') do
  system('ccutil compile --lang en-US')
end
