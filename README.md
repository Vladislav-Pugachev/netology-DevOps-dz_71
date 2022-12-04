## 1. Создать bucket Object Storage и разместить там файл с картинкой:
- [манифест](./bucket.tf) для создания bucket
![bucket](./src/bucket.png)
- [манифест](./object.tf) для загрузки картинки
![картинка](./src/image.png)
- права на просмотр
![картинка](./src/acl_image.png)

## 2. Создать группу ВМ в public подсети фиксированного размера с шаблоном LAMP и web-страничкой, содержащей ссылку на картинку из bucket
- [манифест](./instance_group.tf) для создания instance group
- [user_data](./html.yml) для создания web странички
- Разместить в стартовой веб-странице шаблонной ВМ ссылку на картинку из bucket
```
<img src="https://storage.yandexcloud.net/pvv-netology/image" alt="my image" />

```
- Настроить проверку состояния ВМ
```
  health_check {
    interval = 2
    timeout = 1
    healthy_threshold = 2
    unhealthy_threshold = 2
    http_options {
      path = "/"
      port = 80
    }
```
## 2. Подключить группу к сетевому балансировщику
- [манифест](./balancer_network.tf) для создания network balancer
- Проверить работоспособность, удалив одну или несколько ВМ
- - Остановка двух из трех машин
![stop_instance](./src/stop_instance.png)
- - проверка остановки на балансировщике
![check_health](./src/health_check_balancer.png)
- - проверка доступности web странички
![check_web](./src/check_web.png)




