class TagsController < ApplicationController
  before_action :authenticate_user, except: [:index, :show]

  def index
    @tags = Tag.all
    render json: @tags.as_json
  end

  def show
    @tag = Tag.find_by(id: params[:id])
    render :show
  end

  def create
    tag = Tag.create(
      user_id: current_user.id,
      vegan: params[:vegan],
      vegetarian: params[:vegetarian],
      spicy: params[:spicy],
      gluten_free: params[:gluten_free],
    )
    if tag.save
      render json: tag.as_json
    else
      render json: { errors: tag.errors.full_messages }, status: 418
    end
  end

  def update
    tag = Tag.find_by(id: params[:id])
    tag.update(
      vegan: params[:vegan] || tag.vegan,
      vegetarian: params[:vegetarian] || tag.vegetarian,
      spicy: params[:spicy] || tag.spicy,
      gluten_free: params[:gluten_free] || tag.gluten_free,
    )
    if tag.save
      render json: tag.as_json
    else
      render json: { errors: tag.errors.full_messages }, status: 418
    end
  end

  def destroy
    tag = Tag.find_by(id: params[:id])
    tag.destroy
    render json: { message: "tag destroyed successfully" }
  end
end
