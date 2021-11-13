json.extract! patiente, :id, :name, :surname, :phone, :created_at, :updated_at
json.url patiente_url(patiente, format: :json)
