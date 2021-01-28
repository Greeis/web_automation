# frozen_string_literal: true

# Classe da pagina home do sitema Siga
class SigaHomePage < SitePrism::Page
  element  :btn_pesquisar_item,  '.field_details'
  element  :input_item,          '.service_item_id'
  element  :painel_workflow,     '.dashboardgadget'

  include Capybara::DSL

  def pesquisar_ordem_servico(item)
    input_item.set item
    btn_pesquisar_item.click
    sleep 2
  end
end
