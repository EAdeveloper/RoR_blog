class ArticlesController < ApplicationController
#! For any actions in this controller, 
#tinenes que crear un template en Views
	#te redirigen to sign in si no logged
	#Callbacks
	#after_action
	# before_action :validate_user, except: [:show,:index]
	#Method helper from devise
	# before_action :authenticate_user!
	# before_action :authenticate_user!, only: [:create, :new]
	before_action :authenticate_user!, except: [:show, :index]
	before_action :set_article, except: [:index, :new, :create]
	before_action :authenticate_editor?, only: [:new,:create,:update]
	before_action :authenticate_admin?, only: [:destroy,:publish]

	#GET /articles
	def index
		#traer todos los registro del modelo articles a la varible luego 
		#sera instaciada en el view index
		# @articles = Article.all
		#FROM state machimes GEM
		# @articles = Article.where(state: "published")
		# @articles = Article.published
		#Metodos que puedo utilizar from my scope in article Model
		# @articles = Article.publicados.ultimos
		#Pagination wiht will_paginate gem
		@articles = Article.paginate(page: params[:page],per_page:5).publicados.ultimos
		# Article.paginate(params[:page])
	end


	#Get /articles/:id
	def show
		@article.update_visits_count
		@comment = Comment.new
		#Va a encontrar all de Articles por ID

		# @article = Article.find(params[:id])

		#Esta consulata hace lo mismo k el de arriva
		#@Article.where(" id = ? ", params[:id])


		# #enconrar por WHERE donde dicen 'hola' 
		# @Article.where("body LIKE ? ", "%hola%")
		# @Article.where(" id = ? ", params[:id])
		# #multiples
		# @Article.where(" id = ?  OR title  = ?", params[:id]), params[:title]
		
 	end
	#GET/articles/new
	def new
		@article = Article.new
		@category = Category.all
	end	
	#POST /articles
	def create
		#INSERT INTO
		# @article = Article.new(title: params[:article][:title],
		# 					 body: params[:article][:body])

		#Este article_params viene del Private article_params
		#declarados abajo
		# @article = Article.new(article_params)

		# REf the user that create the article
			 # @article = current_user.articles.create(article_params)
			@article = current_user.articles.new(article_params)
			#raise params.to_yaml
			@article.categories = params[:categories]

		#El mismo de arriva diference is que  lo salva de una ves con Create
		# @article = Article.create(title: params[:article][:title],
		# 					 body: params[:article][:body])


			if @article.save
			redirect_to @article
			else	
				render :new
			end
	end	#create

	#working to not allow create art if not logged
	# if user_signed_in?
	# 		@article = current_user.articles.new(article_params)
	# 		if @article.save
	# 		redirect_to @article
	# 		else	
	# 			render :new
	# 		end
	# 	end#user_signed_in?
	# end	#create


	#DELETE /article/:id
	def destroy
		#DELETE FROM articles
		# @article = Article.find(params[:id])

		#Elimina el ojb from the DB
		@article.destroy
		redirect_to articles_path
	end

		#PUT /articles/:id
	def update
		# @article.update_attributes({title: 'Nuevo titulo'})
		#@article = Article.find(params[:id])
			if @article.update(article_params)
				redirect_to @article
			else
				render :edit
			end

	end

	def edit
		# @article = Article.find(params[:id])
	end
	# Articles Pulicados from Admin
	def publish
		@article.publish!
		redirect_to @article
	end		

	#AVOID SQL injections  solo permitir title y body para los campos
	#y usarlo en metodo 'create' arriva como new '(article_params)'
	private

	def set_article
		@article = Article.find(params[:id])
	end	

	def validate_user
		redirect_to new_user_session_path, notice: "Necesitas iniciar sesión"
	end

	def article_params
		params.require(:article).permit(:title,:body,:cover,:categories)
	end


end
