class Vehicle
  include Mongoid::Document
  include Mongoid::Timestamps

  field :reg_no, type: String
  field :capacity, type: Float

  has_many :vehicle_registries
  accepts_nested_attributes_for :vehicle_registry, allow_destroy: true
end
