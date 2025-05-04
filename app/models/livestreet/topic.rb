# frozen_string_literal: true

module Livestreet
  class Topic < BaseRecord
    self.primary_key = :topic_id

    belongs_to :user, class_name: 'Livestreet::User'
    belongs_to :blog, class_name: 'Livestreet::Blog'
    has_one :content, class_name: 'Livestreet::TopicContent'
    has_many :photos, class_name: 'Livestreet::TopicPhoto'

    def convert
      if topic_type == 'topic'
        ::StoryTopic.build(
          livestreet_id: topic_id,
          title: topic_title,
          body: content&.topic_text,
          user: ::User.where(livestreet_id: user_id).first,
          blog: ::Blog.where(livestreet_id: blog_id).first
        )
      end
    end
  end
end
