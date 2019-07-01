class RevenueSerializer
  include FastJsonapi::ObjectSerializer
  attribute :revenue do |merchant|
    '%.2f' % (merchant.revenue / 100.0)
  end
end
