# frozen_string_literal: true

module Livestreet
  class Blog < BaseRecord
    self.primary_key = :blog_id

    has_many :blog_users, class_name: 'Livestreet::BlogUser', foreign_key: :blog_id
    has_many :users, class_name: 'Livestreet::User', through: :blog_users
    has_many :topics, class_name: 'Livestreet::Topic', foreign_key: :blog_id

    def convert
      ::Blog.build(
        livestreet_id: blog_id,
        title: blog_title,
        description: blog_description,
        blog_type: blog_type,
        created_at: blog_date_add,
        rating: blog_rating,
        likes_count: blog_count_vote,
        topics_count: blog_count_topic,
        users_count: blog_count_user,
        slug: blog_url,
        owner: ::User.where(livestreet_id: user_owner_id).first,
        users: users.map { ::User.where(livestreet_id: _1.user_id).first }.compact
      )
    end
  end
end
