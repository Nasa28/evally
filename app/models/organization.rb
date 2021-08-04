# frozen_string_literal: true

class Organization < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :templates, through: :users

  validates :name, presence: true, uniqueness: true
end
