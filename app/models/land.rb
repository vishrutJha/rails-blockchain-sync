class Land
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :size, type: Float
  field :allocation, type: String
  field :addl_data, type: Hash
  field :latitude, type: Float
  field :longitude, type: Float
  
  belongs_to :user
end
