module Api
  module V1
    module Politicians
      class ListController < ApplicationController
        def handler
          politicians = Politician.all

          render json: PoliticianListSerializer.new(politicians).serializable_hash.to_json, status: :ok
        end
      end
    end
  end
end
