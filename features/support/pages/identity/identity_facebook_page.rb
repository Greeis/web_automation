# frozen_string_literal: true

# Classe da pagina de login do Gmail
class LoginFacebookPage < SitePrism::Page
  element :btn_entrar_facebook,  '#loginbutton'
  element :input_email_facebook, '#email'
  element :input_senha_facebook, '#pass'
  element :btn_continuar,        'button[name=__CONFIRM__]'

  def logar_facebook
    email = USUARIOS['facebook']['email']
    senha = USUARIOS['facebook']['senha']
    input_email_facebook.set email
    input_senha_facebook.set senha
    btn_entrar_facebook.click
  end
end
