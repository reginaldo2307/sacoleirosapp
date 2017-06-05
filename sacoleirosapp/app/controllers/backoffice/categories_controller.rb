class Backoffice::CategoriesController < BackofficeController
  before_action :set_category, only: [:edit, :update, :destroy]

  def index
  	@categories = Category.all
  end

  def new
  	@category= Category.new
  end

  def create
  	@category = CategoryService.create(params_category)

  	unless @category.errors.any? 
  		redirect_to backoffice_categories_path, notice: "A categoria #{@category.description} foi criada com sucesso"
  	else
  		render :new
  	end
  end

  def edit
  end

  def update
  	if @category.update(params_category)
  		redirect_to backoffice_categories_path, notice: "A categoria #{@category.description} foi atualizada com sucesso"
  	else
  		render :edit
  	end
  end

  def destroy
    if @category.destroy
      redirect_to backoffice_categories_path, notice: "A Categoria #{@category.description} foi excluída com sucesso"
  else
    render index
  end
  end


  private

  def set_category
  	@category = Category.find(params[:id])
  end

  def params_category
  	params.require(:category).permit(:description)
  end
end
