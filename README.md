# ДЗ №16 Запретить всем пользователям, кроме группы admin логин в выходные (суббота и воскресенье), без учета праздников * дать конкретному пользователю права работать с докером и возможность рестартить докер сервис
--------------------------------------------------------------------------------------------

Внутри репозитория DZ-otus-16 находятся все необходиме файлы для развертывания стенда для поднятия которого достаточно набрать в командной строке `vagrant up`. 

После запуска Vagrant поднимается ВМ с названием `default` , внутри виртуальной машины настроивается `PAM` модуль для ограничения доступа на аутентификацию через ssh.

Создается группа `admin` и два пользователя - `allowed` и `unable`. `allowed` входит в группу `admin`, и является единственным пользователем в системе который может залогиниться на ВМ через `ssh` в выходные, поскольку входит в группу `admin`. Именно с помощью `pam_script` техннология pam определяет, что доступ на ВМ в субботу и воскресение могут иметь исключительно члены группы `admin`. 

Для того чтобы не дождаться выходных в `other_tasks.sh` заданы две команды через systemd-утилиту timedatectl, которые отключают автоматическую синхранизацию по ntp 
и сменяют дату на 25 июля 2020го года(суббота). 

Пользователью `allowed` дополнительно заданы права для открывания root-сессий через `su` в файле - /etc/pam.d/su
