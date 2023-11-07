# fiven

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## run files .sh

./images-gen.sh
./icons-gen.sh

## flutter cli run project

flutter clean
flutter pub get

## flutter build apk release

    flutter build apk --release

## flutter build apk release with flavor

flutter build apk -t lib/flavors/main_production.dart --flavor=prod --release --no-tree-shake-icons

flutter build apk -t lib/flavors/main_develop.dart --flavor=dev --release --no-tree-shake-icons
