class Game < ActiveRecord::Base
  has_many :guesses, dependent: :destroy

  STATES = %w{ in_progress won lost }

  STATES.each do |state|
    define_method("#{state}?") do
      self.state == state
    end

    define_method("#{state}!") do
      self.update_attribute(:state, state)
    end
  end
end
