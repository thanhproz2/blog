class ArticlesController < ApplicationController
before_action :authenticate_user! ,  except: [:index, :show]
http_basic_authenticate_with name: "thanh", password: "222222", except: [:index, :show]  

  def index
    if params[:category].blank?
      @articles = Article.all.order("created_at DESC")
    else
      @category_id = Category.find_by(name: params[:category]).id
      @articles =Article.where(:category_id => @category_id).order("created_at DESC")
    end
      
  end  
    #@articles = Article.all
   # @u =User.all
    #@first_name = current_user.first_name
    #@a="asdasd"
     # => @last_name = current_user.last_name
 
 
  def show
    @article = Article.find(params[:id])
  end
 
  def new
    
    @article = current_user.articles.new
    #a = current_user.id
    @categories=Category.all.map{ |c| [c.name, c.id] }
  end
 
  def edit
    @article = Article.find(params[:id])
    @categories=Category.all.map{ |c| [c.name, c.id] }
  end
 
  def create
    
    @article = current_user.articles.new(article_params)
    @categories=Category.all.map{ |c| [c.name, c.id] }
    @article.category_id = params[:category_id]
    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end
 
  def update
    @article = Article.find(params[:id])
 
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end
 
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
 
    redirect_to articles_path
  end


  private
    def article_params
      params.require(:article).permit(:title, :text, :category_id)
    end
end
