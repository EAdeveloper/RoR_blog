class Article < ApplicationRecord
	include AASM


	belongs_to :user
	has_many :comments
	has_many :has_categories
	has_many :categories, through: :has_categories
	# attr_reader :categories

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
	after_create :save_categories

	
	 has_attached_file :cover, styles: { medium: "300x300>", thumb: "100x100>" }
  	 validates_attachment_content_type :cover, content_type: /\Aimage\/.*\z/

  	 # Metodos de classes
	# def self.publicados
	# 	Article.where(state:"published")
	# end		
  	#Este Scope hace lo mismo que el mwtodo de clase declarado above
	scope :publicados, ->{ where(state:"published")}
	scope :ultimos, ->{order("created_at DESC") }
	# scope :primeros, ->{order("created_at DESC").limit(10) }
	

	#Custom setter; me permite asignar valor al atribute de un obj
	def categories=(value)
		@categories = value
	end	

	def update_visits_count
		# self.save if self.visits_count.nil?
		self.update(visits_count: self.visits_count + 1)
	end

	aasm column: "state" do
		state :in_draft, initial: true
 		state :published

 		event :publish do
 			transitions from: :in_draft, to: :published
 		end

 		event :unpublish do
 			transitions from: :published, to: :in_draft
 		end
	end





	private
	
	def save_categories
		# raise @categories.to_yaml
		@categories.each do |category_id|
			HasCategory.create(category_id: category_id, 
				article_id: self.id)
		end
	end


	def set_visits_count
		# self.visits_count || = 0
			self.visits_count  = 0
	end	


end
