class Article < ApplicationRecord
	belongs_to :user
	belongs_to :category
  has_many :comments, dependent: :destroy
  validates :title, presence: true,
                    length: { minimum: 5 }
  has_attached_file :article_img, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :article_img, content_type: /\Aimage\/.*\z/
end
