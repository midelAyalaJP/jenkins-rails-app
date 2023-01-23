class ConceptSerializer < ActiveModel::Serializer
  attributes :id, :spanish_description, :english_description

  attribute :category, if: :show_category


  #category values
  def category
    category = self.object.category
    {
        id: category.id,
        spanish_description: category.spanish_description,
        english_description: category.english_description
    }
  end
 

  #send category to response
  def show_category
    if(@instance_options[:route] == 'show')
        return true;
    end
    false
  end
end
