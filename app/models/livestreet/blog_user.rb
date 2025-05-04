# frozen_string_literal: true

module Livestreet
class BlogUser < BaseRecord
    self.primary_key = nil

    belongs_to :user, class_name: 'Livestreet::User'
    belongs_to :blog, class_name: 'Livestreet::Blog'
end
end
