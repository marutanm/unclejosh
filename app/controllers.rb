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

Unclejosh.controllers :users do
  post :index do
    begin
      user = User.create! name: params[:name]
    rescue
      halt 503, 'user name duplicated'
    end
    render 'user', locals: { user: user }
  end

  get :index, :with => :id do
    user = User.find_by(id: params[:id]) if params[:id]
    render 'user', locals: { user: user }
  end
end
