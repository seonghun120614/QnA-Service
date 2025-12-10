#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(dirname $0)"

development() {
    if lsof -ti :8080 :3306 :5176 > /dev/null 2>&1; then
        echo "Error: 일부 포트가 이미 사용 중입니다. 실행 중인 프로세스를 확인하세요."
        lsof -ti :8080 :3306 :5176
        exit 1
    fi
    docker-compose -f "${SCRIPT_DIR}/docker-compose.dev.yml" down -v
    docker-compose -f "${SCRIPT_DIR}/docker-compose.dev.yml" up --build --force-recreate
}

if [ $# -ne 1 ]; then
    echo "Usage: ./$(basename "$0") [ --dev | --prod | --test ]"
    exit 1
fi

for arg in "$@"; do
    case "$arg" in
        --dev)
            echo "Development Mode 실행"
            development
            ;;
        --prod)
            echo "Production Mode 실행"
            ;;
        --test)
            echo "Test Mode 실행"
            ;;
        *)
            echo "Unknown option: $arg"
            echo "Usage: ./$(basename $0) [ --dev | --prod | --test ]"
            exit 1
            ;;
    esac
done

