*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${BASE_URL}    https://dog.ceo/api

*** Test Cases ***
Cenário: Validar listagem de todas as raças (GET /breeds/list/all)
    Create Session    dog_api    ${BASE_URL}    verify=True
    ${response}=      GET On Session    dog_api    /breeds/list/all
    
    Status Should Be    200    ${response}
    Dictionary Should Contain Key    ${response.json()}    message
    Dictionary Should Contain Key    ${response.json()}    status
    Should Be Equal As Strings       ${response.json()}[status]    success

Cenário: Validar imagens de uma raça específica (GET /breed/hound/images)
    Create Session    dog_api    ${BASE_URL}
    ${response}=      GET On Session    dog_api    /breed/hound/images
    
    Status Should Be    200    ${response}
    ${tipo_mensagem}=    Evaluate    type($response.json()['message']).__name__
    Should Be Equal As Strings    ${tipo_mensagem}    list
    Should Not Be Empty           ${response.json()['message']}

Cenário: Validar imagem aleatória (GET /breeds/image/random)
    Create Session    dog_api    ${BASE_URL}
    ${response}=      GET On Session    dog_api    /breeds/image/random
    
    Status Should Be    200    ${response}
    Should Contain    ${response.json()['message']}    https://images.dog.ceo/
