# EventApp - Aplicación de Gestión de Eventos en Flutter

EventApp es una aplicación móvil desarrollada con Flutter para explorar y gestionar eventos. Utiliza un backend simulado local basado en `json-server` para emular llamadas a una API durante el desarrollo.

## 📱 Funcionalidades

* Ver detalles de eventos
* Listar eventos próximos
* Editar y eliminar eventos
* Backend simulado con `json-server`

## 🚀 Comenzando

### ✅ Requisitos previos

Asegúrate de tener las siguientes herramientas instaladas en tu sistema:

* [Flutter](https://docs.flutter.dev/get-started/install) (canal estable)
* [Node.js y npm](https://nodejs.org/)
* `json-server` (instalado local o globalmente)

### 🔧 Instalación y configuración

Sigue estos pasos para configurar y ejecutar el proyecto localmente:

#### 1. Clonar el repositorio

```bash
git clone https://github.com/your-username/eventapp.git
cd eventapp
```

#### 2. Instalar dependencias de Flutter

```bash
flutter pub get
```

#### 3. Instalar json-server

Si no tienes `json-server` instalado, puedes instalarlo globalmente con:

```bash
npm install -g json-server
```

#### 4. Ejecutar el json-server de forma local o global

```bash
npx json-server lib/data/db.json --port 3000

json-server --watch lib/data/db.json
```

Esto iniciará el servidor en:

```
http://localhost:3000
```

> ℹ️ Si estás usando un emulador de Android, utiliza `http://10.0.2.2:3000` en lugar de `localhost`.

#### 5. Ejecutar la aplicación Flutter

Asegúrate de tener un dispositivo/emulador corriendo, luego lanza la app con:

```bash
flutter run
```
