# encoding: UTF-8
# frozen_string_literal: true

# Classe com o mapeamento e acoes dos elementos da pagina idetity
class IdentityPage < SitePrism::Page
  element  :input_email,        '#ipEmailForm'
  element  :input_senha,        '#ipPasswordForm'
  element  :btn_entrar,         '#btSignIn'
  element  :btn_google,         '#btGoogleSignIn'
  element  :btn_facebook,       '#btFacebookSignIn'

  include Capybara::DSL

  def logar(email, senha)
    input_email.set email
    input_senha.set senha
    btn_entrar.click
  end
end
