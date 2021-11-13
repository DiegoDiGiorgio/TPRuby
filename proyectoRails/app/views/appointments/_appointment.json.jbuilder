json.extract! appointment, :id, :date, :patiente_id, :professional_id, :created_at, :updated_at
json.url appointment_url(appointment, format: :json)
