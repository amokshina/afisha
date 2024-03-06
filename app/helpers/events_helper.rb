module EventsHelper
  def event_type_options
    %w[Cinema Theatre Concerts Exhibitions Other].map do |event_type|
      [t("events.event_types.#{event_type}"), event_type]
    end
  end
end