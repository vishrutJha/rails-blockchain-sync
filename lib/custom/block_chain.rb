class BlockChain
  include HTTParty
  base_uri 'http://localhost:17000'

  def initialize
    @headers = {"Content-Type" => "application/x-www-form-urlencoded"}
    @body = {http_var_json: {}}
  end

  def ledger(user)
    @body["http_var_json"] = {
      "user" => user 
    }.to_json
    call_api("/get_ledger")
  end

  def initiate(index, data)
    @body["http_var_json"] = {
      "index" => index,
      "tree" => data,
      "user" => user
    }.to_json
    call_api("/insert")
  end

  def modify(index, data, previous_hash)
    @body["http_var_json"] = {
      "index" => index,
      "tree" => data,
      "prev_hash" => previous_hash,
      "user" => user
    }.to_json
    call_api("/modify")
  end

  protected
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
