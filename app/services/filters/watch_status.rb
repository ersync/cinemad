module Filters
  class WatchStatus < BaseFilter
    def applicable?
      @params[:watch_status].in?(%w[watched unwatched all])
    end

    def apply(relation)
      case @params[:watch_status]
      when 'watched'   then relation.watched_by(@current_user)
      when 'unwatched' then relation.unwatched_by(@current_user)
      else relation
      end
    end
  end
end