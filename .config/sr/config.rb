require 'sr/input/readline'

%w(. lib).map! { |path| File.expand_path(path) }.each do |path|
  $LOAD_PATH.unshift(path) unless $LOAD_PATH.include?(path)
end

module Kernel
  %i(bind repl reset_binding unbind).each do |method|
    define_method(method) { |*args| ::SR.send(method, *args) }
  end

  def reset() exec($0) end
end

srrc = "#{Dir.pwd}/.srrc"
load srrc if File.exist?(srrc)
