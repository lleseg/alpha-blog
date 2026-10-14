# frozen_string_literal: true

class User < ApplicationRecord
  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 25 }
  VALID_EMAIL_REGEX = /^(?!\.)(?!.*\.\.)([a-z0-9_'+\-\.]*)[a-z0-9_+\-]@([a-z0-9][a-z0-9\-]*\.)+[a-z]{2,}$/i
  validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 105 },
                    format: { with: VALID_EMAIL_REGEX }
end
