class EventsController < ApplicationController
  before_action :signed_in_user, only: [:index, :resuts,:edit, :update, :destroy, :enter_result, :new, :enter_result, :enter_empty_results,:enter_results, :result, :search, :search_by_id, :save_result, :show]
  before_action :permited_user, only: [:new,:results, :enter_results,:update, :edit, :destroy, :enter_empty_results, :save_results, :create]
  def new
    @event = Event.new
     1.times do 
      bet = @event.bets.build
      1.times {bet.bet_items.build}
    end
    @leagues = League.all
   
      @league_id = params[:id]  # we need this incase the event is beig created from the league menu
    
  end

  def index
   
    @events = nil
    if params[:id].nil?
       @events = Event.all  # if the user didn't select a particluar league then list all events
     else
      @events = Event.been_played(params[:id])
    end
    respond_to do |format| 
        format.js
        format.html
      end
  end

  def enter_result  # used to enter the result on completed events
    @event = Event.find(params[:id])
    respond_to do |format|
      format.js
      format.html
    end
   

  end

  #find all events that have their result values empty so we can enter them
  def enter_empty_results

   @events = Event.played_not_entered

  end


  def result # present the results tab
    store_location
    @sports = League.all
    @status = "active"
  end

   def results # present the results tab
    store_location
    @sports = League.all
    @status = "active"
  end

  def search # method used to seach for a event
    searchstring = "%"+params[:q]+"%"
    @events = Event.where(Event.arel_table[:name].matches(searchstring))
      if (!@events) 
           flash[:warning] = "Event not found"
           redirect_to events_url

       
     
   
    end
  end
     def search_by_id # method used to seach for a event
    searchstring = params[:q].to_i
    @events = Event.where(:id => searchstring)
      if (!@events) 
           flash[:warning] = "Event not found"
           redirect_to events_url
      end
      render 'events/search'

  end



  # this method will collect the event ID from the user then present the form 
  # that allows the placing of bets----> currently not used
  def addbet

    @event = Event.find(params[:id])
   # @id = params[:id]

      
  end

  def save_result  # save the results of the event
    @event = Event.find(params[:id])
      if @event.update_attributes(result_params)
      flash[:success] = "Results Entered"
      redirect_to results_path
    else
      redirect_to 'enter_empty_results'
    end
    

  end

    def save_results  # when many results are being updated at once
      
       

      if Event.update(params[:event].keys, params[:event].values)
      flash[:success] = "Results Entered"
      redirect_to :back
    else
      redirect_to 'enter_results'
    end
    

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

  def removebet
    Bet.find(params[:id]).dexstroy
  end


  def showbets
    @event = params[:eventid]

    #check if this event has any bets
    @bets = Bet.find_by_event_id(event.id)
    # in the view we will only render the bets and thier respective bet items if !@bets.nil? is true
  end

  def show
    @event = Event.find(params[:id])
    @bets = @event.bets

    respond_to do |format|
      format.js
      format.html
    end
  end
 
  def create
    @event = Event.new(user_params) # save the event

       @event.date = params[:date]
    if !(params[:lid].nil?)
      @event.league_id = params[:lid]
    end
    
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
   # @event.bets.build

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
      redirect_to events_path
    else
      render 'edit'
    end
  end

  def test_boot_strap

  end
  def destroy
    Event.find(params[:id]).destroy
    flash[:success] = "Event successfully deleted"
    redirect_to :back
  end

  def permited_user
    redirect_to (root_url) unless current_user.role_id <3
  end

  private
  def user_params # to prevent mass assginement security vulnerabily
    params.require(:event).permit(:name, :date, :league_id, :active, bets_attributes:[:id,:name, :bet_type_id, :_destroy, bet_items_attributes:[:id,:name,:odds,:_destroy]])
  end

  def result_params # prevent mass assignments and only update specific attributes of the event related to saving results
    params.require(:event).permit(:result, bets_attributes:[:id,bet_items_attributes:[:id,:name,:active]])
  end

end
