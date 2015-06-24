class Game < ActiveRecord::Base
  has_many :guesses, dependent: :destroy

  STATES = %w{ in_progress won lost }

  validates :state, inclusion: { in: STATES, message: "'%{value}' is not a valid state" }

  STATES.each do |state|
    define_method("#{state}?") do
      self.state == state
    end

    define_method("#{state}!") do
      self.update_attribute(:state, state)
    end
  end
end
