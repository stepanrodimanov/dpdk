# DPDK Test Project

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
git clone https://github.com/stepanrodimanov/dpdk.git
cd dpdk
```

### 2. Соберите Docker образ
```bash
docker build -t dpdk-test .
```

### 3. Запустите контейнер
```bash
docker run --privileged --rm -v $(pwd)/logs:/logs dpdk-test
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
EAL: Detected CPU lcores: 12
EAL: Detected NUMA nodes: 1
EAL: Detected static linkage of DPDK
EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
EAL: Selected IOVA mode 'PA'
Port 0 MAC: b2 45 37 1f d8 62
Port 1 MAC: 1e f2 4d ac 19 1c

Core 0 forwarding packets. [Ctrl+C to quit]
Latency = 687 cycles
Latency = 231 cycles
Latency = 663 cycles
Latency = 1133 cycles
Latency = 201 cycles
Latency = 1038 cycles
Latency = 1326 cycles
```

```bash
EAL: Detected CPU lcores: 12
EAL: Detected NUMA nodes: 1
EAL: Detected static linkage of DPDK
EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
EAL: Selected IOVA mode 'PA'
Port 0 MAC: b2 c4 d0 30 33 6d
Port 1 MAC: fe e7 b8 ba 71 38

Core 0 forwarding packets. [Ctrl+C to quit]
Latency = 733 cycles
Latency = 986 cycles
Latency = 1929 cycles
Latency = 932 cycles
Latency = 341 cycles
Latency = 1572 cycles
Latency = 950 cycles
Latency = 605 cycles
```

## Зависимости
В контейнере устанавливаются:
* build-essential - GCC, make, стандартные библиотеки C
* meson - система сборки DPDK
* ninja-build - ускоритель сборки для meson
* pkg-config - поиск библиотек (libnuma)
* libnuma-dev - поддержка NUMA для DPDK
* python3 - для meson и скриптов DPDK
* python3-pyelftools - анализ ELF файлов при сборке DPDK
* wget - скачать архив DPDK

