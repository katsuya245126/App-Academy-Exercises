class Queue
  def initialize
    @queue = []
  end

  def enqueue(ele)
    queue.unshift(ele)
  end

  def dequeue
    queue.shift
  end

  def peek
    queue[0]
  end

  private

  attr_accessor :queue
end
