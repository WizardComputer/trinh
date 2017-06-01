class Order < ActiveRecord::Base
  belongs_to :account
  acts_as_sequenced scope: :account_id, column: :number

  before_save :set_number

  def set_number
    self.number = next_number
  end
end
