module LevelOrder

  def level_order_iteration
    current = @root
    queue = [current]
    default_array = []
    until queue.empty?
      queue.unshift(current.left_child) unless current.left_child.nil?
      queue.unshift(current.right_child) unless current.right_child.nil?
      block_given? ? (yield queue.pop) : default_array << queue.pop.data
      current = queue.last
    end
    return default_array unless default_array.empty?
  end

  def level_order_recursion(current = @root, queue = [@root])
    return queue if current == queue.last && current.children?.zero?

    queue << (current.left_child) unless current.left_child.nil?
    queue << (current.right_child) unless current.right_child.nil?
    # current = queue[queue.index(current) + 1]
    level_order_recursion(queue[queue.index(current) + 1], queue)
    block_conditions(queue, current)
  end
end