*** Settings ***
Library    Browser
Suite Setup    New Browser    browser=chromium    headless=False
Test Setup     New Context    viewport={'width': 1280, 'height': 720}

*** Variables ***
${URL_BLOG}              https://blogdoagi.com.br/
${LUPA_PESQUISA}         css=#search-open
${CAMPO_PESQUISA}        css=.desktop-search .search-field
${BOTAO_PESQUISAR}       css=.desktop-search .search-submit
${TITULO_RESULTADO}      css=.archive-title
${MENSAGEM_NAO_ENCONTRADO}    css=.entry-title

*** Test Cases ***
Cenário 1: Pesquisa de artigo com sucesso
    [Documentation]    Valida se a pesquisa retorna resultados para um termo existente.
    New Page    ${URL_BLOG}
    Click       ${LUPA_PESQUISA}
    Fill Text   ${CAMPO_PESQUISA}    Empréstimo
    Click       ${BOTAO_PESQUISAR}
    Wait For Elements State    ${TITULO_RESULTADO}    visible
    Get Text    ${TITULO_RESULTADO}    contains    Resultados da busca por: Empréstimo

Cenário 2: Pesquisa de artigo inexistente
    [Documentation]    Valida o comportamento ao pesquisar um termo que não retorna resultados.
    New Page    ${URL_BLOG}
    Click       ${LUPA_PESQUISA}
    Fill Text   ${CAMPO_PESQUISA}    TermoInexistente999
    Click       ${BOTAO_PESQUISAR}
    Wait For Elements State    ${MENSAGEM_NAO_ENCONTRADO}    visible
    Get Text    ${MENSAGEM_NAO_ENCONTRADO}    should be    Nenhum resultado
