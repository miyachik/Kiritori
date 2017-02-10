# frozen_string_literal: true
class AbTest < ActiveRecord::Base
  validates :branch, presence: true
  validates :description, presence: true
  validates :weight, presence: true
  validates :ended_at, presence: true
end
