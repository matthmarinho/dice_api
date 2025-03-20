class HomeController < ApplicationController
  def index
    @routes = fetch_routes
    render json: { routes: @routes }
  end

  private

  def fetch_routes
    Rails.application.routes.routes.map do |route|
      {
        verb: route.verb.is_a?(String) ? route.verb.gsub(/[$^]/, "") : nil,
        path: route.path.spec.to_s,
        controller: route.defaults[:controller],
        action: route.defaults[:action],
        params: route.required_parts
      }
    end.select { |r| r[:controller].present? && %w[home rolls].include?(r[:controller]) }
  end
end
