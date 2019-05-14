require_relative "nash.rb"

matrix = [[[0,1],[2,3],[1,20]], [[2,3],[1,1],[3,20]], [[1,1],[5,20],[2,20]]]
game = Game.new(matrix)
print matrix
puts " "
game.reduce
print game.matrix
