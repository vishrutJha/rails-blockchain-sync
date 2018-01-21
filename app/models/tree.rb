class Tree
  include Mongoid::Document
  include Mongoid::Timestamps

  attr_accessor :user_key
  
  field :allotment_id, type: String
  field :girth, type: Float
  field :height, type: Float
  field :weight, type: Float
  field :make, type: String
  field :bc_index
  field :price, type: Float
  field :status, type: String

  belongs_to :farmer, class_name: "User", foreign_key: :farmer_id
  belongs_to :land

  has_many :certificates, as: :certifiable

  after_save :update_ledger
  after_create :initiate_block

  def oid
    self.id.to_s
  end

  def ledger
    BlockChain.ledger(self.oid).last
  end

  private

    def initiate_block
      BlockChain.initiate(self.oid, self.attributes)
    end

    def update_ledger
      BlockChain.modify(self.oid, self.attributes, ledger.previous_hash)
    end
end
