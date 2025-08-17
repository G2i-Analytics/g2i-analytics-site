# G2i Analytics — Landing (Em construção)

Esta é a página inicial **estática** do G2i Analytics, hospedável gratuitamente via **GitHub Pages**.

## Como publicar no GitHub Pages (grátis)
1. Crie um repositório público chamado `g2i-analytics-site` no seu GitHub.
2. Envie estes arquivos para a **raiz** do repositório (`index.html`, `favicon.svg`, `robots.txt`, `404.html`).
3. No GitHub: **Settings → Pages → Build and deployment**:
   - *Source*: **Deploy from a branch**
   - *Branch*: **main** / **root**
4. Aguarde 1–2 minutos e acesse: `https://SEU_USUARIO.github.io/g2i-analytics-site/`

> Dica: Mantenha `robots.txt` bloqueando indexação enquanto a página estiver “em construção”.

## Próximos passos (dashboards)
- Embeddar dashboards do **Metabase** usando *public links* (rápido) ou **Secure Embedding** (SSO com token assinado).
- Não publique **credenciais** no repositório. Quando precisarmos de chaves (por ex. assinatura JWT do Metabase), use **GitHub Secrets** e um backend (ex.: Render free) para gerar os tokens com segurança.

## Estrutura
```
g2i-analytics-site/
├─ index.html
├─ favicon.svg
├─ robots.txt  # bloqueia indexação por enquanto
└─ 404.html    # página simples de erro
```
