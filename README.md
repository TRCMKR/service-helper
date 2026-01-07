# servitor

Простой генератор всего необходимого для быстрого создания сервисов на Go

# Использование

Добавьте в проект `servitor` через

```
go get -u github.com/trcmkr/servitor
```

Или с помощью секции `tool`, потом
```
go mod tidy
```

После этих шагов выполните

```
go install github.com/trcmkr/servitor@latest
```

# Новая версия 

Делать релиз новой версии только с помощью команды
```
./release.sh <commit_name> major/minor/patch
```
