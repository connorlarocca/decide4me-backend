class FavoritesController < ApplicationController
  before_action :authenticate_user

  def index
    @favorites = Favorite.all
    render @favorites.as_json
  end

  def show
    @favorite = Favorite.find_by(id: params[:id])
    render @favorite.as_json
  end

  def create
    favorite = Favorite.create(
      user_id: current_user.id,
      restaurant_id: params[:restaurant_id],
    )
    if favorite.save
      render json: favorite.as_json
    else
      render json: { errors: @favorite.errors.full_messages }, status: 418
    end
  end

  def update
    favorite = Favorite.find_by(id: params[:id])
    favorite.update(
      start_date: params[:start_date] || favorite.start_date,
      end_date: params[:end_date] || favorite.end_date,
      degree: params[:degree] || favorite.degree,
      university_name: params[:university_name] || favorite.university_name,
      details: params[:details] || favorite.details,
    )
    if favorite.save
      render json: favorite.as_json
    else
      render json: { errors: @favorite.errors.full_messages }, status: 418
    end
  end

  def destroy
    favorite = Favorite.find_by(id: params[:id])
    favorite.destroy
    render json: { message: "Favorite destroyed successfully" }
  end
end