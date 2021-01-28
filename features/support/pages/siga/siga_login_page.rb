# frozen_string_literal: true

# Classe
class SigaLoginPage < SitePrism::Page
  element  :input_login,     '#Login'
  element  :input_password,  '#Password'
  element  :btn_entrar,      '#Enter'

  include Capybara::DSL

  def acessar_siga
    visit ENV_FILE[ENV_TYPE]['siga']
  end

  def logar_siga
    input_login.set USUARIOS['siga']['login']
    input_password.set USUARIOS['siga']['senha']
    btn_entrar.click
  end
end
