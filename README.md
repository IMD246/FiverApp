# fiver

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

flutter build apk -t lib/flavors/main_staging.dart --flavor=staging --release --no-tree-shake-icons

flutter build apk -t lib/flavors/main_development.dart --flavor=dev --release --no-tree-shake-icons

## build runner cmd

dart run build_runner clean

dart run build_runner build --delete-conflicting-outputs

## flutter upgrade package

-single

dart pub upgrade --namePackage

-plural

dart pub upgrade
