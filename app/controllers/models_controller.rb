class ModelsController < ApplicationController
  def index
    Model.persist_models(params[:webmotors_make_id])

    @models = Model.get_models(params[:webmotors_make_id])

  end
end
