# frozen_string_literal: true

module ApplicationHelper
  def full_title(page_title: '')
    base_title = 'ParamagicBook'

    return base_title if page_title.empty?

    "#{page_title} | #{base_title}"
  end

  def created_time(commentable)
    string = time_ago_in_words(commentable.created_at)
    string.gsub('about ', "") + ' ago'
  end
end
