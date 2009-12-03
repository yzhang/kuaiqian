require 'digest/md5'
require 'cgi'
require 'iconv'

module Kuaiqian
  class Request
    GATEWAY_URL = "https://www.99bill.com/gateway/recvMerchantInfoAction.htm"
    PARAMS = %w(inputCharset bgUrl version language signType merchantAcctId payerName payerContactType payerContact orderId orderAmount orderTime productName productNum productId productDesc ext1 ext2 payType redoFlag pid)
    
    def initialize(product_name, order_id, order_time, total_fee, 
                    return_url, pay_type='00', attach=nil)
      @bank_type = 0
      @fee_type = 1
      
      @order_id = order_id.to_s
      @total_fee = total_fee.to_i.to_s
      @order_time = order_time.strftime("%Y%m%d%H%M%S")
      @product_name = product_name

      @pay_type = pay_type
      @return_url = return_url
      @ext1 = attach || ''
    end
    
    def url
      "#{GATEWAY_URL}?#{params}&signMsg=#{sign_msg}"
    end

    def input_charset; '1'; end
    def bg_url; @return_url; end
    def page_url; ''; end
    def version; 'v2.0'; end
    def language; '1'; end
    def sign_type; '1'; end
    def merchant_acct_id; Kuaiqian::Config.spid; end
    def payer_name; 'payerName'; end
    def payer_contact_type; '1'; end
    def payer_contact; ''; end
    def key; Kuaiqian::Config.key; end
    def order_id; @order_id; end
    def order_amount; @total_fee; end
    def order_time; @order_time; end
    def product_name; @product_name; end
    def product_num; '1'; end
    def product_id; ''; end
    def product_desc; ''; end
    def ext1; @ext1; end
    def ext2; ''; end
    def pay_type; @pay_type; end
    def redo_flag; "0"; end
    def pid; ''; end

    def sign_params
      params = PARAMS + ['key']
      params.map do |param|
        value = send(param.underscore)
        value == '' ? nil : "#{param}=#{value}"
      end.compact.join('&')
    end
    
    def sign_msg
      Digest::MD5.hexdigest(sign_params).upcase
    end
    
    def params
      PARAMS.map do |param|
        value = send(param.underscore)
        value == '' ? nil : "#{param}=#{CGI.escape(value)}"
      end.compact.join('&')
    end
  end
end