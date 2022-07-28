class Post < ApplicationRecord
  validates_presence_of :title
  validates_presence_of :content
  validates_presence_of :address
  validates_presence_of :category
  validates_presence_of :image
  validates_presence_of :region

  belongs_to :user
  has_many :comments
  belongs_to :category
  belongs_to :region
  before_create :generate_short_url

  mount_uploader :image, ImageUploader

  def generate_short_url
    loop do
      @short = rand(0..9999).to_s.rjust(4,'0')
      break unless Post.exists?(short_url: @short)
    end
    self.short_url=@short
  end
end
