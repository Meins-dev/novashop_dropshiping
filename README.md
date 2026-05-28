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

5. Para deploy estático no Netlify, o backend será fornecido por uma função serverless em JavaScript; não é necessário executar `store.py` na hospedagem.

6. Para desenvolvimento local com Netlify Dev:

```bash
netlify dev
```

7. Abra `index.html` no navegador ou acesse o site local gerado pelo Netlify Dev para testar o frontend com a função.

6. Cadastre um usuário, faça login e finalize um pedido.

## Deploy no Netlify

- Site publicado: https://willowy-pixie-bf0716.netlify.app/

Ao publicar no Netlify este repositório usa uma função serverless (JS) como backend, portanto não é necessário executar `store.py` na hospedagem.

## Arquivos principais e o que fazem (resumo do que já foi feito)

- `index.html`: frontend (HTML/JS) — atualizado para usar a função Netlify (`/.netlify/functions/store`), incluir UX de pagamento PIX (geração de chave/QR) e armazenar token `access_token` no `localStorage`.
- `styles.css`: estilos do site — ajustado para posicionamento do logo na search-bar e estilo do QR PIX.
- `store.py`: backend Python para desenvolvimento local — implementa APIs (auth, produtos, pedidos, frete, cupons) e migração JSON→DB; permanece para uso local, mas não é necessário em Netlify.
- `netlify/functions/store.js`: função serverless (Node.js) — replica as mesmas APIs do `store.py` em JS para rodar no Netlify (prod). Testada localmente e responde `GET /api/products` com o catálogo.
- `netlify.toml`: configuração de build/funções para Netlify (publica a raiz e aponta `functions` para `netlify/functions`).
- `package.json`: define engine Node e scripts `start`/`dev` para `netlify dev`.
- `_redirects`: redireciona todas as rotas para `index.html` (SPA routing) quando hospedado no Netlify.
- `users.json`, `orders.json`: armazenamento simples usado antes da migração para DB/local persistência (mantidos para compatibilidade local).
- `db.py` (quando presente): modelos SQLAlchemy e migração de dados em disco para SQLite — adicionada para quem optar por rodar o backend Python localmente.
- `python/*`: código de suporte (provedores LLM, roteador inteligente, testes) — parte do propósito original do repositório para integração de IA.

O que já estava sendo feito antes:
- O projeto começou como um site estático que usava `store.py` com JSON em disco para autenticação e pedidos.
- Em seguida, foi adicionada persistência via SQLite/SQLAlchemy (`db.py`) e migrações para suportar novos campos (ex.: `is_admin`).
- Implementou-se autenticação com tokens, refresh tokens e `UserSession` para persistência de sessão em DB/local.
- Foi criada a função Netlify (`netlify/functions/store.js`) para que o site pudesse ser hospedado sem executar `store.py` na plataforma.


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

