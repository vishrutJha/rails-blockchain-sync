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

  belongs_to :farmer, class_name: "User", foreign_key: :farmer_id
  belongs_to :land

  after_save :block_the_chain
  before_save :update_ledger

  private
    def block_the_chain
      BlockChain.commit(user_key, bc_index, self.to_a)
    end

    def update_ledger
      BlockChain.retreive(user_key)
    end
end
