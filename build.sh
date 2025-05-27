#!/usr/bin/env bash

cd "$(dirname "$0")"

# Variables
OS_ARCH=$(uname -m)
case "${OS_ARCH}" in
    x86_64*) OS_ARCH="x86_64" ;;
    arm64*|aarch64*) OS_ARCH="aarch64" ;;
    *) echo "Unsupported architecture: $OS_ARCH" && exit 1 ;;
esac

INSTALL_DIR="$(pwd)/installer_files"
CONDA_ROOT_PREFIX="$INSTALL_DIR/conda"
INSTALL_ENV_DIR="$INSTALL_DIR/env"
MINICONDA_URL="https://repo.anaconda.com/miniconda/Miniconda3-py311_24.11.1-0-Linux-${OS_ARCH}.sh"

# Installer Miniconda si pas déjà là
if [ ! -f "$CONDA_ROOT_PREFIX/bin/conda" ]; then
    echo "Downloading Miniconda..."
    mkdir -p "$INSTALL_DIR"
    curl -L "$MINICONDA_URL" -o "$INSTALL_DIR/miniconda_installer.sh"
    chmod +x "$INSTALL_DIR/miniconda_installer.sh"
    bash "$INSTALL_DIR/miniconda_installer.sh" -b -p "$CONDA_ROOT_PREFIX"
    rm "$INSTALL_DIR/miniconda_installer.sh"
fi

# Créer environnement conda si pas déjà là
if [ ! -d "$INSTALL_ENV_DIR" ]; then
    "$CONDA_ROOT_PREFIX/bin/conda" create -y -k --prefix "$INSTALL_ENV_DIR" python=3.11
fi

# Activer l'env conda
source "$CONDA_ROOT_PREFIX/etc/profile.d/conda.sh"
conda activate "$INSTALL_ENV_DIR"

# Installer les dépendances python
pip install -r requirements.txt
