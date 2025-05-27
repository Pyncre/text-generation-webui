#!/usr/bin/env bash

# Définit le port (prend la variable d’environnement PORT sinon défaut 7860)
PORT=${PORT:-7860}
echo "Starting server on port: $PORT"

# Active conda et l'environnement python
source "$CONDA_ROOT_PREFIX/etc/profile.d/conda.sh"
conda activate "$INSTALL_ENV_DIR"

# Lance le serveur avec les bons arguments
python one_click.py --listen --listen-host 0.0.0.0 --listen-port "$PORT" "$@"
