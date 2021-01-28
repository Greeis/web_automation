# frozen_string_literal: true

# Classe com o mapeamento e acoes dos elementos da pagina das minhas reservas na minha conta
class MinhaContaReservasPage < SitePrism::Page
  elements :minhas_reservas,     '.bx-reserva'
  element  :btn_cancelar,        '#btnCancelOrder'
  element  :txt_status_reserva,  '.tooltip-status'

  include Capybara::DSL

  def cancelar_reserva(numero_reserva)
    all('.bx-reserva').each do |reserva|
      within(reserva) do
        numero = find('h2').text.gsub(/[a-zA-Z ]/, '')
        return btn_cancelar.click if numero == numero_reserva
      end
    end
  end

  def pegar_status_reserva(numero_reserva)
    minhas_reservas.each do |reserva|
      within(reserva) do
        numero = find('h2').text.gsub(/[a-zA-Z ]/, '')
        return status_reserva.text if numero == numero_reserva
      end
    end
  end

  def status_reserva(numero_reserva)
    all('.bx-reserva').each do |reserva|
      within(reserva) do
        numero = find('h2').text.gsub(/[a-zA-Z ]/, '')
        return txt_status_reserva.text if numero == numero_reserva
      end
    end
  end
end
