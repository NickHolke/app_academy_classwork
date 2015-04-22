
class PolishCalculator
  attr_accessor :expressions

  def initialize
    @expressions = []
  end

  def prompt_input
    print "input something>>\t"
    expressions << gets.chomp
  end

  def rpn
    loop do
      prompt_input
      check_expressions
      puts expressions.map(&:to_s).join(" ")
    end
  end

  def check_expressions
    operators = ["+", "-", "*", "/"]
    if operators.include?(expressions.last)
      operator = expressions.pop
      numbers = expressions.pop(2)
      expressions << numbers.inject(&operator.to_sym)
    else
      expressions[-1] = expressions.last.to_i
    end
  end
end


calc = PolishCalculator.new
calc.rpn
