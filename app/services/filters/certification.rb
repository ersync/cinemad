module Filters
  class Certification < BaseFilter
    def applicable?
      Array(@params[:certifications]).any?
    end

    def apply(relation)
      relation.where(age_rating: Array(@params[:certifications]))
    end
  end
end