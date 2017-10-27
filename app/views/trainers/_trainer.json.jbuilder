json.extract! trainer, :id, :name, :email, :phone, :description, :logo, :created_at, :updated_at
json.url trainer_url(trainer, format: :json)
