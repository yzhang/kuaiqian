ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../../../../config/environment")
require 'spec'
require "kuaiqian"

describe Kuaiqian::Response do
  before(:each) do
    Kuaiqian::Config.stub!(:spid).and_return('1001153656201')
    Kuaiqian::Config.stub!(:key).and_return('ZUZNJB8MF63GA83J')
  end
  
  it "should be a valid response with valid params" do
    response = Kuaiqian::Response.new(params)
    response.should be_successful
  end
    
  it "should be an invalid response with wrong pay result" do
    response = Kuaiqian::Response.new(params(:payResult => '00'))
    response.should_not be_successful
  end
  
  it "should be an invalid response with wrong sign msg" do
    response = Kuaiqian::Response.new(params(:signMsg => 'wrong'))
    response.should_not be_successful
  end
  
  def params(options={})
    {
      :merchantAcctId => "1001153656201", 
      :payAmount =>"100", 
      :bankId => "", 
      :language => "1", 
      :orderId =>"20091103164410", 
      :id => "1",
      :signType =>"1", 
      :orderTime =>"20091103164410", 
      :payResult =>"10", 
      :version =>"v2.0", 
      :payType =>"12", 
      :fee =>"1", 
      :dealId =>"5696344", 
      :bankDealId =>"", 
      :dealTime =>"20091104004452", 
      :errCode =>"", 
      :signMsg =>"361A184B9157BBEAA3627B1B0D6412D6", 
      :ext1 =>"", 
      :orderAmount =>"100", 
      :ext2 =>""
    }.merge(options)
  end
  
  # def params(options={})
  #   {:merchantAcctId => 'testid',
  #     :version => 'v2.0',
  #     :language => '1',
  #     :signType => '1',
  #     :payType => '00',
  #     :bankId => 'ICBC',
  #     :orderId => '1',
  #     :orderTime => '20091021123200',
  #     :orderAmount => '4500',
  #     :dealId => 'testdealid',
  #     :bankDealId => 'testbankdeal',
  #     :dealTime => '20091021123203',
  #     :payAmount => '4500',
  #     :fee => '100',
  #     :ext1 => 'nil',
  #     :ext2 => '',
  #     :payResult => '10',
  #     :errCode => '',
  #     :key => '',
  #     :signMsg => '1D060818424C1335C157B1FA5A9A7551'
  #   }.merge(options)
  # end
end
