require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UsersController do
  before(:each) do
    @client = Client.make
  end
  
  describe "client authentication" do
    it "should protect json requests" do
      get :index, :format => 'json'
      response.code.should == '401'
    end
    it "should protect xml requests" do
      get :index, :format => 'xml'
      response.code.should == '401'
    end
    describe "when all other information is correct" do
      before(:each) do
        request.env['REMOTE_ADDR'] = @client.ip_address
        use_basic_auth('', @client.api_key)
      end
      it "should succeed" do
        get :index, :format => 'xml'
        response.code.should == '200'
      end
      it "should fail when from some other IP address" do
        request.env['REMOTE_ADDR'] = '192.168.23.122'
        get :index, :format => 'xml'
        response.code.should == '401'
      end
      it "should fail when the username is not empty" do
        use_basic_auth('something', @client.api_key)
        get :index, :format => 'xml'
        response.code.should == '401'
      end
      it "should fail when the API key is wrong" do
        use_basic_auth('', 'bad api key')
        get :index, :format => 'xml'
        response.code.should == '401'
      end
    end
  end
  
end
