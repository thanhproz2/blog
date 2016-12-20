class ArticlesController < ApplicationController
before_action :authenticate_user! ,  except: [:index, :show]
http_basic_authenticate_with name: "thanh", password: "222222", except: [:index, :show]  

def index
    @articles = Article.all
   # @u =User.all
    #@first_name = current_user.first_name
    #@a="asdasd"
     # => @last_name = current_user.last_name
 end
 
  def show
    @article = Article.find(params[:id])
  end
 
  def new

    @article = current_user.articles.new
    #a = current_user.id
    
  end
 
  def edit
    @article = Article.find(params[:id])
  end
 
  def create
    
    @article = current_user.articles.new(article_params)
 
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
      params.require(:article).permit(:title, :text)
    end
end
