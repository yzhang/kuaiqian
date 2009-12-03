require 'digest/md5'
require 'cgi'
require 'iconv'

module Kuaiqian
  class Response
    attr_reader :order_id, :total_fee, :attach, :pay_time
    
    BANK_NAMES = {'ICBC' => '中国工商银行', 'CMB' => '招商银行', 'CCB' => '中国建设银行',
                  'ABC' => '中国农业银行', 'BOC_SH' => '中国银行(上海)', 'BOC_GZ' => '中国银行(广州)',
                  'SPDB' => '上海浦东发展银行', 'BCOM' => '交通银行', 'CMBC' => '中国民生银行',
                  'SDB' => '深圳发展银行', 'GDB' => '广东发展银行', 'CITIC' => '中信银行',
                  'HXB' => '华夏银行', 'CIB' => '兴业银行', 'GZRCC' => '广州市农村信用合作社',
                  'GZCB' => '广州市商业银行', 'SHRCC' => '上海农村商业银行', 'CPSRB' => '中国邮政储蓄',
                  'CEB' => '中国光大银行', 'BOB' => '北京银行', 'CBHB' => '渤海银行', 
                  'BJRCB' => '北京农村商业银行', 'CNPY' => '中国银联'}

    # merchantAcctId=1001153656201&version=v2.0&language=1&signType=1&payType=12&bankId=&orderId=20091103164410&orderAmount=100&orderTime=20091103164410&ext1=&ext2=&payAmount=100&dealId=5696344&bankDealId=&dealTime=20091104004452&payResult=10&errCode=&fee=1&signMsg=361A184B9157BBEAA3627B1B0D6412D6
    SIGN_PARAMS = %w(merchantAcctId version language signType  payType bankId orderId orderTime orderAmount dealId bankDealId dealTime payAmount fee ext1 ext2  payResult errCode key)
    def initialize(params)
      @params = params
    end
    
    def successful?
      pay_result == '10' && valid_sign?
    end
    
    def valid_sign?
      sign_msg == Digest::MD5.hexdigest(sign_params).upcase
    end
    
    def sign_params
      SIGN_PARAMS.map do |param|
        value = send(param.underscore)
        value == '' ? nil : "#{param}=#{value}" 
      end.compact.join('&')
    end
    
    def version;          @params[:version]; end
    def language;         @params[:language]; end
    def sign_type;        @params[:signType]; end
    def merchant_acct_id; @params[:merchantAcctId]; end
    def key;              Kuaiqian::Config.key; end
    def order_id;         @params[:orderId]; end
    def order_amount;     @params[:orderAmount]; end
    def order_time;       @params[:orderTime]; end
    def deal_id;          @params[:dealId]; end
    def bank_deal_id;     @params[:bankDealId]; end
    def deal_time;        @params[:dealTime]; end
    def pay_amount;       @params[:payAmount]; end
    def fee;              @params[:fee]; end
    def attach;           @params[:ext1]; end
    def ext1;             @params[:ext1]; end
    def ext2;             @params[:ext1]; end
    def pay_result;       @params[:payResult]; end
    def err_code;         @params[:errCode]; end
    def sign_msg;         @params[:signMsg]; end
    def pay_type;         @params[:payType]; end
    def bank_id;          @params[:bankId]; end
    def bank_name;        BANK_NAMES[bank_id]; end
  end
end