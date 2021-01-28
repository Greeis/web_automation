# encoding: UTF-8
# frozen_string_literal: true

# Classe com o mapeamento e acoes dos elementos da pagina da minha conta
class MinhaContaPage < SitePrism::Page
  element  :alerta_erro,                         '#tooltip-validator'
  element  :btn_gmail,                           '.btn-google'
  element  :btn_facebook,                        '.btn-facebook'
  element  :input_email,                         '#emailsuper'
  element  :input_senha,                         '#senhasuper'
  element  :input_nova_senha,                    '#newpass'
  element  :input_confirmacao_senha,             '#confirmpass'
  element  :input_recupera_senha,                '#recupera_senha'
  element  :input_nova_senha_recuperada,         '#senhasuper'
  element  :input_confirmacao_senha_recuperada,  '#senhasuperconfirm'
  element  :link_criar_conta,                    'a[href*=sign-up]'
  element  :modal_aviso,                         '.md-effect-aviso'
  element  :modal_alerta,                        '.modal-effect-alerta p'
  element  :titulo_modal_alerta,                 '.modal-effect-alerta h3'
  element  :txt_modal_recuperar_senha,           '#modal-recuperar-senha p'
  element  :txt_modal_aviso,                     '#modal-aviso div p'

  include Capybara::DSL

  def escolher_criar_conta
    link_criar_conta.click
  end

  def logar(email, senha)
    input_email.set email
    input_senha.set senha
    click_button 'Entrar'
  end

  def criar_conta(email, senha, confirmacao_senha)
    input_email.set email
    input_nova_senha.set senha
    input_confirmacao_senha.set confirmacao_senha
    click_button 'Cadastrar'
  end

  def esqueci_minha_senha
    find('a', text: 'Esqueceu sua senha?').click
  end

  def recuperar_senha(email)
    input_recupera_senha.set email
    click_button 'Enviar e-mail de recuperação'
  end

  def criar_nova_senha(senha, confirmacao_senha)
    input_nova_senha_recuperada.set senha
    input_confirmacao_senha_recuperada.set confirmacao_senha
    click_button 'Salvar'
  end
end
