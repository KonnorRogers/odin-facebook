# frozen_string_literal: true

class AgeValidator < ActiveModel::EachValidator
  def validate_each(record, attr, value)
    too_young = Date.today - options[:too_young].years
    too_old = Date.today - options[:too_old].years
    # return if value < too_young && value > too_old
    if value > too_young
      record.errors[attr] << (options[:message] ||
        "You must be older than #{options[:too_young]} years old")
    elsif value < too_old
      record.errors[attr] << (options[:message] ||
        "You must be younger than #{options[:too_old]} years old")
    end
  end
end
