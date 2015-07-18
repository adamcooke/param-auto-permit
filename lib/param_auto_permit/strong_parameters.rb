require 'param_auto_permit/verifier'

module ParamAutoPermit
  module StrongParameters
    def self.included(base)
      base.class_eval do
        alias_method_chain :permit, :auto_attribute_permit
      end
    end

    def permit_with_auto_attribute_permit(*filters)
      if filters.delete(:_auto)
        fields = ParamAutoPermit.verifier.verify(self['permitted_fields'])
        permit_without_auto_attribute_permit(*(fields | filters))
      else
        permit_without_auto_attribute_permit(*filters)
      end
    end
  end
end
