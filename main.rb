require_relative 'lib/environment.rb'

p tree = Tree.new(Array.new(5) { rand(1..100) })
p tree.balanced?
p tree.postorder
p tree.inorder
p tree.preorder
p tree.level_order_recursion
p tree.level_order_iteration

tree.insert(Node.new(105))
tree.insert(Node.new(110))
tree.insert(Node.new(115))
tree.insert(Node.new(120))
tree.insert(Node.new(125))
p tree.balanced?
tree = tree.rebalance
p tree.balanced?

p tree.delete(125)
p tree.find(120)
p tree.height



=begin 
node = Node.new(10)


tree.insert2(node)

p tree


 if target.left_child.nil? 
        data = target.right_child.data
        delete(data)
        target.data = data
      else
        target = target.left_child
        target.left_child = nil
      end
=end


 


