# frozen_string_literal: true

require './features/support/generators/entity/pagamento'

# Classe geradora de pagamento
class GeneratorPagamento
  def initialize
    @cartoes = YAML.load_file(File.join(Dir.pwd, 'features/support/generators/fixtures/pagamentos.yml'))
  end

  def generator_pagamento_credito(bandeira)
    pagamento_credito = PagamentoCredito.new
    pagamento_credito.bandeira = bandeira
    pagamento_credito.descricao = @cartoes['Bandeiras'][bandeira]['descricao']
    pagamento_credito.numero_cartao = @cartoes['Bandeiras'][bandeira]['numero-cartao']
    pagamento_credito.mes_vencimento = ajusta_num rand 1..12
    pagamento_credito.ano_vencimento = rand 2021..2026
    pagamento_credito.cvv_cartao = generator_cvv(bandeira)
    pagamento_credito.cpf = Faker::CPF.number
    pagamento_credito.nome = 'Janethy Oriundi'
    pagamento_credito
  end

  def generator_cvv(bandeira)
    case bandeira
    when 'American Express'
      Faker::Number.number(digits: 4)
    else
      Faker::Number.number(digits: 3)
    end
  end

  def generator_bandeira
    %w[Visa Mastercard].sample
  end

  def ajusta_num(num)
    num_ajustado = num
    num_ajustado = "0#{num}" if num < 10
    num_ajustado
  end
end
