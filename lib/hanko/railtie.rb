require "rails"

module Hanko
  class Railtie < ::Rails::Railtie
    config.hanko = ActiveSupport::OrderedOptions.new

    initializer "hanko.load_action_view" do |app|
      ActiveSupport.on_load(:action_view) do
        Hanko::Init.new(app.config.hanko.digest_class).ready
        Hanko::Fingerprint.cachable = app.config.hanko.cachable
      end
    end
  end
end

