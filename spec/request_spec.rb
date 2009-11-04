ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../../../../config/environment")
require 'spec'
require "kuaiqian"

describe Kuaiqian::Request do
  before do
    Kuaiqian::Config.stub!(:spid).and_return('1001153656201')
    Kuaiqian::Config.stub!(:key).and_return('ZUZNJB8MF63GA83J')
    
    time = Time.local(2009, 10, 28, 12, 03, 45)
    @request = Kuaiqian::Request.new('productName', '20091028120345', time,
                 2, 'http://return', '00')
    @order_time = "20091028120345"
    
    @valid_params = "inputCharset=1&bgUrl=http%3A%2F%2Freturn&version=v2.0&language=1&signType=1&merchantAcctId=1001153656201&payerName=payerName&payerContactType=1&orderId=20091028120345&orderAmount=2&orderTime=20091028120345&productName=productName&productNum=1&payType=00&redoFlag=0"
    @valid_sign_params = "inputCharset=1&bgUrl=http://return&version=v2.0&language=1&signType=1&merchantAcctId=1001153656201&payerName=payerName&payerContactType=1&orderId=20091028120345&orderAmount=2&orderTime=20091028120345&productName=productName&productNum=1&payType=00&redoFlag=0&key=ZUZNJB8MF63GA83J"
  end
  
  describe "url generation" do
    it "should generate sign_params correctly" do
      @request.sign_params.should == @valid_sign_params
    end
    
    it "should construct url params correctly" do
      @request.params.should == @valid_params
    end
  end
  
  describe "basic params" do
    it "should set input charset to 1" do
      @request.input_charset.should == '1'
    end
    
    it "should set page url empty" do
      @request.page_url.should == ''
    end
    
    it "should set bg_url properly" do
      @request.bg_url.should == 'http://return'
    end
  
    it "should set version to v2.0" do
      @request.version.should == 'v2.0'
    end
  
    it "should set language to 1" do
      @request.language.should == '1'
    end
  
    it "should set signType to '1'" do
      @request.sign_type.should == '1'
    end
  
    it "should set merchantAcctId properly" do
      @request.merchant_acct_id.should == '1001153656201'
    end
  
    it "should set payer info empty" do
      @request.payer_name.should == 'payerName'
      @request.payer_contact_type.should == '1'
      @request.payer_contact.should == ''
    end
    
    it "should set key properly" do
      @request.key.should == 'ZUZNJB8MF63GA83J'
    end
  
    it "should set order id properly" do
      @request.order_id.should == '20091028120345'
    end
  
    it "should set order amount properly" do
      @request.order_amount.should == '2'
    end
  
    it "should set order time properly" do
      @request.order_time.should == '20091028120345'    
    end
  
    it "should set product info properly" do
      @request.product_name.should == 'productName'
      @request.product_num.should == '1'
      @request.product_id.should == ''
      @request.product_desc.should == ''
    end
    
    it "should set ext properly" do
      @request.ext1.should == ''
      @request.ext2.should == ''
    end
  
    it "should set payType properly" do
      @request.pay_type.should == '00'
    end
    
    it "should set redo flag to zero" do
      @request.redo_flag.should == '0'
    end
    
    it "should set pid empty" do
      @request.pid.should == ''
    end
  end
end