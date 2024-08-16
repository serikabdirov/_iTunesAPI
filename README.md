# Project

[[_TOC_]]

# Tuist

Tuist обеспечивает генерацию файла проекта, настройку параметров проекта, и запуск различных плагинов, скриптов.
Также обеспечивает работу с модулями проекта, внешними зависимостями и их кэшированием. 

## Tuist-команды

Из директории проекта:

`tuist generate` - создает файлы проектов и запускает генераторы ресурсов

`tuist fetch` - скачивает, билдит и кэширует зависимости

`tuist edit` - создает промежуточный проект для настройки 

`tuist scaffold` - выполняет генерацию кода по заданному шаблону (О генерации feature-модуля ниже)

## Project.swift - манифест

В файлах Project.swift определяются манифесты проектов. Там создаются и настраиваются проекты, их таргеты, зависимости и конфигурации.

Существуют манифесты основного проекта и проектов для модулей.

## Tuist/ProjectDescriptionHelpers.swift

Директория для шаринга кода между манифестами. Удобно для написания различных хелперов и расширений.

## Tuist/Constants.swift

Список констант для Tuist. Содержит: имя проекта, bundleID, organizationName, developmentRegion

## Tuist/Dependencies.swift

Конфигурация внешних зависимостей проекта, которыми занимается Tuist. Имеется полная поддержка SPM и Carthage. Для использования CocoaPods нужно сначала генерировать проект через Tuist, а затем выполнять pod install. Необходимо отдавать предпочтение интеграции зависимостей через SPM.

В массиве productTypes указывается тип продукта для каждой зависимости. Например, таким образом библиотека Alamofire будет подключена к проекту как динамический фреймворк. Следует отдавать предпочтение типу продукта .framework

```
productTypes: ["Alamofire": .framework]
``` 

# Подключение новой зависимости

Для подключения новой зависимости необходимо в файле Tuist/Dependencies.swift указать способ интеграции зависимости SPM или Carthage, а затем добавить ее в массив dependencies нужного таргета. Подробнее про конфигурирование зависимостей в разделе [Tuist/Dependencies.swift](#tuist/dependencies.swift)

# Создание нового модуля

Создание модулей возможно в ручным и полуавтоматическим способом.

### Ручное создание 
Для ручного создания нового модуля нужно создать соответствующую папку модуля в директории /Modules или /Modules/FeatureModules (зависит от типа модуля).

### Генерация feature-модуля 

Если добавляется подмодуль в уже существующий модуль верхнего уровня, то генерировать манифест не нужно.
Если создается новый модуль, то сначала необходимо выполнить генерацию манифеста для проекта модуля. Для этого нужно выполнить в терминале следующую команду:

```bash
tuist scaffold featureManifest --module <ModuleName>
```
Параметры:
- `--module` - Название модуля верхнего уровня (Authorization, Profile, Payment)

Чтобы сгенерировать feature-модуль нужно выполнить в терминале следующую команду:

```bash
tuist scaffold feature --module <ModuleName> --name <SceneName> --author "Author"
```
Параметры:
- `--module` - Название модуля верхнего уровня (Authorization, Profile, Payment)
- `--name` - Название сцены (ProfileDetail, ProfileEdit)
- `--author` - Опциональный параметр, добавляет в генерируемые файлы имя автора

### Добавление feature-модуля в манифест основного проекта

Необходимо добавить запись в массив dependencies основного таргета приложения.

Для feature-модуля следущая запись:
```
.featureModule(name: "MODULE_NAME")
```

Для core-модуля следущая запись:
```
.module(name: "MODULE_NAME")
```

### Создание и подключение недостающих DIFramework и DIPart

При генерации feature-модуля в папке подмодуля автоматически создается DIPart, в котором регистрируется ViewController и необходимые для него зависимости. Для корректной работы DI, необходимо подключить эту DIPart к общей иерархии. Если feature-модуль новый, то необходимо вручную в корне папки модуля создать файл `<MODULE_NAME>DIFramework.swift`, в нем определить DIFramework и подключить сгенерированную DIPart к DIFramework. Этот DIFramework должен быть публичным, так как его необходимо добавить в общую иерархию DI в файле основного проекта приложения `ModulesDIFramework.swift`. Если новый feature-модуль не создавался, а создавался только подмодуль в уже имеющемся feature-модуле, то `<MODULE_NAME>DIFramework.swift` скорее всего уже есть и нужно просто в нем подключить сгенерированную DIPart.

Кроме кода из модуля, нужно также зарегистрировать в DI сгенерированный роутер. В основном проекте в папке Routers/MODULE_NAME будет находиться файл с определением роутера, в котором также есть статическая функция `static func register(in container: DIContainer)`. Если feature-модуль новый, то необходимо вручную в папке с роутером создать файл `<MODULE_NAME>RoutersDIPart.swift`, зарегистрировать в нем роутер с помощью вышеуказанной статической функции, а эту DIPart подключить к общей иерархии в файле `RoutersDIFramework.swift`.
Если новый feature-модуль не создавался, а создавался только подмодуль в уже имеющемся feature-модуле, то `<MODULE_NAME>RoutersDIPart.swift` скорее всего уже есть и нужно просто в нем подключить сгенерированный роутер. 

# FAQ

## 1. Созданный модуль появляется в проекте после команды `tuist generate`, но не билдится и не подсвечивает ошибки

Скорее всего таргет этого модуля не подключен напрямую или косвенно к таргету основного проекта. Необходимо добавить его как зависимость к основному таргету или к таргету, который подключен в основному.

## 2. Ресурсы не генерируются

Для генерации ресурсов необходимо выполнить команду `tuist generate`.

## 3. Создал новый файл в модуле через xcode, а он не виден в других файлах этого же модуля.

Скорее всего XCode добавил созданный файл не в текущий таргет. Необходимо либо в attribute inspector в секции Target Membership указать нужный таргет, либо выполнить команду `tuist generate`, которая перегенирирует файл проекта и расставит Target Membership согласно иерархии файлов в директории проекта.

## 4. Проект не собирается, ошибка swiftlint

Возможно два типа ошибок, связанных с swiftlint. 

1. Он не установлен в системе, тогда ошибка прямо об этом будет сигнализировать. Для установки можно воспользоваться homebrew
2. Превышено количество допустимых warning в проекте. В конфигурационном файле `.swiftlint.yml` есть параметр `warning_threshold`, который отвечает за допустимое количество предупреждений в Xcode. Повышать данный параметр можно только в случае возникновения предупреждения, от которого невозможно избавиться и который не является продуктом линтинга. Например, обновление библиотек, deprecate кода, который нельзя заменить/отрефакторить. Повышать данный порог без строгой необходимости запрещается. 
