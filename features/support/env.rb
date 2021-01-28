# frozen_string_literal: true

require 'capybara'
require 'capybara/cucumber'
require 'capybara/rspec'
require 'cpf_faker'
require 'date'
require 'faker'
require 'faker_credit_card'
require 'pry'
require 'report_builder'
require 'rspec'
require 'rspec/retry'
require 'selenium-webdriver'
require 'site_prism'
require './features/support/generators/date_format'
require './features/support/page_helper'

puts "Iniciando testes no ambiente #{ENV_TYPE = ENV['AMBIENTE']}..."
ENV_FILE = YAML.load_file("#{File.dirname(__FILE__)}/env.yml")
@browser = ENV['BROWSER']

GLOBAL_TIMEOUT = 20
TIMEOUT = ENV_TYPE == 'stage' || ENV_TYPE == 'producao' ? 2 : 0

###################################
#                                 #
#     Driver Settings             #
#                                 #
###################################

# Chorme Headless

Capybara.register_driver :chrome_headless do |app|
  browser_options = ::Selenium::WebDriver::Chrome::Options.new.tap do |opts|
    opts.args << '--headless'
    opts.args << '--disable-gpu'
    opts.args << '--no-sandbox'
    opts.args << '--disable-site-isolation-trials'
    opts.args << '--window-size=1280,1024'
    opts.args << '--disable-application-cache'
  end
  client = Selenium::WebDriver::Remote::Http::Default.new(open_timeout: 120, read_timeout: 120)
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: browser_options, http_client: client)
end

# Chrome

Capybara.register_driver :chrome do |app|
  client = Selenium::WebDriver::Remote::Http::Default.new(open_timeout: 60, read_timeout: 60)
  browser_options = ::Selenium::WebDriver::Chrome::Options.new.tap do |opts|
    opts.args << '--disable-gpu'
    opts.args << '--no-sandbox'
  end
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: browser_options, http_client: client)
end

# Safari

Capybara.register_driver :safari do |app|
  caps = Selenium::WebDriver::Remote::Capabilities.safari({ useTechnologyPreview: true })
  Capybara::Selenium::Driver.new(app, browser: :safari, desired_capabilities: caps)
end

case @browser
when 'firefox'
  @driver = :selenium
when 'firefox_headless'
  @driver = :selenium_headless
when 'safari'
  @driver = :safari
when 'chrome'
  @driver = :chrome
when 'chrome_headless'
  @driver = :chrome_headless
else
  @driver = :selenium_chrome
  @browser = 'chrome default'
end

puts "Testes sendo executados no navegador #{@browser}"

###################################
#                                 #
#     Capybara Settings           #
#                                 #
###################################

Capybara.configure do |config|
  config.default_driver = @driver
  config.default_max_wait_time = GLOBAL_TIMEOUT
  config.app_host = ENV['URL'].nil? ? ENV_FILE[ENV_TYPE]['web'] : ENV['URL']
end

Capybara.javascript_driver = @driver

RSpec.configure do |config|
  config.verbose_retry = true
  config.default_retry_count = 6
  config.exceptions_to_retry = [Net::ReadTimeout]
end

###################################
#                                 #
#         Massa de dados          #
#                                 #
###################################

caminho = File.dirname(__FILE__)
MSG_CONFIRMATION = YAML.load_file("#{caminho}/generators/fixtures/mensagens/confirmation.yml")
INFO_SITE = YAML.load_file("#{caminho}/generators/fixtures/mensagens/info_site.yml")
USUARIOS = YAML.load_file("#{caminho}/generators/fixtures/usuarios.yml")
COMPANHIAS = YAML.load_file("#{caminho}/generators/fixtures/companhias.yml")

###################################
#                                 #
#          Modulo Global          #
#                                 #
###################################
World(PageObjects)
