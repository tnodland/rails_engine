class TotalRevenueSerializer
  include FastJsonapi::ObjectSerializer
  attribute :total_revenue do |merchant|
    '%.2f' % (merchant.total_revenue / 100.0)
  end
end
