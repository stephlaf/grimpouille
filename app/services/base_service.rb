# frozen_string_litteral: true

class ApplicationService
  def self.call(*args, &block)
    new(*args, &block).call
  end
end
