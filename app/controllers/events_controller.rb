class EventsController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
  def new
    @event = Event.new
    @leagues = League.all
  end

  def index
    @events = Event.paginate(page: params[:page])
  end

  # this method will collect the event ID from the user then present the form 
  # that allows the placing of bets
  def addbet
    @id = params[:id]
  end

  #this method actually carries out the placing of bets
  def placebet
    @bet = Bet.create name: params[:betname], bet_type: params[:bettype],  event_id: params[:eventid] # create the bet object write to DB

    # create te betitems and link them to this bet
    @betitem1 = BetItem.create name: params[:betitem1name], odds: params[:betitem1odd], bet_id: @bet.id
    @betitem2 = BetItem.create name: params[:betitem2name], odds: params[:betitem2odd], bet_id: @bet.id
    @betitem3 = BetItem.create name: params[:betitem3name], odds: params[:betitem3odd], bet_id: @bet.id
     flash[:notice] = "Bet placed on" + Event.find(params[:eventid]).name
    redirect_to events_path
  end


  def show
    @event = Event.find(params[:id])
  end
 
  def create
    @event = Event.new(user_params) # save the event
    @event.date = params[:date]
    
    if params[:event][:active]=="yes"
      @event.active = true;
    end
    if params[:event][:active]=="no"
      @event.active = false
    end 
    if @event.save
      flash[:notice] = "event successfully registered"
      redirect_to events_url
    else
      render 'new'
    end

  end

  def edit # edit league details
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    @event.date = params[:date]
    if params[:event][:active]=="yes"
      @event.active = true;
    end
    if params[:event][:active]=="no"
      @event.active = false
    end 
    if @event.update_attributes(user_params)
      flash[:success] = "Event updated"
      redirect_to events_url
    else
      render 'edit'
    end
  end


  def destroy
    Event.find(params[:id]).destroy
    flash[:success] = "Event successfully deleted"
    redirect_to events_url
  end

  private
  def user_params # to prevent mass assginement security vulnerabily
    params.require(:event).permit(:name, :date, :league_id, :active )
  end
end
