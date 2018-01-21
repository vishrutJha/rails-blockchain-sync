require 'bcrypt'
class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include BCrypt

  VALID_TYPES = {
    farmer: "Farmer",
    officer: "Officer"
  }.freeze

  attr_accessor :password

  field :auth_token
  field :email, type: String, default: ""  
  field :name, type: String
  field :adhaar_no, type: Integer
  field :user_type, type: String
  field :user_keys, type: Hash
  field :password_hash, type: String

  has_many :vehicle_registries
  has_many :lands
  has_many :trees

  before_create :calc_hash
  before_save :set_password, if: :password

  def set_password
    sha1_password = Digest::SHA1.hexdigest(password)
    self.password_hash = BCrypt::Password.create(sha1_password).to_s
  end

  def valid_password?(pass)
    sha1_password = Digest::SHA1.hexdigest(pass)
    BCrypt::Password.new(self.password_hash) == sha1_password
  end

  def calc_hash
    sha = Digest::SHA256.new
    self.auth_token = sha.hexdigest
  end
end
