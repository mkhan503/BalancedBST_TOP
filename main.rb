require_relative 'lib/environment.rb'

tree = Tree.new((Array.new(15) { rand(1..100) }))
tree.pretty_print

puts "Balanced? #{tree.balanced?}"
puts "Level order traversal: #{tree.level_order_iteration}"
puts "Pre order traversal: #{tree.preorder}"
puts "In order traversal: #{tree.inorder}"
puts "Post order traversal: #{tree.postorder}"
puts 'Inserting nodes to unbalance tree'

tree.insert(110)
tree.insert(115)
tree.insert(120)
tree.insert(125)
tree.insert(130)
tree.insert(135)
tree.pretty_print
puts "Balanced? #{tree.balanced?}"
puts"Rebalancing..."

tree.rebalance
tree.pretty_print
puts "Balanced? #{tree.balanced?}"
puts "Level order traversal: #{tree.level_order_iteration}"
puts "Pre order traversal: #{tree.preorder}"
puts "In order traversal: #{tree.inorder}"
puts "Post order traversal: #{tree.postorder}"


