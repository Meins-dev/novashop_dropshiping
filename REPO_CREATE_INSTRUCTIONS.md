# Criar e publicar o repositório `projeto_site`

Estas instruções criam um repositório no GitHub chamado `projeto_site` e enviam
o branch `main` que já contém os commits locais.

1) Autenticar a `gh` (recomendado)

```bash
gh auth login
```

2) Criar o repositório e enviar o código (com `gh`)

```bash
gh repo create projeto_site --public --source=. --remote=projeto_site --push
```

3) Alternativa — criar pelo site e adicionar remoto manualmente

- Crie o repositório em https://github.com/new com o nome `projeto_site`.
- Depois rode (substitua `<your-username>`):

```bash
git remote add projeto_site https://github.com/<your-username>/projeto_site.git
git push -u projeto_site main
```

4) Uso do `GH_TOKEN` (CI/non-interactive)

Se preferir não usar `gh auth login` interativo, exporte um token com escopo
`repo` e execute:

```bash
export GH_TOKEN="<your-token>"
gh auth login --with-token < <(echo "$GH_TOKEN")
gh repo create projeto_site --public --source=. --remote=projeto_site --push
```

Script utilitário abaixo: torne executável e rode quando desejar automatizar.

```bash
bash scripts/create_and_push_repo.sh
```
