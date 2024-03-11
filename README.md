# fiver

Description : Fiver is an online shop that allows people to view/buy products from company

# Tech-stack
  BE: PHP + Laravel:
      .  Repository - pattern 
  FE-Mobile: FLutter + Dart:
             . Clean Architecture
             . State-Management: Provider
             . Restful-API: Dio
             . Local-Database: Shared-Preference, Isar

## SDK Version

dart: ">=3.2.3 <4.0.0"

flutter: ">=3.16.6"

## run files .sh

./images-gen.sh

./icons-gen.sh

## flutter cli run project

flutter clean

flutter pub get

## flutter build apk release with flavor

flutter build apk -t lib/flavors/main_production.dart --flavor=prod --release --no-tree-shake-icons

flutter build apk -t lib/flavors/main_staging.dart --flavor=staging --release --no-tree-shake-icons

flutter build apk -t lib/flavors/main_development.dart --flavor=dev --release --no-tree-shake-icons

## flutter build appbundle with flavor

flutter build appbundle --flavor dev -t lib/flavors/main_development.dart

flutter build appbundle --flavor prod -t lib/flavors/main_production.dart

flutter build appbundle --flavor staging -t lib/flavors/main_staging.dart

## flutter run release with flavor

flutter run -t lib/flavors/main_production.dart --flavor=prod --release

flutter run -t lib/flavors/main_staging.dart --flavor=staging --release

flutter run -t lib/flavors/main_development.dart --flavor=dev --release

## build runner cmd

dart run build_runner clean

dart run build_runner build --delete-conflicting-outputs

## flutter upgrade package

-single

dart pub upgrade --namePackage

-plural

dart pub upgrade
