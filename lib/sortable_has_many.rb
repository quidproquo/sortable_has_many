module SortableHasMany

  module ClassMethods
    
    def sortable_has_many_through(has_many_field, type)
      has_many_field = has_many_field.to_s
      type = type.to_s
      type_id = "#{type}_id"

      define_method "#{type}_ids=" do |ids|
        rel_entities = public_send(has_many_field)
        ids = ids.select(&:present?).collect(&:to_i)
        rel_entities.select{|rel_entity| !ids.include?(rel_entity.public_send(type_id)) }.each{ |rel_entity| rel_entities.delete(rel_entity) }
        current_ids = rel_entities.collect{ |entity| entity.public_send type_id }
        ids.each_with_index do |id, index|
          if current_ids.include?(id)
            rel_entities.find{ |sc| sc.public_send(type_id) == id }.position = (index+1)
          else
            rel_entities.build({type_id => id, :position => (index+1)})
          end
        end

      end
    end #sortable_has_many_through
    
    def sortable_has_many_as(has_many_field, as)
      has_many_field = has_many_field.to_s
      
      define_method "#{has_many_field.singularize}_ids=" do |ids|
        entities = public_send(has_many_field)
        ids = ids.select(&:present?).collect(&:to_i)
        # Remove entities not in the list of ids (those that have been cleared)
        entities.select { |entity|
          !ids.include?(entity.id)
        }.each { |entity|
          entities.delete(entity)
        }
        # Reset the positions
        remaining_ids = entities.collect(&:id)
        ids.each_with_index do |id, index|
          position = index + 1
          if remaining_ids.include?(id)
            entities.find { |entity| entity.id == id }.position = position
          else
            entities.build({as => self, :position => position})
          end
        end
      end
    end #sortable_has_many_as

  end

end

class ActiveRecord::Base
  include SortableHasMany
end

