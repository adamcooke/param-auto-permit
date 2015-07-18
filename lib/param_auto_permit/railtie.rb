module ParamAutoPermit
  class Railtie < Rails::Railtie

    initializer 'param_auto_permit.initialize' do
      ActiveSupport.on_load(:action_view) do
        require 'param_auto_permit/form_builder'
        ActionView::Helpers::FormBuilder.send :include, ParamAutoPermit::FormBuilder
      end

      ActiveSupport.on_load(:action_controller) do
        require 'param_auto_permit/strong_parameters'
        ActionController::Parameters.send :include, ParamAutoPermit::StrongParameters
      end
    end

  end
end
