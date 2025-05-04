# frozen_string_literal: true

module Livestreet
  class TopicContent < BaseRecord
    self.primary_key = :topic_id

    belongs_to :topic, class_name: 'Livestreet::Topic'
  end
end
