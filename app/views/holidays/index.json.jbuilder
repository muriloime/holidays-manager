json.array!(@holidays) do |holiday|
  json.extract! holiday, :id, :start_date, :end_date, :description, :user_id
  json.url holiday_url(holiday, format: :json)
end
