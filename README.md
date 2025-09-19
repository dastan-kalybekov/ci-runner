# CI Runner

Контейнер для запуска собственного GitHub Actions Runner.

## Запуск

1. Получите токен регистрации в настройках Self-hosted Runner на GitHub.
2. Определите переменные окружения:
   Создайте файл `.env` на уровне с `docker-compose.yml` и добавьте переменные окружения:

   ```env
   RUNNER_URL=https://github.com/owner/repo
   RUNNER_TOKEN=XXXXXXXXXXXXXXXXX
   RUNNER_NAME=my-runner
   LABELS=linux,x64
   ```

   `docker-compose` автоматически подхватит значения из `.env`.

3. Установите значения для аргумента
   ```bash
   export DOCKER_GID=$(stat -c '%g' /var/run/docker.sock)
   ```

4. Соберите и запустите контейнер:

   ```bash
   docker-compose up -d --build
   ```

Контейнер автоматически зарегистрирует раннер и начнёт ожидать задания.

## Переменные окружения

Перечисленные переменные можно задавать через `export` либо в файле `.env`.

* `RUNNER_URL` — URL репозитория или организации.
* `RUNNER_TOKEN` — токен регистрации.
* `RUNNER_NAME` — имя раннера (по умолчанию `docker-runner`).
* `LABELS` — дополнительные метки (опционально).

## Остановка

Чтобы остановить и удалить контейнер, выполните:

```bash
docker-compose down
```
