class BlockChain
  include HTTParty
  # Requires composer-rest-server with auth running
  base_uri 'http://com.example.fabric:17000'

  # Initialize headers
  def initialize
    @headers = {"Content-Type" => "application/x-www-form-urlencoded"}
    @body = {http_var_json: {}}
  end

  # Get Ledger Data (current)
  def ledger(user)
    puts "Requesting Ledger Data Sync"
    @body["http_var_json"] = {
      "user" => user 
    }.to_json
    call_api("/get_ledger")
  end

  # Intiate First Entry Node from Genesis
  def initiate(index, data)
    puts "Adding Data to BlockChain from Genesis"
    @body["http_var_json"] = {
      "index" => index,
      "tree" => data,
      "user" => user
    }.to_json
    call_api("/insert")
  end

  # Mutating entry in blockchain on record modification
  def modify(index, data, previous_hash)
    puts "Adding a new Block to Existing Chain"
    @body["http_var_json"] = {
      "index" => index,
      "tree" => data,
      "prev_hash" => previous_hash,
      "user" => user
    }.to_json
    call_api("/modify")
  end

  protected
    # Make tha actual API call
    def call_api(url)
      begin
        data = self.class.post(
          url,
          :query => @body,
          :headers => @headers
        )
        JSON.parse(data)
      rescue Exception => e
        return {status: 500, errors: e.class.to_s}
      end
    end


end
