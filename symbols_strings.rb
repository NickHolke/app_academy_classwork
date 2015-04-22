def super_print(str, options={})
  defaults = {
    times: 1,
    upcase: false,
    reverse: false
  }

  options = defaults.merge(options)

  str = str.upcase if options[:upcase]
  str = str.reverse if options[:reverse]
  options[:times].times do
    puts str
  end
end

super_print("Hello", :times => 3, :upcase => true, :reverse => true)
