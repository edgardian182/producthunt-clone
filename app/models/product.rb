# == Schema Information
#
# Table name: products
#
#  id                 :integer          not null, primary key
#  name               :string
#  url                :string
#  description        :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  user_id            :integer
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#

class Product < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :votes

  has_attached_file :image, styles: {medium: "300x300>", thumb: "100x100>"}

  validates_presence_of :name, :url
  validates_attachment_content_type :image, content_type:/\Aimage\/.*\Z/

  # Mira si dentro de este producto existe un voto asociado al usuario
  def voted_by?(user)
    votes.exists?(user: user)
  end

end
