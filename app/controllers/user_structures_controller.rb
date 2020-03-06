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
        @data = {msg: 'error doesn\'t exist'}
        # redirect_to new_user_unit_path
      else
        if buystructures(structure)
          @data = {structure: structure, ok: true}
          # redirect_to new_user_unit_path
        else
          @data = {structure: structure, ok: false}
          # redirect_to new_user_unit_path
        end
      end
    end
    @resources = current_user.resources_amounts
  end

  def deplete_user_resources(structure)
    user_resources = current_user.user_resources
    structure.attributes.each do |attr_name, attr_value|
      if attr_name == 'water' || attr_name == 'wood'  ||  attr_name == 'gold' || attr_name == 'iron'
        user_resource = user_resources.find_by(
          resource: Resource.find_by(name: attr_name))
        user_resource.amount -= attr_value
        user_resource.save
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
    if bool
      deplete_user_resources(structure)
      if structures.where(structure_id: structure.id)
        str = structures.find_by(structure_id: structure.id)
        str.update(amount: (str.amount + 1))
      else
        # binding.pry
        structures.create!(structure_id: structure.id, amount: 1, placed: 0)
      end
    end
    bool
  end
end



