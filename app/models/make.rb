class Make < ActiveRecord::Base

  def self.persist_makes
    #search the make
    uri = URI("http://www.webmotors.com.br/carro/marcas")

    # Make request for Webmotors site
    response = Net::HTTP.post_form(uri, {})
    makes = JSON.parse response.body
    makes.each do |make_params|
      if Make.where(name: make_params["Nome"]).size == 0
        Make.create(name: make_params["Nome"], webmotors_id: make_params["Id"])
      end
    end

  end
end
