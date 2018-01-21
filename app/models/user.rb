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
  has_one :officer_data

  before_create :calc_hash
  after_create :generate_keys
  before_save :set_password, if: :password

  accepts_nested_attributes_for :officer_data

  def generate_keys
    rsa_key = OpenSSL::PKey::RSA.new(2048)
    cipher =  OpenSSL::Cipher::Cipher.new('des3')
    private_key = rsa_key.to_pem(cipher,'password')
    public_key = rsa_key.public_key.to_pem
    self.user_keys = {
      public: public_key, 
      private: private_key
    }
    self.save
  end

  def key_pair
    key_pair = (user_keys["private"] + user_keys["public"] rescue nil)
  end

  def public_key
    user_keys["public"]
  end

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
