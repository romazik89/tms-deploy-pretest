# Ansible для контейнерного способа TMS

Автоматизация сборки и запуска контейнера TMS. Учебный пример для «Пред-теста».

## Предварительные требования

- Ansible 2.15+ (или новее);
- коллекция `community.docker` (`ansible-galaxy collection install community.docker`);
- Docker Engine на целевом хосте;
- Python 3 на целевом хосте (для модулей Ansible).

## Что внутри

- `inventory/local.ini` — инвентарь для локального запуска (одна ВМ, `ansible_connection=local`).
- `site.yml` — плейбук: сборка образа (`docker_image` с `source: build`), запуск контейнера (`docker_container`), health-check (`uri` с `retries`/`until`).
- `rollback.yml` — плейбук отката: запуск контейнера с предыдущим тегом образа.

## Как запустить

1. Установить коллекцию:
   ```bash
   ansible-galaxy collection install community.docker
