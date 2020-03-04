class UserStructuresController < ApplicationController
  skip_before_action :verify_authenticity_token, raise: false

  def index
    @structures = Structure.all
  end

  def build
    check_resources
  end

  private

  def check_resources
    structure = Structure.find_by(unit_name: params[:structure])
    if !current_user.nil?
      if structure.nil?
        render json: {msg: 'error dosent exist'}
      else
        if buystructures(structure)
          render json: {structure: structure, ok: true}
        else
          render json: {ok: false}
        end
      end
    end
  end

  def buystructures(structure)
    bool = true
    resources = current_user.user_resources
    structures = current_user.user_structures
    structure.attributes.each do |attr_name, attr_value|
      if attr_name == 'water' || attr_name == 'wood'  ||  attr_name == 'gold' || attr_name == 'iron'
        user_amount = resources.find_by(resource_id: Resource.find_by(name: attr_name).id).amount
        bool = false if !(user_amount >= attr_value)
      end
    end
    if structures.where(structure_id: structure.id)
      structures.find_by(structure_id: structure.id).amount += 1
      structures.find_by(structure_id: structure_id).save!
    else
      structures.create!(structure_id: structure.id, amount: 1, placed: 0)
    end
    bool
  end
end



