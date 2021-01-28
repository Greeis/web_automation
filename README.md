# **Projeto de Automação Web - Viajanet**

## **Pré-Requisitos**
- Ruby (v2.6.5)
- Gem bundler
- Selenium WebDriver

> **Observação**
> Os passos de preparação do ambiente se encontra no nossa [Wiki](https://tfs.viajanet.com.br/tfs/ViajaNet/TI/_wiki/wikis/TI.wiki?wikiVersion=GBwikiMaster&pagePath=%2FAgile%20QA%20Workshop%2FInstalação%20do%20ambiente)

## **Instalação** 

Siga os passos abaixo para instalação do projeto:

**Clone do Projeto**

```
git clone https://tfs.viajanet.com.br/tfs/ViajaNet/TI/_git/automation_web_viajanet
```
Em casos de erro de certificado, utilize o comando:
```
git clone http://tfs.viajanet.com.br:8080/tfs/ViajaNet/TI/_git/automation_web_viajanet
```

**Local do projeto**
```
cd automation_web_viajanet
```

**Instalar o Bundle**
```
bundle install
```

**Instalar o Selenium WebDriver**

- **ChromeDriver** (Google Chrome): https://chromedriver.storage.googleapis.com/index.html 
- **Geckodriver** (Firefox): https://github.com/mozilla/geckodriver/releases

## **Estrutura do Projeto**

Os arquivos do projeto são organizados da seguinte forma:

    features/specifications - Cenários das funcionalidades em formato BDD
    features/step_definitions - Implementação dos cenários automatizados das funcionalidades
    features/support - Arquivos de suporte da automação
    features/support/pages - Representação das páginas web
    features/support/generators - Arquivos para geração de massa de testes
    logs - Arquivos de logs e relatórios

## **Trabalhando no projeto**

Como padrão, antes de começarmos a trabalhar no projeto, será necessário seguir os passos abaixo:

**1. Trocar de branch (Master > Develop)** 
```
git checkout -b develop origin/develop
```
**2. Sincronizar seu repositorio local com o repositorio remoto**
```
git pull origin
```
**3. Criar uma nova branch**
```
git branch feature/<nome_da_branch>
```

**4. Entrar na branch**
```
git checkout feature/<nome_da_branch>
```

> **Observersão:**
> Em casos de dúvidas de como utilizar o Git, acesse nossa [Wiki](https://tfs.viajanet.com.br/tfs/ViajaNet/TI/_wiki/wikis/TI.wiki?wikiVersion=GBwikiMaster&pagePath=%2FAgile%20QA%20Workshop%2FGit%20e%20GitHub%20%252D%20O%20B%C3%A1sico).
## **Utilidades**
```
gem uninstall --all --ignore-dependencies
gem cleanup
```
**Code lint**
```
rubocop
```
## **Execução dos testes**

- **SmokeTest**
```
cucumber -t @smoke
```
- **Regressão** 
```
cucumber
```
### **Ambientes**

- **Homologação - Capa (Default)**
```
cucumber -t @smoke -p homolog_capa
```
- **Stage**
```
cucumber -t @smoke -p stage
```
- **Produção**
```
cucumber -t @smoke -p producao
```