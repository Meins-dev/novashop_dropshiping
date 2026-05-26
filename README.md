# Site

# Projeto Site

Um projeto de estudos de programação que combina um site simples com um backend em Python para integração com provedores de LLM e roteamento inteligente de requests.

## Objetivo

Este repositório serve como um ambiente de aprendizado para programação e arquitetura de aplicações web. A ideia é experimentar:

- roteamento inteligente entre provedores de IA usando o `SmartRouter`
- chamadas assíncronas a provedores locais e externos via `httpx`
- um endpoint de status (`/status`) para monitorar a saúde dos provedores
- autenticação de usuários no backend com token Bearer
- um fluxo de pedidos que exige login antes de finalizar a compra
- persistência simples de pedidos e usuários em arquivos JSON
- testes automatizados em Python com `pytest`

## Recursos principais

- `python/smart_router.py`: lógica de seleção de provedor com base em latência, custo e saúde
- `python/ollama_provider.py`: integração com o Oak LLM local via Ollama
- `python/atomic_chat_provider.py`: suporte opcional a Atomic Chat
- `python/status_asgi.py`: endpoint ASGI que expõe o status dos provedores em JSON
- `python/tests/`: suíte de testes para validar comportamento e conversões de mensagens
- `store.py`: backend do site com APIs de autenticação, pedidos, produtos e regras de frete/cupom
- `users.json`: armazenamento de contas de usuário cadastrado
- `orders.json`: armazenamento de pedidos criados

## Novas funcionalidades adicionadas

### Autenticação backend

- `POST /api/register`: cria nova conta de usuário com `name`, `email`, `password`, `cpf` e `address`
- `POST /api/login`: valida credenciais e retorna um token Bearer
- `POST /api/logout`: invalida o token em uso
- `GET /api/me`: retorna os dados do usuário autenticado a partir do token

### Fluxo de pedido autenticado

- `POST /api/orders`: cria pedido apenas para usuários autenticados
- o backend usa o usuário logado para preencher os dados do cliente no pedido
- o pedido calcula subtotal, desconto, frete e gera um código PIX simulado
- `GET /api/orders/<id>`: consulta de pedido por ID

### APIs de frontend e simulação de loja

- `GET /api/products`: retorna catálogo de produtos e categorias
- `GET /api/shipping`: calcula frete por CEP e total de compra
- `GET /api/coupons`: valida cupom e aplica desconto
- `GET /api/tips`: retorna uma dica de aprendizado aleatória
- `GET /api/quiz`: retorna pergunta de quiz aleatória
- `POST /api/quiz/answer`: valida resposta de quiz e explica o resultado

### Persistência e segurança

- usuários são salvos em `users.json` com senha como hash SHA-256
- pedidos são salvos em `orders.json`
- sessões ativas são mantidas em memória com tokens Bearer
- o frontend armazena apenas o token no `localStorage` e usa o header `Authorization`

## Como usar

1. Crie e ative um ambiente virtual Python:

```bash
python -m venv .venv
source .venv/bin/activate
```

2. Instale dependências (se houver um `requirements.txt` ou adicione o que precisar):

```bash
pip install httpx pytest
```

3. Execute os testes:

```bash
pytest -q
```

4. Rode o backend localmente:

```bash
python store.py
```

5. Abra `index.html` no navegador ou sirva a pasta com um servidor HTTP simples para usar o frontend.

6. Cadastre um usuário, faça login e finalize um pedido.

## Organização do projeto

- `index.html`: frontend do site
- `store.py`: backend do site com APIs de loja e autenticação
- `python/`: código backend e provedores de IA
- `python/tests/`: testes unitários e de integração leve
- `users.json`: usuários cadastrados
- `orders.json`: pedidos criados

## Variáveis de ambiente úteis

- `OPENAI_API_KEY`
- `GEMINI_API_KEY`
- `OLLAMA_BASE_URL`
- `ATOMIC_CHAT_BASE_URL`
- `BIG_MODEL`
- `SMALL_MODEL`
- `ROUTER_STRATEGY` (valor padrão: `balanced`)
- `ROUTER_FALLBACK` (valor padrão: `true`)

## Por que este projeto?

Ele foi criado para aprender e experimentar com integrações de IA, arquiteturas assíncronas, autenticação backend e um fluxo de pedidos que exige login para finalizar a compra, tudo em um contexto simples de site de estudo de programação.

