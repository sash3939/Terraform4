# Домашнее задание к занятию «Продвинутые методы работы с Terraform»

### Цели задания

1. Научиться использовать модули.
2. Отработать операции state.
3. Закрепить пройденный материал.


### Чек-лист готовности к домашнему заданию

1. Зарегистрирован аккаунт в Yandex Cloud. Использован промокод на грант.
2. Установлен инструмент Yandex CLI.
3. Исходный код для выполнения задания расположен в директории [**04/src**](https://github.com/netology-code/ter-homeworks/tree/main/04/src).
4. Любые ВМ, использованные при выполнении задания, должны быть прерываемыми, для экономии средств.

------
### Внимание!! Обязательно предоставляем на проверку получившийся код в виде ссылки на ваш github-репозиторий!
Убедитесь что ваша версия **Terraform** ~>1.8.4
Пишем красивый код, хардкод значения не допустимы!
------

### Задание 1

1. Возьмите из [демонстрации к лекции готовый код](https://github.com/netology-code/ter-homeworks/tree/main/04/demonstration1) для создания с помощью двух вызовов remote-модуля -> двух ВМ, относящихся к разным проектам(marketing и analytics) используйте labels для обозначения принадлежности.  В файле cloud-init.yml необходимо использовать переменную для ssh-ключа вместо хардкода. Передайте ssh-ключ в функцию template_file в блоке vars ={} .
Воспользуйтесь [**примером**](https://grantorchard.com/dynamic-cloudinit-content-with-terraform-file-templates/). Обратите внимание, что ssh-authorized-keys принимает в себя список, а не строку.
3. Добавьте в файл cloud-init.yml установку nginx.
4. Предоставьте скриншот подключения к консоли и вывод команды ```sudo nginx -t```, скриншот консоли ВМ yandex cloud с их метками. Откройте terraform console и предоставьте скриншот содержимого модуля. Пример: > module.marketing_vm
------
В случае использования MacOS вы получите ошибку "Incompatible provider version" . В этом случае скачайте remote модуль локально и поправьте в нем версию template провайдера на более старую.
------

![analutics nginx](https://github.com/user-attachments/assets/eb0ce094-21fa-488e-89b2-90389db3bbe0)
---
![marketing nginx](https://github.com/user-attachments/assets/e021f1c3-9a0c-45b4-a952-fe07ce332fc0)
---

![YC analytics](https://github.com/user-attachments/assets/54798119-25d6-4aff-98b4-cd60e8e2bd1d)
---
![YC marketing](https://github.com/user-attachments/assets/c5faf8ae-608e-4c0c-a432-1221a8f79273)
---

![module marketing_vm](https://github.com/user-attachments/assets/ca339701-38e1-43ea-a38f-35c3b864e1db)
---
![module analytics_vm](https://github.com/user-attachments/assets/bedcd0a1-4bb8-41c7-84f8-1236b1a1a91e)
---

### Задание 2

1. Напишите локальный модуль vpc, который будет создавать 2 ресурса: **одну** сеть и **одну** подсеть в зоне, объявленной при вызове модуля, например: ```ru-central1-a```.

Написал локальный модуль с одной сетью и одной подсетью в зоне ru-central1-a.
   
2. Вы должны передать в модуль переменные с названием сети, zone и v4_cidr_blocks.
- В модуле используются переменные с именем сети, зоны и cidr блок

![vpc-variables](https://github.com/user-attachments/assets/e2e723b8-7165-494f-9dbf-fc2a5659329e)
---

3. Модуль должен возвращать в root module с помощью output информацию о yandex_vpc_subnet. Пришлите скриншот информации из terraform console о своем модуле. Пример: > module.vpc_dev  

![module vpc_dev](https://github.com/user-attachments/assets/9c65f7bf-eb62-4fd2-a57f-3740b4d36658)
---

4. Замените ресурсы yandex_vpc_network и yandex_vpc_subnet созданным модулем. Не забудьте передать необходимые параметры сети из модуля vpc в модуль с виртуальной машиной.
- Заменил сетевые ресурсы созданным модулем
- В root модуле описал outup

![output root module](https://github.com/user-attachments/assets/bc12bff2-0550-4873-839b-ed725ba76aed)
---

6. Сгенерируйте документацию к модулю с помощью terraform-docs.
 
Пример вызова

```
module "vpc_dev" {
  source       = "./vpc"
  env_name     = "develop"
  zone = "ru-central1-a"
  cidr = "10.0.1.0/24"
}
```
- Установка terraform-docs и перенаправление в файл. Документация сгенерирована по пути vpc/README.md
## docker run --rm --volume "$(pwd):/terraform-docs" -u $(id -u) quay.io/terraform-docs/terraform-docs:0.18.0 markdown /terraform-docs > README.md

[README.MD](https://github.com/sash3939/Terraform4/blob/main/vpc/README.md)

### Задание 3
1. Выведите список ресурсов в стейте.
2. Полностью удалите из стейта модуль vpc.
3. Полностью удалите из стейта модуль vm.
4. Импортируйте всё обратно. Проверьте terraform plan. Значимых(!!) изменений быть не должно.
Приложите список выполненных команд и скриншоты процессы.

1. terraform state list

![state list](https://github.com/user-attachments/assets/ad5c17b5-4f00-4466-a795-0878239b006d)
---
Поиск id
terraform state show 'module.....' | grep 'id'
2. terraform state rm "module.vpc_dev.yandex_vpc_subnet.vpc_sub"
   terraform state rm "module.vpc_dev.yandex_vpc_network.vpc"

![delete module vpc](https://github.com/user-attachments/assets/dd4c27a7-97b6-4f27-a145-7c22e84fed9b)
---

3. Команды аналогично п.2 с названиями модулей vm

![delete module vm](https://github.com/user-attachments/assets/28b9d4ad-663a-4625-973e-84d8b4612c04)
---

## Дополнительные задания (со звёздочкой*)

**Настоятельно рекомендуем выполнять все задания со звёздочкой.**   Они помогут глубже разобраться в материале.   
Задания со звёздочкой дополнительные, не обязательные к выполнению и никак не повлияют на получение вами зачёта по этому домашнему заданию. 

4.  terraform import "name module" <id module>
Example, terraform import "module.marketing_vm.yandex_compute_instance.vm[0]" fhmp0d6mi6oi8jb5gppu

![import vpc network](https://github.com/user-attachments/assets/ca933d80-93d8-44a1-a060-9d45cb5c023e)
---
![plan after import](https://github.com/user-attachments/assets/4c729785-d1bd-4acc-887e-8b6ba430a2f4)
---
![import vpc subnet](https://github.com/user-attachments/assets/fbe8808d-e39b-4fbf-bc47-d74136120613)
---
![import analytics vm](https://github.com/user-attachments/assets/5dbbc9cc-8202-454c-b678-8209132836f6)
---
![import marketing vm](https://github.com/user-attachments/assets/1ba17d45-368d-4add-8693-f765b95ee63d)
---


### Задание 4*

1. Измените модуль vpc так, чтобы он мог создать подсети во всех зонах доступности, переданных в переменной типа list(object) при вызове модуля.  
  
Пример вызова
```
module "vpc_prod" {
  source       = "./vpc"
  env_name     = "production"
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
    { zone = "ru-central1-b", cidr = "10.0.2.0/24" },
    { zone = "ru-central1-c", cidr = "10.0.3.0/24" },
  ]
}

module "vpc_dev" {
  source       = "./vpc"
  env_name     = "develop"
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
  ]
}
```

Предоставьте код, план выполнения, результат из консоли YC.

Код описан в каталоге [task4](https://github.com/sash3939/Terraform4/tree/main/task4)

![Plan_task4](https://github.com/user-attachments/assets/9833a1d1-dc89-440e-9688-ee70dfcf9519)
---
![YC CLI](https://github.com/user-attachments/assets/7e55b1b1-ed7e-494b-929e-6a4a5bc3483b)
---

### Задание 5*

1. Напишите модуль для создания кластера managed БД Mysql в Yandex Cloud с одним или несколькими(2 по умолчанию) хостами в зависимости от переменной HA=true или HA=false. Используйте ресурс yandex_mdb_mysql_cluster: передайте имя кластера и id сети.
2. Напишите модуль для создания базы данных и пользователя в уже существующем кластере managed БД Mysql. Используйте ресурсы yandex_mdb_mysql_database и yandex_mdb_mysql_user: передайте имя базы данных, имя пользователя и id кластера при вызове модуля.
3. Используя оба модуля, создайте кластер example из одного хоста, а затем добавьте в него БД test и пользователя app. Затем измените переменную и превратите сингл хост в кластер из 2-х серверов.
4. Предоставьте план выполнения и по возможности результат. Сразу же удаляйте созданные ресурсы, так как кластер может стоить очень дорого. Используйте минимальную конфигурацию.

Файл [tplan](https://github.com/sash3939/Terraform4/blob/main/task5/tplan)

Если HA=false

![If HA false](https://github.com/user-attachments/assets/104ce0c9-ea78-4fde-a94e-bad8ec90448b)
---
Если HA=true

![If HA true](https://github.com/user-attachments/assets/9de9a37b-bc38-4b91-ac84-cb047cab4ac4)
---

Невозможно продолжить из-за ошибки создания кластера

![Cluster not create](https://github.com/user-attachments/assets/d7a9f1a9-bd64-481b-8743-7e589f43bd3e)
---


### Задание 6*
1. Используя готовый yandex cloud terraform module и пример его вызова(examples/simple-bucket): https://github.com/terraform-yc-modules/terraform-yc-s3 .
Создайте и не удаляйте для себя s3 бакет размером 1 ГБ(это бесплатно), он пригодится вам в ДЗ к 5 лекции.

![YC bucketS3](https://github.com/user-attachments/assets/b4b5f50d-ff13-4e8b-ab43-baf9ed3bf97f)
---

![terraform bucket s3](https://github.com/user-attachments/assets/fd703bde-0eeb-48ac-b3ed-33da0572d98f)
---
### Задание 7*

1. Разверните у себя локально vault, используя docker-compose.yml в проекте.
2. Для входа в web-интерфейс и авторизации terraform в vault используйте токен "education".
3. Создайте новый секрет по пути http://127.0.0.1:8200/ui/vault/secrets/secret/create
Path: example  
secret data key: test 
secret data value: congrats!  
4. Считайте этот секрет с помощью terraform и выведите его в output по примеру:
```
provider "vault" {
 address = "http://<IP_ADDRESS>:<PORT_NUMBER>"
 skip_tls_verify = true
 token = "education"
}
data "vault_generic_secret" "vault_example"{
 path = "secret/example"
}

output "vault_example" {
 value = "${nonsensitive(data.vault_generic_secret.vault_example.data)}"
} 

Можно обратиться не к словарю, а конкретному ключу:
terraform console: >nonsensitive(data.vault_generic_secret.vault_example.data.<имя ключа в секрете>)
```
5. Попробуйте самостоятельно разобраться в документации и записать новый секрет в vault с помощью terraform. 

### Задание 8*
Попробуйте самостоятельно разобраться в документаци и с помощью terraform remote state разделить root модуль на два отдельных root-модуля: создание VPC , создание ВМ . 

### Правила приёма работы

В своём git-репозитории создайте новую ветку terraform-04, закоммитьте в эту ветку свой финальный код проекта. Ответы на задания и необходимые скриншоты оформите в md-файле в ветке terraform-04.

В качестве результата прикрепите ссылку на ветку terraform-04 в вашем репозитории.

**Важно.** Удалите все созданные ресурсы.

### Критерии оценки

Зачёт ставится, если:

* выполнены все задания,
* ответы даны в развёрнутой форме,
* приложены соответствующие скриншоты и файлы проекта,
* в выполненных заданиях нет противоречий и нарушения логики.

На доработку работу отправят, если:

* задание выполнено частично или не выполнено вообще,
* в логике выполнения заданий есть противоречия и существенные недостатки. 



