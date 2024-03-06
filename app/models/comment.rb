class Comment < ApplicationRecord
  include Authorship

  belongs_to :event
  belongs_to :user

  validates :body, presence: true, length: {minimum: 2}


  def formatted_created_at
    created_at.strftime('%Y-%m-%d %H:%M:%S')
  end

end
