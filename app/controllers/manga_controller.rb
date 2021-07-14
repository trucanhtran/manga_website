class MangaController < ApplicationController
  def index
    @categories = Category.all
    @products = Product.all.limit(10)
    @hot_products = Product.order(current_view_counts: :desc).limit(10)
    @new_products = Product.order(updated_at: :desc).limit(10)
  end

  def show
    @categories = Category.all
    @product = Product.find_by(id: params[:id])
    @chapters = @product.chapters.all.order(updated_at: :asc)
  end

  def search
    @categories = Category.all
    @products = Product.where("lower(title) LIKE ?", "%#{params[:keyword]}%")
      respond_to do |format|
        format.html{render :show_result}
        format.js
      end
  end

    def show_result
      @categories = Category.all
      @products = Product.where("title LIKE ?", "%#{params[:keyword]}%")
    end

    def login

    end

    def check_user
      @user = User.find_by(email: session_params[:email])
      if @user.present? && @user.authenticate(session_params[:password])
        session[:user_id] = @user.id
        redirect_to root_path
        flash[:notice] = "Login succsess"
      else
        render :login
        flash.now[:error] = "Wrong email or password"
      end
    end

    def signup
      @user = User.new

    end

    def create_user
      @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        redirect_to root_path, notice: 'Sign Up successfully'
      end
    end

    private

    def session_params
      params.permit(:email, :password)
    end
    def user_params
      params.require(:user).permit(:name, :email, :password)
    end
end
