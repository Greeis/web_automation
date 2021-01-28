# encoding: UTF-8
# frozen_string_literal: true

require_relative 'home_motor_section'

# Classe com o mapeamento e acoes dos elementos da pagina home
class HomePage < SitePrism::Page
  set_url  '/'

  section  :motor, MotorSection,    '.search-b'

  element  :btn_passagens_aereas,   '.btn-passagens-aereas'
  element  :btn_close_modal,        '.btn-close-modal'
  element  :btn_acessa_via_google,  '.btn-google'
  element  :btn_entrar,             '#btn-acesse-3'
  element  :img_usr_facebook,       'img[src*=facebook]'
  element  :img_usr_google,         'img[ng-src*=google]'
  element  :link_acesse_sua_conta,  'a[title="Acesse ou Crie sua conta"]'
  element  :logo,                   '#img_logo'
  element  :modal_covid,            '#coronavid19-modal'
  element  :modal_checkout,         '#checkoutAbandon'
  element  :nome_usuario,           '#btn-perfil-1'

  include Capybara::DSL

  def acessar_menu_passagens_aereas
    btn_passagens_aereas.click
  end

  def acessar_menu_pacotes
    find('.vn_menu_item', text: 'Pacotes de Viagem').click
  end

  def retornou_resultado?
    resultado = true
    RecommendationPage.new.wait_recommendation_page
    if page.has_selector?('.resulterror-inf', wait: 1)
      resultado = false
      @data = nil
      @total_clicks = nil
    end
    resultado
  end
end
