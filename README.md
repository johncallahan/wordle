# Wordle

A [Wordle](https://www.powerlanguage.co.uk/wordle/) clone in Flutter.

## To build the game model wrapper

% flutter pub run build_runner build --delete-conflicting-outputs

## To run on android (local dev)

% flutter run --dart-define=BASE_PROTOCOL=http --dart-define=BASE_HOST=localhost --dart-define=BASE_PORT=3000

## To run on iPhone (local dev)

% flutter run --dart-define=BASE_PROTOCOL=http --dart-define=BASE_HOST=localhost --dart-define=BASE_PORT=3000

## To run on android (production)

% flutter run --dart-define=BASE_PROTOCOL=https --dart-define=BASE_HOST=yourdomain.com --dart-define=BASE_PORT=443

## To run on iPhone (production)

% flutter run --dart-define=BASE_PROTOCOL=https --dart-define=BASE_HOST=yourdomain.com --dart-define=BASE_PORT=443 --release
