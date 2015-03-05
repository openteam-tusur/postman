#### Настройки для приложения с помощью ansible 

В папке config/provision лежит все необходимое для того чтобы настроить nginx, unicorn, sidekiq, subscriber, 
settings.yml и database.yml в production окружении

В settings.yml и database.yml хранятся секретные настройки для доступа к различным API и БД. Чтобы расшифровать 
данные для этих файлов нужно:

* создать файл ~/.vault_pass
* расшифровать данные, например для внесения правок, можно с помощью: 

```
ansible-vault decrypt config/provision/vars/database.yml --vault-password-file ~/.vault_pass
```

* защифровать данные

```
ansible-vault encrypt config/provision/vars/database.yml --vault-password-file ~/.vault_pass
```

##### Настройка ansible

* brew install ansible
* настроить доступ к удаленному серверу с помощью ssh

```
vi ~/.ssh/config

Host postman
User root
  ForwardAgent yes
  ProxyCommand ssh GATEWAY_SERVER_NAME -W %h:%p
  StrictHostKeyChecking no
  UserKnownHostsFile=/dev/null
```

* проверить, что ansible сможет подключится к удаленному хосту

```
ansible -m setup postman
```

##### Настройка nginx

В папке config/provision/templates/nginx/ лежат файл настроет nginx и шаблон для вирутального хоста приложения. 
После изменения одного из файлов нужно запустить комманду.

```
ansible-playbook config/provision/playbook.yml --vault-password-file ~/.vault_pass
```

Ansible выполнит все задачи указанные в файле playbook.yml на удаленном сервере.

