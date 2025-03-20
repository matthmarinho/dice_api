class HomeController < ApplicationController
  def index
    @routes = fetch_routes
  end

  private

  def fetch_routes
    Rails.application.routes.routes.map do |route|
      {
        verb: route.verb.is_a?(String) ? route.verb.gsub(/[$^]/, "") : nil,
        path: route.path.spec.to_s,
        controller: route.defaults[:controller],
        action: route.defaults[:action]
      }
    end.select { |r| r[:controller].present? }
  end
end
