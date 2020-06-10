class RoadTripSerializer
  include FastJsonapi::ObjectSerializer
  attributes :origin, :destination, :travel_time
  
  set_id { |id| id = nil }

  attribute :arrival_forecast do |obj|
      { temp: obj.arrival_forecast[:temp],
     summary: obj.arrival_forecast[:weather][0][:description] }
  end

end
