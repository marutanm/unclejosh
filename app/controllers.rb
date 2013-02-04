Unclejosh.controllers :heros do

  get :index, :with => :id do
    @hero = Hero.find(params[:id])
    render 'hero'
  end

  post :index do
    @hero = Hero.create_with_name params[:name]
    render 'hero'
  end

end
