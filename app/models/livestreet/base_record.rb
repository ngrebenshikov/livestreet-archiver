# frozen_string_literal: true

module Livestreet
  class BaseRecord < ApplicationRecord
    self.table_name_prefix = 'ls_'
    self.pluralize_table_names = false
    self.abstract_class = true

    connects_to database: { reading: :livestreet, writing: :livestreet }

    def target(type, id)
      target_class(type)&.by_ls(id)
    end

    def target_class(type)
      case type.to_sym
      when :topic
        ::Topic
      else
        nil
      end
    end
  end
end
