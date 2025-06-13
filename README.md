# Dot Files de Edimar para combutadores com base ubuntu/debian

## Como instalar
```bash
export GITHUB_USERNAME=EdimarDeSa
mkdir -p ~/.pswd
echo "minha_senha_segura" > ~/.pswd/bw.pswd

sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply $GITHUB_USERNAME

```