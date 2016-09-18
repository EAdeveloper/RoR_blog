class ArticlesController < ApplicationController
#! For any actions in this controller, 
#tinenes que crear un template en Views

	#GET /articles
	def index
		#traer todos los registro del modelo articles a la varible luego 
		#sera instaciada en el view index
		@articles = Article.all
	end


	#Get /articles/:id
	def show
		#Va a encontrar all de Articles por ID
		@article = Article.find(params[:id])
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
	end	
	#POST /articles
	def create
		# @article = Article.new(title: params[:article][:title],
		# 					 body: params[:article][:body])

		#Este article_params viene del Private article_params
		#declarados abajo
		@article = Article.new(article_params)

		#El mismo de arriva diference is que  lo salva de una ves con Create
		# @article = Article.create(title: params[:article][:title],
		# 					 body: params[:article][:body])

		if @article.save
		redirect_to @article
		else	
			render :new
		end
	end	#create

	def destroy
		@article = Article.find(params[:id])
		#Elimina el ojb from the DB
		@article.destroy
		redirect_to articles_path
	end

		#PUT /articles/:id
	def update
		# @article.update_attributes({title: 'Nuevo titulo'})
		@article = Article.find(params[:id])
			if @article.update(article_params)
				redirect_to @article
			else
				render :edit
			end

	end

	def edit
		@article = Article.find(params[:id])
	end


	#AVOID SQL injections  solo permitir title y body para los campos
	#y usarlo en metodo 'create' arriva como new '(article_params)'
	private
	def article_params
		params.require(:article).permit(:title,:body)
	end


end
