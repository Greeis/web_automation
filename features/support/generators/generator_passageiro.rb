# frozen_string_literal: true

require './features/support/generators/entity/passageiro'

# Classe geradora de passageiros
class GeneratorPassageiro
  attr_accessor :lista_pax

  def initialize
    @lista_pax = []
    @nomes_pax = YAML.load_file(File.join(Dir.pwd, 'features/support/generators/fixtures/passageiros.yml'))
  end

  def generator_primeiro_adulto
    passageiro_adulto = Passageiro.new
    passageiro_adulto.nome = @nomes_pax['Passageiros']['Nomes'][0]
    passageiro_adulto.sobrenome = @nomes_pax['Passageiros']['Sobrenomes'][0]
    data_nascimento = Faker::Date.birthday(min_age: 18, max_age: 99)
    passageiro_adulto.nascimento = data_nascimento.strftime('%d/%m/%Y')
    passageiro_adulto.idade = age(data_nascimento)
    passageiro_adulto.genero = %w[Masculino Feminino].sample
    @lista_pax.push(passageiro_adulto.nome)
    passageiro_adulto
  end

  def generator_adulto
    passageiro_adulto = new_passenger
    data_nascimento = Faker::Date.birthday(min_age: 18, max_age: 99)
    passageiro_adulto.nascimento = data_nascimento.strftime('%d/%m/%Y')
    passageiro_adulto.idade = age(data_nascimento)
    passageiro_adulto.genero = %w[Masculino Feminino].sample
    passageiro_adulto
  end

  def generator_crianca
    passageiro_crianca = new_passenger
    data_nascimento = Faker::Date.birthday(min_age: 2, max_age: 11)
    passageiro_crianca.nascimento = data_nascimento.strftime('%d/%m/%Y')
    passageiro_crianca.idade = age(data_nascimento)
    passageiro_crianca.genero = %w[Masculino Feminino].sample
    passageiro_crianca
  end

  def generator_bebe
    passageiro_bebe = new_passenger
    data_nascimento = Faker::Date.birthday(min_age: 0, max_age: 1)
    passageiro_bebe.nascimento = data_nascimento.strftime('%d/%m/%Y')
    passageiro_bebe.idade = age(data_nascimento)
    passageiro_bebe.genero = %w[Masculino Feminino].sample
    passageiro_bebe
  end

  def generator_janethy
    passageiro = Passageiro.new
    passageiro.nome = 'Janethy'
    passageiro.sobrenome = 'Oriundi'
    passageiro.nascimento = Faker::Date.birthday(min_age: 18, max_age: 100).strftime('%d/%m/%Y')
    passageiro.genero = 'Feminino'
    passageiro
  end

  def generator_list_pax
    lista = []
    lista.push(generator_primeiro_adulto)
    lista.push(generator_crianca)
    lista.push(generator_bebe)
    lista
  end

  def new_passenger
    passageiro = Passageiro.new
    quantidade = @nomes_pax['Passageiros']['Nomes'].count - 1
    posicao = rand(1..quantidade)
    passageiro.nome = @nomes_pax['Passageiros']['Nomes'][posicao]
    passageiro.nome = @nomes_pax['Passageiros']['Nomes'][rand(1..quantidade)] while @lista_pax.include?(passageiro.nome)
    @lista_pax.push(passageiro.nome)
    passageiro.sobrenome = @nomes_pax['Passageiros']['Sobrenomes'][0]
    @lista_pax.push(passageiro.nome)
    passageiro
  end

  def age(date)
    now = Time.now.utc.to_date
    now.year - date.year - (now.month > date.month || (now.month == date.month && now.day >= date.day) ? 0 : 1)
  end
end
