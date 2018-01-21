class Officer
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name, type: String
  field :last_name, type: String
  field :designation, type: String
  field :organization, type: String
  field :department, type: String
  field :region, type: String
  field :sub_region, type: String
  field :reg_no, type: String
  field :ppk, type: String

  has_many :certificates, dependent: :destroy
end
