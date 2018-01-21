class OfficerData
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :designation, type: String
  field :organization, type: String
  field :department, type: String
  field :region, type: String
  field :sub_region, type: String
  field :reg_no, type: String
  field :ppk, type: String

  embedded_in :user
end
