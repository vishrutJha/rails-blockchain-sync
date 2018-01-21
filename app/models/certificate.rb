class Certificate
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :asset_type, type: String
  field :asset_id, type: String
  field :auth_token, type: String

  belongs_to :officer, counter_cache: true 

  before_create :calc_hash

  def calc_hash
    sha = Digest::SHA256.new
    self.auth_token = sha.hexdigest
  end
end
