module CucumberRailsHelpers
  def gem(name, options)
    line = %{\ngem "#{name}", #{options.inspect}\n}
    append_to_file('Gemfile', line)
  end
end
World(CucumberRailsHelpers)

