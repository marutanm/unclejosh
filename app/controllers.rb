Unclejosh.controllers :heros do
  get :index do
    hero = Hero.find(params[:id])
    render 'hero', locals: { hero: hero }
  end

  post :index do
    uid = request.env['HTTP_UID']
    halt 403 unless uid
    user = current_user(uid)
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
  post :index do
    begin
      user = User.create! name: params[:name]
    rescue
      halt 503, 'user name duplicated'
    end
    render 'user', locals: { user: user }
  end

  get :index do
    user = current_user(env['uid'])
    user = User.find(params[:id]) if params[:id]
    render 'user', locals: { user: user }
  end
end
