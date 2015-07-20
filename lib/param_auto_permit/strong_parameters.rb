require 'param_auto_permit/verifier'

module ParamAutoPermit
  module StrongParameters

    class InvalidModelProvided < StandardError; end

    def auto_permit(required_form_id, *filters)
      if self['permitted_fields']
        form_id, fields = ParamAutoPermit.verifier.verify(self['permitted_fields'])
        unless form_id == required_form_id
          raise InvalidModelProvided, "Form ID was `#{form_id}` but should be `#{required_form_id}`"
        end
        filters = filters | fields
      end
      permit(*filters)
    end

  end
end
