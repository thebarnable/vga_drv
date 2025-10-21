#!/usr/bin/bash

PYTHON_ENV=".env"
if ! [[ -d ${PYTHON_ENV} ]]; then
    echo "No Python environment found in ${PYTHON_ENV}. Installing..."
    mkdir ${PYTHON_ENV}
    python -m venv ${PYTHON_ENV}
    source ${PYTHON_ENV}/bin/activate
    pip install -r requirements.txt
else 
    source ${PYTHON_ENV}/bin/activate
fi

if [[ -z "${OSSCAD_PATH}" ]]; then
    echo "Error: OSSCAD_PATH not set."
    exit 1
elif [[ -z "${VIVADO_PATH}" ]]; then
    echo "Error: VIVADO_PATH not set."
    exit 1
fi

source ${OSSCAD_PATH}/environment
source ${VIVADO_PATH}/settings64.sh

code .