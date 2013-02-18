Unclejosh.controllers :heros do
  get :index do
    hero = Hero.find(params[:id])
    render 'hero', locals: { hero: hero }
  end

  post :index do
    user = current_user(request.env['HTTP_UID'])
    hero = Hero.create_with_name params[:name]
    user.heros << hero
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
  error Mongoid::Errors::Validations do
    halt 503, 'user name duplicated'
  end

  post :index do
    user = User.create! name: params[:name]
    render 'user', locals: { user: user }
  end

  get :index do
    user = current_user(env['uid'])
    user = User.find(params[:id]) if params[:id]
    render 'user', locals: { user: user }
  end
end

Unclejosh.controllers :rankings do
  post :index do
    user = current_user(request.env['HTTP_UID'])
    hero = user.heros.find(params[:hero_id])
    result = challenge_rank hero, 100
    render 'challenge_result', locals: { result: result }
  end
end
