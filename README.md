# tms-deploy-pretest

Пред-тест: сравнительный анализ способов развёртывания TMS (нативный vs Docker + Ansible).
Личный стенд, не для продакшена. Цель — замерить время развёртывания, отладки и отката, чтобы использовать результаты в регламенте управления изменениями.

## Что внутри

- `native/` — нативный способ (по руководству администратора LANTMS_linux_1.4): пользователь `tmsusr`, каталоги `/opt/TMS`, systemd-сервис `tmsapp.service`.
- `docker/` — контейнерный способ: `Dockerfile` на базе `mcr.microsoft.com/dotnet/aspnet`, `docker-compose.yml` для локального запуска.
- `ansible/` — автоматизация контейнерного способа: `site.yml` (docker_image + docker_container + health-check), `rollback.yml`, `inventory/local.ini`.
- `docs/` — сравнение способов (`comparison.md`), замеры времени (`timings.md`), заметки для СИБ (`security-notes.md`).

## Статус

Пилот. Не для продакшена без согласования с СИБ. Секреты, реальные IP и корпоративные артефакты в репозиторий не коммитятся.

## Как использовать

- Нативный способ: см. `native/README.md`.
- Контейнерный способ: см. `docker/README.md` и `ansible/README.md`.
- Результаты замеров: `docs/timings.md`.
- Сравнение: `docs/comparison.md`.

## Лицензия

Учебный материал. Используйте на свой риск.
