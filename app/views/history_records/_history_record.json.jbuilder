json.extract! history_record, :id, :uid, :data, :created_at, :updated_at
json.url history_record_url(history_record, format: :json)
