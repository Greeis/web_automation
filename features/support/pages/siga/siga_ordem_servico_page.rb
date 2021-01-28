# encoding: UTF-8
# frozen_string_literal: true

# Classe
class SigaOrdemServicoPage < SitePrism::Page
  element  :alerta_alteracao,     '#messagesExhibitor'
  element  :btn_analise_risco,    '.analiserisco'
  element  :input_descricao,      '#txtDescriptionReasons'
  element  :opcao_teste,          '#Teste'
  element  :modal_analise_risco,  '.modal.riskAnalysis'
  element  :select_status,        '.statusSelect'

  include Capybara::DSL

  def alterar_status_cancelamento
    select_status.find('option', text: 'Em Cancelamento Automático').click
    opcao_teste.click
    input_descricao.set 'Teste'
    click_button 'Confirmar'
    sleep 2
  end

  def pega_status
    select_status.all('option')[0].text
  end

  def acessar_analise_risco
    btn_analise_risco.click
  end

  def regristro_analise_risco
    within(modal_analise_risco) do
      within('table') do
        all('tr')[1].text
      end
    end
  end
end
