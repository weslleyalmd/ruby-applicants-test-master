class HomeController < ApplicationController
  def index
    # Get makes from API and persist then
    Make.persist_makes

    @makes = Make.all
  end
end
