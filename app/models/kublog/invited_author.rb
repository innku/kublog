module Kublog
  class InvitedAuthor < ActiveRecord::Base
    belongs_to :post
    validates_presence_of :name, :email
    validate :correct_email_format

    def to_s
      name
    end

    private

    def correct_email_format
      unless email.to_s.match /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
        errors.add(:email, :invalid)
      end
    end
  end
end
