class BestDaySerializer
  include FastJsonapi::ObjectSerializer
  attribute :best_day do |item|
    item.best_day.to_date
  end
end
