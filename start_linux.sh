#!/usr/bin/env bash

# Définir le port Render ou fallback sur 7860
PORT=${PORT:-7860}
echo "Starting server on port: $PORT"

# Définir les chemins utilisés aussi dans build.sh
CONDA_ROOT_PREFIX="$(pwd)/installer_files/conda"
INSTALL_ENV_DIR="$(pwd)/installer_files/env"

# Activer conda depuis ton install locale
source "$CONDA_ROOT_PREFIX/etc/profile.d/conda.sh"
conda activate "$INSTALL_ENV_DIR"

# Lancer le serveur
python one_click.py --listen --listen-host 0.0.0.0 --listen-port "$PORT" "$@"
