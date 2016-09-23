class Article < ApplicationRecord
	belongs_to :user
	has_many :comments
	#Valida que los camppos no esten Vacios
	#Uniqueness hace que el title no se repita, lo gace unico
	validates :title, presence: true, uniqueness: true
	validates :body, presence: true, length: {minimum: 20}

	# before_save :set_visits_count
	# before_validation :set_visits_count
	# after_create :set_visits_count
	# after_save :set_visits_count
	# after_save :set_visits_count, on: :create
	#before_save :set_visits_count
	before_create :set_visits_count

	def update_visits_count
		# self.save if self.visits_count.nil?
		self.update(visits_count: self.visits_count + 1)
	end

	private

	def set_visits_count
		# self.visits_count || = 0
			self.visits_count  = 0
	end	


end
