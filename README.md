В директории `hosts` должны находиться файлы с адресами хостов (можно использовать файлы .example в качестве основы):

- `local_dev.ini` - какой-либо свой локальный сервер для тестов
- `dev.ini` - dev.omskvelo.ru
- `prod.ini` - omskvelo.ru

Основные настраиваемые переменные находятся в файле `vars/vars.yml` (скорее всего ничего менять не нужно будет).  

«Секретные» переменные находятся в директории `secret_vars`:

- `dev.yml` - для local_dev и dev хостов
- `prod.yml` -  соответственно, для prod'а

В директории `bin` находятся скрипты для удобства запуска, которые просто берут адреса хостов и секретные переменные из соответствующих файлов и запускают playbook:

- `bin/play_dev` `playbook.yml` — Запустит `playbook.yml` на dev-хосте
- `bin/play_local_dev` `playbook.yml` — на local_dev
- `bin/prod_play` `playbook.yml` — на проде

Описания playbook'ов:

- `py2.yml` — Установить python2 на целевой машине (для ansibl'а)
- `main.yml` — Установить/настроить основное окружение (nginx/mysql/php/etc)
- `ipb.yml` — Зальёт исходники форума из гита в нужную директорию (нужен доступ к гиту)
- `db_dump.yml` — Сделать дамп базы
- `db_import.yml` `-e file=db_dump.tgz` — Залить дамп базы из файла `db_dump.tgz` на целевую машину (не стоит запускать на проде ес-но)
- `uploads_partial_dump.yml` — Частично скачать содержимое uploads (чтобы форум поставленный из дампа базы на свежую машину выглядел более-менее адекватно)
- `uploads_partial_import.ym.` `-e folder=uploads_folder` — Залить частично скачанную с помощью `uploads_partial_dump.yml` директорию uploads, из локальной директории `uploads_folder`
- `https.iml` — Выпустить https-сертификат через let's encrypt (в `secret_vars` должна быть определена переменная `yandex_pdd_token`)
- `cron.yml` `-e key=<key>` - настроить cron для IPB, key берётся из  AdminCP → System → Settings/Advanced Configuration → Server Environment → выбрать "Use cron", скопировать ключ и подставить как параметр `key`), для прода стоит сделать.


Пример как задеплоить на local_dev:

- поднимаем хост
- прописываем его адрес в `hosts/local_dev.ini`
- `bin/play_local_dev py2.yml`
- `bin/play_local_dev main.yml`
- `bin/play_local_dev ipb.yml`
- берём откуда-нибудь дамп базы (делаем дамп с помощью `db_dump.yml`, или из бэкапов, или ещё откуда-нибудь), будем считать что он в файле `db_dump.sql.gz`
- `bin/play_local_dev db_import.yml -e file=db_dump.sql.gz`
- в каком-то виде всё должно заработать
