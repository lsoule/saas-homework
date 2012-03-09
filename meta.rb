# metaprogramming to the rescue!
class Numeric
  @@currencies = {'yen' => 0.013, 'euro' => 1.292, 'rupee' => 0.019, 'dollar' => 1.0}
  def method_missing(method_id, *arguments)
    if method_id.to_s == 'in'
      puts 'missing in ' + arguments.first.to_s
      singular_currency = arguments.first.to_s.gsub( /s$/, '')
      puts 'singular is ' + singular_currency.to_s
      if @@currencies.has_key?(singular_currency)
        self / @@currencies[singular_currency]
      else
        super
      end
    else
      puts 'missing ' + method_id.to_s
      singular_currency = method_id.to_s.gsub( /s$/, '')
      puts 'singular is ' + singular_currency.to_s
      if @@currencies.has_key?(singular_currency)
        self * @@currencies[singular_currency]
      else
        super
      end
    end
  end
end
puts 1.dollar.in(:rupees)
puts 10.rupees.in(:euro)
