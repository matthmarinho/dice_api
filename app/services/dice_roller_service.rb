class DiceRollerService
  def self.roll(expression)
    return nil unless expression.match?(/^(?:vant |desv )?\d*d\d+(?:[+-]\d+)?(?: vant| desv)?$/)

    advantage = expression.include?("vant")
    disadvantage = expression.include?("desv")
    expression = expression.gsub(/(?:vant|desv)\s?/, "").strip

    modifier_match = expression.match(/([+-]\d+)$/)
    pp modifier_match
    math_operator = modifier_match ? modifier_match[1][0] : "+"
    modifier = modifier_match ? modifier_match[1][1..-1].to_i : 0

    expression = expression.gsub(/([+-]\d+)$/, "").strip
    parts = expression.split(/d/)
    num_dice = parts[0].empty? ? 1 : parts[0].to_i
    dice_sides = parts[1].to_i

    rolls = if advantage || disadvantage
              Array.new(2) { Array.new(num_dice) { rand(1..dice_sides) } }
    else
              [ Array.new(num_dice) { rand(1..dice_sides) } ]
    end

    best_or_worst = if advantage
                      rolls.max_by(&:sum)
    elsif disadvantage
                      rolls.min_by(&:sum)
    else
                      rolls.first
    end

    total = best_or_worst.sum.method(math_operator).(modifier)

    { expression: expression, rolls: rolls, best_or_worst: best_or_worst, modifier: modifier_match ? modifier_match[1] : "", total: total }
  end
end
