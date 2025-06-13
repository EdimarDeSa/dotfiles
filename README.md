# Dot Files de Edimar para combutadores com base ubuntu/debian

## Como instalar
```bash
export GITHUB_USERNAME=EdimarDeSa
mkdir -p ~/.pswds
echo "minha_senha_segura" > ~/.pswds/bw.pswd

sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply $GITHUB_USERNAME

```