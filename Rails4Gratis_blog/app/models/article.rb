class Article < ApplicationRecord
	#Valida que los camppos no esten Vacios
	#Uniqueness hace que el title no se repita, lo gace unico
	validates :title, presence: true, uniqueness: true
	validates :body, presence: true, length: {minimum: 20}

	# validates :username, format: {with: /regex/ }

end
