class Queue
  attr_reader :queue

  def initialize
    @queue = []
  end

  def enqueue(el)
    queue << el
  end

  def dequeue
    queue.shift
  end

  def peek
    queue.first
  end
end