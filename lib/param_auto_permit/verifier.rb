require 'active_support/message_verifier'

module ParamAutoPermit

  def self.verifier
    @verifier ||= ActiveSupport::MessageVerifier.new(Rails.application.secrets.secret_key_base)
  end

end
