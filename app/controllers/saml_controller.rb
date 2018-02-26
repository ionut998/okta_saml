class SamlController < ApplicationController
  skip_before_action :verify_authenticity_token
  def init
    request = OneLogin::RubySaml::Authrequest.new
    redirect_to(request.create(saml_settings))
  end

  def consume
    response = OneLogin::RubySaml::Response.new(params[:SAMLResponse], :settings => saml_settings)

    if response.is_valid?
      session[:authenticated_user] = response.nameid
      redirect_to root_path
    else
      redirect_to root_path, flash: 'Login failed'
    end
  end

  private

  def saml_settings

    idp_metadata_parser = OneLogin::RubySaml::IdpMetadataParser.new
    # Returns OneLogin::RubySaml::Settings prepopulated with idp metadata
    settings = idp_metadata_parser.parse(idp_metadata)

    settings.assertion_consumer_service_url = "http://localhost:3000/saml/consume"
    settings.issuer                         = "http://localhost:3000"
    settings.name_identifier_format         = "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress"
    # Optional for most SAML IdPs
    settings.authn_context = "urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport"

    settings
  end

  def idp_metadata
    'PASTE HERE the IDP metadata in XML format'
  end
end
