# frozen_string_literal: true

require './features/support/generators/entity/iata'

# Classe Recommendation
class Recommendation
  attr_accessor :flights
  attr_accessor :prices
  attr_accessor :bagagem_inclusa

  def initialize
    @flights = []
  end

  def add_flight(flight)
    @flights.push(flight) if flight
  end
end

# Classe Fights
class Flight
  attr_accessor :num_voo
  attr_accessor :num_aeronave
  attr_accessor :segmento
  attr_accessor :origem
  attr_accessor :destino
  attr_accessor :cia
  attr_accessor :dt_partida
  attr_accessor :hr_partida
  attr_accessor :dt_chegada
  attr_accessor :hr_chegada
  attr_accessor :parada
  attr_accessor :duracao
  attr_accessor :classe

  def initialize
    @destino = Iata.new
    @origem = Iata.new
  end
end

# Classe Prices
class Prices
  attr_accessor :vl_pessoa
  attr_accessor :vl_adulto
  attr_accessor :vl_crianca
  attr_accessor :vl_bebe
  attr_accessor :vl_taxas
  attr_accessor :vl_financiamento
  attr_accessor :vl_total
end
