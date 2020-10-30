class User < ApplicationRecord
  validates :name, {presence: true}
  validates :email, {presence: true, uniqueness: true}
  validates :password, {presence: true}
  validates :sexual_details, {length: {maximum: 20}}
  validates :love_details, {length: {maximum: 20}}  
  validates :introduction, {length: {maximum: 140}}
  def posts
    return Post.where(user_id: self.id)
  end
end
