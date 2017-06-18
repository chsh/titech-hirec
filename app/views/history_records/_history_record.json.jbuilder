json.extract! history_record, :uid, *HistoryRecord::FIELDS
json.url history_record_url(history_record.uid, format: :json)
