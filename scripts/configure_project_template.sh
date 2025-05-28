# Configura uma pasta com os arquivos de devcontainer necessários, isso fará um symlink dos files do scafold

SCRIPT_ALIAS="install_dev"
PROJECTS_DIR="$HOME/projects"
SCAFFOLD_DIR="$HOME/.scaffold"
# PROJETO
# GIT_CLONE_URL

mkdir -p "$PROJECTS_DIR"

# Checa flags
while [[ $# -gt 0 ]]; do
  case $1 in
    --project-name)
      PROJECT_NAME="$2"
      shift 2
      ;;
    --git-clone-url)
      GIT_CLONE_URL="$2"
      shift 2
      ;;
    --project-type)
      PROJECT_TYPE="$2"
      shift 2
      ;;
    *)
      echo "Opção inválida: $1"
      exit 1
      ;;
  esac
done

# Verificação obrigatória da flag --project-type
if [[ -z "$PROJECT_TYPE" ]]; then
  echo "Erro: a flag --project-type é obrigatória."
  echo "Valores permitidos: python, rust, global"
  echo "Exemplo: $SCRIPT_ALIAS --project-type python"
  exit 1
fi

create_repo() {
  # Verifica se usuário informou o nome do projeto
  if [ -z "$PROJECT_NAME" ]; then
    echo "Nome do projeto não informado"
    echo "É necessário que seja informado o nome do projeto ou o link do repositório"
    echo "Exemplo: $SCRIPT_ALIAS --project-name meu-projeto ou "
    echo "$SCRIPT_ALIAS --git-clone-url https://github.com/EdimarDeSa/dotfiles.git"
}

# Verifica se usuário informou o link do repositório
if [ -z "$GIT_CLONE_URL" ]; then
  echo "Link não informado, criando um repositório padrão"
  create_repo
else
  git clone "$GIT_CLONE_URL" "$PROJECTS_DIR"
  cd "$PROJECTS_DIR"
fi


# Cria o symlink do devcontainer