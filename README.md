В этих файлах находятся адреса хостов:
- `hosts/local_dev.ini` - какой-либо свой локальный сервер для тестов
- `hosts/dev.ini` - dev.omskvelo.ru
- `hosts/prod.ini` - omskvelo.ru

Есть 3 скрипта для удобства запуска:
- `bin/play_dev` `playbook.yml` — Запустит `playbook.yml` на dev-хосте
- `bin/play_local_dev` `playbook.yml` — на local_dev
- `bin/prod_play` `playbook.yml` — на проде

Описания playbook'ов (для примера, запускаются на local_dev машине):
`bin/play_local_dev` `py2.yml` — Установить python2 на целевой машине (для ansibl'а)
`bin/play_local_dev` `main.yml` — Установить/настроить основное окружение (nginx/mysql/php/etc)
`bin/play_local_dev` `ipb.yml` — Зальёт исходники форума из гита в нужную директорию (нужен доступ к гиту)
`bin/play_local_dev` `db_import.yml` `-e` `file=sql_dump_file_name.tar.gz` — Залить дамп базы из файла `sql_dump_file_name.tar.gz` на целевую машине (не стоит запускать на проде ес-но)

Опциональные шаги (желательные для прода), которые можно/нужно сделать когда всё заработает:
- Сходить в AdminCP -> System -> Settings/Advanced Configuration -> Server Environment -> выбрать "Use cron" -> скопировать ключ в конце строки и подставить как `key` в следующую команду:
`bin/play_local_dev` `cron.yml` `-e` `key=e9c0f04eae366b86bf917c3485be0749`
