Unclejosh.controllers :hero do

  get :index, :with => :id do
    @hero = Hero.find(params[:id])
    render 'hero'
  end

end
