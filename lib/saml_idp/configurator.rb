require "ostruct"
module SamlIdp
  class Configurator
    attr_accessor :x509_certificate, :secret_key, :password, :algorithm, :organization_name, :organization_url, :base_saml_location, :entity_id, :reference_id_generator, :attribute_service_location, :single_service_post_location, :single_logout_service_post_location, :single_logout_service_redirect_location, :attributes, :service_provider, :assertion_consumer_service_hosts, :session_expiry

    def initialize()
      self.x509_certificate = Default::X509_CERTIFICATE
      self.secret_key = Default::SECRET_KEY
      self.algorithm = :sha1
      self.reference_id_generator = ->() { UUID.generate }
      self.service_provider = OpenStruct.new
      self.service_provider.finder = ->(_) { Default::SERVICE_PROVIDER }
      self.service_provider.metadata_persister = ->(id, settings) {  }
      self.service_provider.persisted_metadata_getter = ->(id, service_provider) {  }
      self.session_expiry = 0
      self.attributes = {}
    end

    # formats
    # getter
    def name_id
      @name_id ||= OpenStruct.new
    end

    def technical_contact
      @technical_contact ||= TechnicalContact.new
    end

    class TechnicalContact < OpenStruct
      def mail_to_string
        "mailto:#{email_address}" if email_address.to_s.length.positive?
      end
    end
  end
end
