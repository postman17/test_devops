#!/usr/bin/expect -f

#
# Интерактивный режим для любых программ
#

# лимит времени выполнения
set timeout 3

# объявляем переменные
set password [lindex $argv 0]

# запускаем программу
spawn ssh-add ~/.ssh/id_rsa

# ждем этого приглашения, на что отвечаем паролем
expect "Enter passphrase for key '/home/travis/.ssh/id_rsa':" { send "$password\r" }

#expect {
#  # если выскочило это, то пароль не верен, выходим с ошибкой
#  "Bad passphrase, try again for id_rsa:" { exit 1 }
#  # выходим без ошибки
#  eof { exit 0 }
#}
expect eof