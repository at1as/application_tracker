class PositionsController < ApplicationController

  before_action :logged_in_user
  before_action :set_position, only: [:show, :edit, :update, :destroy]

  # GET /positions
  def index
    @positions = Position.all
  end

  # GET /positions/1
  def show
    @user = current_user
    @company = Company.find(params[:company_id])
    @position = Position.find(params[:id])
  end

  # GET /positions/new
  def new
    @user = current_user
    @company = Company.find(params[:company_id])
    @position = Position.new
  end

  # GET /positions/1/edit
  def edit
    @user = current_user
    @company = Company.find(params[:company_id])
    @position = Position.find(params[:id])
  end

  # POST /positions
  def create
    @user = current_user
    @company = Company.find(params[:company_id])
    @position = @company.positions.build(position_params)

    if @position.save
      flash[:success] = "Position created successfully"
      redirect_to user_company_path(current_user, @company)
    else
      render 'new'
    end
  end

  # PATCH/PUT /positions/1
  def update
    @user = current_user
    @company = Company.find(params[:company_id])
    @position = Position.find(params[:id])

    if @position.update(position_params)
      flash[:success] = "Position details updated"
      redirect_to user_company_path(current_user, @company)
    else
      render 'edit'
    end
  end

  # DELETE /positions/1
  def destroy
    @company = Company.find(params[:company_id])
    @position = Position.find(params[:id])

    @position.destroy
    redirect_to user_company_path(current_user, @company), :flash => {:success => "Position deleted!" }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_position
      @position = Position.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def position_params
      params.require(:position).permit(:name, :url, :details)
    end
end
