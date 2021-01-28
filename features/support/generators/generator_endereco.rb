# frozen_string_literal: true

require './features/support/generators/entity/endereco'
# Classe geradora de endereco
class GeneratorEndereco
  def generator_endereco
    endereco = Endereco.new
    endereco.cep = '09510111'
    endereco.nome_endereco = 'Rua Manoel Coelho'
    endereco.numero_endereco = '600'
    endereco.bairro = 'Centro'
    endereco.cidade = 'Sao Caetano do Sul'
    endereco.estado = 'SAO PAULO'
    endereco
  end
end
