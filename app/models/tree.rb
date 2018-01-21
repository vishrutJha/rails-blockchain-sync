class Tree
  include Mongoid::Document
  include Mongoid::Timestamps

  attr_accessor :user_key

  STATUSES = {
    planted: "Planted",
    cut_requested: "Cut Requested",
    cut_approved: "Cut Approved",
    cut: "Cut",
    in_transit: "In Transit",
    delivered: "Delivered"
  }.freeze
  
  field :allotment_id, type: String
  field :girth, type: Float
  field :height, type: Float
  field :weight, type: Float
  field :make, type: String
  field :bc_index
  field :price, type: Float
  field :status, type: String
  field :revenue_dept, type: Boolean
  field :survey_dept, type: Boolean
  field :forest_dept, type: Boolean

  belongs_to :farmer, class_name: "User", foreign_key: :farmer_id
  belongs_to :land

  has_many :certificates, as: :certifiable

  after_save :update_ledger
  after_create :initiate_block
  before_create :set_plantation
  validate :certification_checks, if: :status_changed?

  def certification_checks
    return false unless ( self.revenue_dept and self.survey_dept and self.forest_dept ) 
  end

  def self.cut_requests(ids)
    updated = []
    self.find(ids).map{|x|
      updated << {x.id => x.update(status: STATUSES[:cut_requested])}
    }
    updated
  end

  def oid
    self.id.to_s
  end

  def all_ledgers
    BlockChain.ledger(self.oid)
  end

  def ledger
    BlockChain.ledger(self.oid).last rescue nil
  end

  # private

    def initiate_block
      BlockChain.initiate(self.oid, self.attributes)
    end

    def set_plantation
      self.status = STATUSES[:planted]
    end

    def update_ledger
      BlockChain.modify(self.oid, self.attributes, ledger.computed_hash)
    end
end
