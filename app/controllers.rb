Unclejosh.controllers :heros do

  get :index, :with => :id do
    hero = Hero.find(params[:id])
    render 'hero', locals: { hero: hero }
  end

  post :index do
    hero = Hero.create_with_name params[:name]
    render 'hero', locals: { hero: hero }
  end

end

Unclejosh.controllers :battles do
  get :index, :with => :id do
    battle = Battle.find_by(id: params[:id])
    render 'battle', locals: { battle: battle }
  end
end
