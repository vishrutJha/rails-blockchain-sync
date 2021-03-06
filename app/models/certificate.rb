class Certificate
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :certifiable_type, type: String
  field :certifiable_id, type: String
  field :auth_token, type: String

  belongs_to :certifiable, polymorphic: true

  before_create :calc_hash

  def calc_hash
    sha = Digest::SHA256.new
    self.auth_token = sha.hexdigest
  end
end
