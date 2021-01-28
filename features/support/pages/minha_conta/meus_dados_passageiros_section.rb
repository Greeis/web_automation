# encoding: UTF-8
# frozen_string_literal: true

# Classe com o mapeamento e acoes dos elementos da secao form de passageiros
class FormPassageirosSection < SitePrism::Section
  elements :links_excluir_passageiros,   '.link-del-passenger'
  elements :passageiros,                 'li[id*=passenger]'
  element  :btn_save_pax,                '#btnSavePax'

  def excluir_todos_passageiros
    return unless has_passageiros?(wait: 0.5)

    click_link 'Editar'
    links_excluir_passageiros[0].click while has_links_excluir_passageiros?(wait: 0.5)
    btn_save_pax.click
  end

  def excluir_passageiro
    click_link 'Editar'
    links_excluir_passageiros[0].click
    btn_save_pax.click
  end

  def adicionar_passageiro(passageiro, index)
    click_link 'Editar' if has_selector?('a', text: 'Editar', wait: 0.5)
    click_link 'Adicionar novo passageiro'
    find("#nome_passenger_#{index}").set passageiro.nome
    find("#sobrenome_passenger_#{index}").set passageiro.sobrenome
    find("#datanasc_passenger_#{index}").set passageiro.nascimento
    tipo_genero = find("#gender_passenger_#{index}")
    tipo_genero.select passageiro.genero
    btn_save_pax.click
  end
end
