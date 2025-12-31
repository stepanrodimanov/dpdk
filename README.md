# DPDK Latency Test Project

## Описание
Проект для тестирования задержки обработки сетевых пакетов с использованием DPDK (Data Plane Development Kit). Запускает пример rxtx_callbacks с TAP-интерфейсами.

## Структура проекта
```
.
├── Dockerfile
├── src/
│   └── main.c
├── scripts/
│   └── run.sh
└── README.md
```

## Установка и запуск

### 1. Клонируйте репозиторий
```bash
git clone <ваш-репозиторий>
cd dpdk
```

### 2. Соберите Docker образ
```bash
docker build -t dpdk-test .
```

### 3. Запустите контейнер
```bash
docker run --privileged --rm dpdk-test
```

## Как работает
1. В контейнере настраиваются hugepages
2. Запускается DPDK приложение rxtx_callbacks с двумя TAP интерфейсами
3. Генерируется тестовый трафик с помощью arping
4. Измеряется задержка между RX и TX коллбэками
5. Результаты сохраняются в лог-файл

## Логи
Лог-файлы создаются в формате: `dpdk_latency_YYYYMMDD_HHMMSS.log`

```bash
Лог 1
```

```bash
Лог 2
```

## Зависимости
В контейнере устанавливаются:
build-essential - GCC, make, стандартные библиотеки C
meson - система сборки DPDK
ninja-build - ускоритель сборки для meson
pkg-config - поиск библиотек (libnuma)
libnuma-dev - поддержка NUMA для DPDK
python3 - для meson и скриптов DPDK
python3-pyelftools - анализ ELF файлов при сборке DPDK
wget - скачать архив DPDK

# dpdk
