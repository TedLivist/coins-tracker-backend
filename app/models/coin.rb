class Coin < ApplicationRecord
  belongs_to :user

  before_save { self.coin_id = coin_id.downcase }
end
