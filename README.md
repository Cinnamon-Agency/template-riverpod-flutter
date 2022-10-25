# Cinnamon Flutter project Template
## **Table of Contents**

- [Flutter Riverpod App Template](#flutter-riverpod-app-template)
- [Architecture structure](#architecture-structure)
  * [Presentation](#presentation)
    + [Widgets](#widgets)
    + [Controllers](#controllers)
  * [Domain](#domain)
  * [Data](#data)
    + [Repositories](#repositories)
  * [Services](#services)
    + [Api](#api)
    + [Firestore](#firestore)
    + [Firebase Auth](#firebase-auth)
    + [Location](#location)
    + [Storage](#storage)
    + [Device/Device Info](#device/device-info)
- [Folder structure](#folder-structure)
- [Architecture flow example](#architecture-flow-example)
- [How to use](#how-to-use)


# Flutter Riverpod App Template
This project has everything you need to start a Flutter project with Riverpod as the state management tool.

# Architecture structure
This template is built with architecture that consists of four main layers: Presentation (UI), Service, Domain (Models, DTOs)
and Data (Repositories).

## Presentation
This layer contains only UI elements (widgets) and controllers that handle events and update interface.

### Widgets
- Present user interface, render widgets, play animations
- Minor validation logic, text input listeners

### Controllers
- Hold some business logic
- Manage widget state
- Interact with the Data layer (repositories)

## Domain
This layer contains data models and represents them as immutable data classes in Dart, 
along with any business logic we may need to modify them.

## Data
Data layer combines different repositories and handles business logic.

### Repositories
The Repositories are very handy if your app has a complex data layer with many different endpoints 
that return unstructured data (such as JSON) that you want to isolate from the rest of the app.
- Isolate domain models from the implementation details of the data sources in the data layer
- Convert data transfer objects to validated entities that are understood by the domain layer

## Services
Services act as a middle-man between the controllers (widget-only) and the repositories (data-only).
They are not concerned about parsing data or updating the widget state.

### Api
- This service communicates with remote sources (REST API, sockets, etc.)

### Firestore
- This service communicates with Cloud Firestore.

### Firebase Auth
- This service communicates with Firebase Authentication.

### Location
- This service communicates with device's location (via GPS and/or Google Services)

### Storage
- This service communicates with device's storage to provide data caching.

### Device Info
- This service communicates with device's hardware and software, providing information about them.

# Folder structure
Top-level folder structure that can be found under **/lib**:

- **constants** contains app constants (e.g. endpoint names)
- **features** contains all application's **UI** elements (screens, widgets) and corresponding **controllers**
- **models** contains data model classes
- **providers** contains all global providers (mainly for **services** and **repositories**)
- **repositories** contains all repositories
- **router** contains application's router powered by [go_router](https://pub.dev/packages/go_router)
- **services** contains all services
- **shared** contains widgets and other elements that are shared across different parts of the app
- **theme** contains custom theme data
- **utils** contains utilities that do not belong in the shared or features folders
- **main.dart** core file that initializes our application
# How to use
Installation is easy and can be done in seconds! Clone this project, make sure you're on the latest Flutter version, open the newly cloned project and run the following commands:

Download all dependencies:

```bash
flutter pub get
```

Run the app:

```bash
flutter run
```

<p align="center">
  <a href='https://cinnamon.agency/'>
    <img src="https://cinnamon.agency/_next/static/media/logo-white.97f0c2c8.svg">
  </a>
</p>

