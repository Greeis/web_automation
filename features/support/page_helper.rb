# frozen_string_literal: true

Dir[File.join(File.dirname(__FILE__), '../support/pages/*_page.rb')].sort.each { |file| require file }

# Modulo responsavel por instanciar as classes Pages Objects
module PageObjects
  def home_page
    @home_page ||= HomePage.new
  end

  def recommendation_page
    @recommendation_page ||= RecommendationPage.new
  end

  def checkout_page
    @checkout_page ||= CheckoutPage.new
  end

  def confirmation_page
    @confirmation_page ||= ConfirmationPage.new
  end

  def minha_conta_page
    @minha_conta_page ||= MinhaContaPage.new
  end

  def meus_dados_page
    @meus_dados_page ||= MinhaContaDadosPage.new
  end

  def minha_reservas_page
    @minha_reservas_page ||= MinhaContaReservasPage.new
  end

  def identity_page
    @identity_page ||= IdentityPage.new
  end

  def login_gmail
    @login_gmail ||= LoginGmailPage.new
  end

  def login_facebook
    @login_facebook ||= LoginFacebookPage.new
  end

  def siga_home_page
    @siga_home_page ||= SigaHomePage.new
  end

  def siga_login_page
    @siga_login_page ||= SigaLoginPage.new
  end

  def siga_ordem_servico_page
    @siga_ordem_servico_page ||= SigaOrdemServicoPage.new
  end
end
