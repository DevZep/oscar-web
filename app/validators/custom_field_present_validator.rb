class CustomFieldPresentValidator < ActiveModel::Validator

  def initialize(record)
    @record = record
  end

  def validate
    CustomField.find_by(entity_name: @record.class.name).field_objs.each do |field|
      if field['required'] && @record.properties_objs[field['name']].blank?
        @record.errors.add(field['name'], "can't be blank")
      end
    end
  end
end
