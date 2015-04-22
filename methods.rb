MOVES = ["rock", "paper", "scissors"]

def ai_move
  MOVES[rand(0..2)]
end

def compare(player_move, ai_move)
  state = %w(draw, lose, win)

  start = MOVES.index(player_move)
  (0..2).each do |i|
    if MOVES[(start+i) % 3] == ai_move
      return state[i]
    end
  end
end

def rps(move)
  ai = ai_move
  outcome = compare(move, ai)
  "#{ai.capitalize}, #{outcome.capitalize}"
end

5.times { p rps("paper") }

def remix(ingredients)
  arr = ingredients.clone

  alcohols = []
  mixers = []
  results = []

  arr.each do |sub_arr|
    alcohols << sub_arr.shift
    mixers << sub_arr.shift
  end

  mixers.shuffle!

  alcohols.length.times do
    sub = []
    sub << alcohols.shift
    sub << mixers.shift
    results << sub
  end

  results
end
#
# 10.times do
#     p remix([
#     ["rum", "coke"],
#     ["gin", "tonic"],
#     ["scotch", "soda"]
#     ])
# end
