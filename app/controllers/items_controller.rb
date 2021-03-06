class ItemsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    all_items = Item.all
    @items = []
    all_items.each do |item|
      item.set_wish(current_user)
      item.set_cart(current_user)
      @items << item if item.sold.nil?
    end
    @photo = Photo.new
    
    render :json => @items
    
    #.as_json(:include => :photos)
  end
  
  def new
    @categories = Category.all
    @item = current_user.sell_items.build
    @prime_photo = Photo.new
    @photo1 = Photo.new
    @photo2 = Photo.new
    @photo3 = Photo.new
  end
  
  def create
    @categories = Category.all
    @item = current_user.sell_items.build(params[:item])
    if @item.save
      redirect_to root_url
    else
      render :new
    end
  end
  
  def edit
    
  end
  
end
