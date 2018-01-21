class BlockChain
  include Mongoid::Document
  include Mongoid::Timestamps

  field :b_index
  field :data
  field :previous_hash
  field :computed_hash

  before_create :compute_hash_with_proof_of_work

  def compute_hash_with_proof_of_work
    sha = Digest::SHA256.new
    self.computed_hash = sha.hexdigest
  end

  def self.genesis(data = "Genesis")
    BlockChain.create(b_index: 0, data: data, previous_hash: "0" ) if BlockChain.first.blank?
  end

  def self.ledger(b_index)
    puts "Requesting Ledger Data Sync"
    self.where(b_index: b_index)
  end

  def self.initiate(b_index, data)
    puts "Adding Data to BlockChain from Genesis"
    b = BlockChain.new(
      b_index: b_index,
      data: data,
      previous_hash: nil
    )
    b.save
  end
  
  def self.modify(b_index, data, previous_hash)    
    puts "Adding a new Block to Existing Chain"
    b = BlockChain.new(
      b_index: b_index,
      data: data,
      previous_hash: previous_hash
    )
    b.save
  end

  def self.next( previous, data="Transaction Data..." )
    BlockChain.new( previous.b_index+1, data, previous.hash )
  end

  def self.retreive(b_index)
    records = self.where(b_index: b_index)
  end

end
