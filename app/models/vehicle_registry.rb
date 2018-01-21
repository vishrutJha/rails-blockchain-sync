class VehicleRegistry
  include Mongoid::Document
  include Mongoid::Timestamps

  field :date, type: Time
  field :vehicle_class, type: String

  belongs_to :user
  belongs_to :vehicle
end
