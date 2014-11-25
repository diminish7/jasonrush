class PostPolicy < ApplicationPolicy
  alias :post :record

  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.present?
  end

  def new?
    create?
  end

  def update?
    user.present? && post.author_id == user.id
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end
end