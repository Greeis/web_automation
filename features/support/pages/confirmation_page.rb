# frozen_string_literal: true

# Classe com o mapeamento e acoes dos elementos da pagina de confirmacao
class ConfirmationPage < SitePrism::Page
  element  :numero_reserva,             '.cod.ng-binding'
  elements :detalhes_voo,               'div[class*=seat-map-locator__title]'
  element  :titulo_reserva,             '.reserve-number-text', wait: 50
  element  :modal_cancelamento,         '#modal-confirm-cancel-order-sameday'
  element  :titulo_modal_cancelamento,  '.confirm-cancel-order_title'
  element  :reserva_modal_cancelamento, '.confirm-cancel_order_number'
  element  :termos_cancelamento,        '.terms-and-conditions'
  element  :check_termo_cancelamento,   '.terms-and-conditions input[ng-model*=AcceptTerms]'
  element  :modal_confirmacao,          '#modal-aviso', wait: 30
  element  :info_importante_cancel,     '.confirm-cancel-order_information_box'
  element  :termos_cancelamento,        '.confirm-cancel-order_confirmation_accept_terms'
  element  :modal_solicitar_cancel,     '#modal-confirm-cancel-order-notsameday'
  elements :valores_extrato_cancel,     '.confirm-cancel-order_extract_item_title'
  elements :valor_total,                'li.payment_val_col.payment_val_col--total'
  element  :valor_total_cobrado,        '.payment__total-value strong'
  elements :pax_rows,                   '.passengers-row'
  elements :fly_rows,                   '.reservation_fly_list'
  element  :info_importantes,           '.information.important'
  element  :detalhes_reserva,           '.detail-reservation'
  element  :msg_reserva,                'h1.message-title'
  element  :bnt_cancelar,               '.md-close'

  include Capybara::DSL

  def pegar_numero_reserva
    sleep 10
    numero_reserva.text
  end

  def pegar_loc
    within(detalhes_voo[0]) do
      find('.ng-binding').text
    end
  end

  def valor_total_pagamento
    valor_total[1].text.gsub(/[R$ .]/, '').to_f
  end

  def valor_total_cobrado
    valor_total_cobrado.text.gsub(/[R$ .]/, '').to_f
  end

  def pegar_msg_modal
    within(modal_confirmacao) do
      find('p').text
    end
  end
end
