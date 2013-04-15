# An enumeration of game status
class GameStatusEnum
  def self.created
    'created'
  end

  def self.started
    'started'
  end

  def self.paused
    'paused'
  end

  def self.finished
    'finished'
  end

  def self.all
    %w(created started paused finished)
  end
end