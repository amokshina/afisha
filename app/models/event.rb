class Event < ApplicationRecord
  include Authorship

  has_many :comments, dependent: :destroy
  belongs_to :user

  has_many :registrations, dependent: :destroy
  has_many :users, through: :registrations

  validates :title, :event_type, :place, :num_of_people, :description, :event_date, presence: true
  validates :num_of_people, numericality: { only_integer: true, greater_than: 0}

  def formatted_date
    l event_date, format: :long
  end

  def available_spots
    num_of_people - registrations.count
  end

  has_one_attached :image

end
