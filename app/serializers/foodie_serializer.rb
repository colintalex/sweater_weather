class FoodieSerializer
  include FastJsonapi::ObjectSerializer
  attributes :end_location, :travel_time, :forecast, :restaurant
end
