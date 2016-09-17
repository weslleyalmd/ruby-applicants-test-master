class Model < ActiveRecord::Base
  def self.persist_models(make_id)
    return nil if make_id.blank?
    #search the models
    uri = URI("http://www.webmotors.com.br/carro/modelos")

    # Make request for Webmotors site
    make = Make.where(webmotors_id: make_id)[0]

    response = Net::HTTP.post_form(uri, { marca: make_id })
    models_json = JSON.parse response.body

    # Itera no resultado e grava os modelos que ainda não estão persistidas
    models_json.each do |json|
      if Model.where(name: json["Nome"], make_id: make.id).size == 0
        Model.create(make_id: make.id, name: json["Nome"])
      end
    end
  end

  def self.get_models(make_id)
    return [] if make_id.blank?
    make = Make.where(webmotors_id: make_id)[0]
    return Model.where(make_id: make.id)
  end
end
