class ErrorSerializer
  include FastJsonapi::ObjectSerializer
  attributes :description
  set_id { |id| id = nil }
end
