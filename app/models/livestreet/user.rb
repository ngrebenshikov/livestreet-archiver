# frozen_string_literal: true

module Livestreet
  class User < BaseRecord
    self.primary_key = :user_id

    has_many :livestreet_blog_users, class_name: 'Livestreet::BlogUser', foreign_key: :user_id
    has_many :blogs, class_name: 'Livestreet::Blog', through: :livestreet_blog_users

    def convert
      ::User.build(
        livestreet_id: user_id,
        email: user_mail,
        username: user_login,
        created_at: user_date_register,
        skill: user_skill,
        rating: user_rating,
        notify_new_topic: user_settings_notice_new_topic,
        notify_new_comment: user_settings_notice_new_comment,
        notify_reply_comment: user_settings_notice_reply_comment,
        notify_new_friend: user_settings_notice_new_friend,
        timezone: user_settings_timezone
      )
    end
  end
end
