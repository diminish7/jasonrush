# Currently blogs are read-only because some amount of
# dashboard design needs to go into adding/removing/renaming
class BlogPolicy < ApplicationPolicy
  alias :post :record

  def index?
    true
  end

  def show?
    true
  end

  def create?
    false
  end

  def new?
    false
  end

  def update?
    false
  end

  def edit?
    false
  end

  def destroy?
    false
  end
end