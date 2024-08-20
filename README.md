# comic_vine_app

This is an app built with Flutter, following clean architecture principles, and consuming the Comic Vine API.

## API Used

This application utilizes the [Comic Vine API](https://comicvine.gamespot.com/api/documentation) to retrieve data about the latest comics, characters, and more.

- API Documentation: [Comic Vine API Documentation](https://comicvine.gamespot.com/api/documentation)

## Requirements

- Flutter: 3.22.2
- Dart: 3.4.3

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/Jairo-Grande/comic_vine_app.git
   
2. Descarga las dependencias:
   flutter pub get

## Ejecución

  Flutter run

## Compilación

Para construir la aplicación para Android:
Flutter build apk --release

## Test
para ejecutar los test:
flutter test test/fetch_issues_unit_test.dart

## Additional Information
The app follows a clean architecture structure, separating concerns into data, domain, and presentation layers for maintainability and scalability.
Continuous integration and testing pipelines are recommended for production environments.


   
