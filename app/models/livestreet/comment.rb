# frozen_string_literal: true

module Livestreet
  class Comment < BaseRecord
    self.primary_key = :comment_id

    def convert
      comment_target = target(target_type, target_id)
      return unless comment_target

      comment = ::Comment.by_ls(comment_id)
      if comment
        comment.parent = ::Comment.by_ls(comment_pid)
        return comment
      end

      ::Comment.build(
        livestreet_id: comment_id,
        text: comment_text,
        target: comment_target,
        user: ::User.by_ls(user_id),
        rating: comment_rating,
        likes_count: comment_count_vote,
        deleted_at: comment_delete > 0 ? Time.current : nil,
        published_at: comment_publish > 0 ? comment_date : nil
      )
    end
  end
end
