class Following < ApplicationRecord
  validates_uniqueness_of :follower_id, scope: [:followed_id]

  belongs_to :follower, class_name: 'User', optional: true
  belongs_to :followed, class_name: 'User', optional: true
end
