class EventsController < ApplicationController
  
  before_action :logged_in_user

  def show
    @user = current_user
    @company = Company.find(params[:company_id])
    @event = Event.find(params[:id])
  end

  # GET /events/new
  def new
    @user = current_user
    @company = Company.find(params[:company_id])
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
    @user = current_user
    @company = Company.find(params[:company_id])
    @event = Event.find(params[:id])
  end

  # POST /events
  def create
    @user = current_user
    @company = Company.find(params[:company_id])
    @event = @company.events.build(event_params)

    if @event.save
      flash[:success] = "Event added"
      redirect_to user_company_path(current_user, @company)
    else
      render 'new'
    end
  end

  # PUT/PATCH /events/1
  def update
    @user = current_user
    @company = Company.find(params[:company_id])
    @event = Event.find(params[:id])

    if @event.update(event_params)
      flash[:success] = "Event updated"
      redirect_to user_company_path(current_user, @company)
    else
      render 'edit'
    end
  end

  # DELETE /events/1
  def destroy
    @company = Company.find(params[:company_id])
    @event = Event.find(params[:id])

    @event.destroy
    redirect_to user_company_path(current_user, @company), :flash => {:success => "Event deleted!"}
  end

  private
    def event_params
      params.require(:event).permit(:date, :event_type, :text)
    end
end
