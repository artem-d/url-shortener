class Link
  include Mongoid::Document
  include Mongoid::Timestamps

  field :in_url, type: String
  field :out_url, type: String
  field :clicks, type: Integer, default: 0
  field :user_id

  belongs_to :user

  validates :in_url, :clicks, :presence => true
  validates :in_url, :uniqueness => true

  before_create :generate_out_url

  def display_out_url
    BASE_URL + self.out_url
  end

  private
    def generate_out_url
      self.out_url = Time.now.to_i.to_s(36)
    end
  
end
