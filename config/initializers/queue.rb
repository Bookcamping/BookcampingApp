class Queue
  def initialize
    @queue = []
  end

  def push(job)
    @queue.push(job)
  end

  def pop
    @queue.pop
  end

  def each(&block)
    @queue.each(&block)
  end

  def self.queue
    @@queue ||= Queue.new
  end
end
