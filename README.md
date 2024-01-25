# flutter_leap_v2

<p align="center">
  <img src="" alt="" width="" />
</p>

<h1 align="center">Loomi Flutter Leap</h1>

### Userful links

- [Flutter Loomi GitBook](https://loomi.gitbook.io/flutter-loomi/)

###

#### Depends on Flutter 3.16.7 and Dart 3.2.4 >

## 📋 Flutter APP commands

### Dependencies update

- `flutter pub get`

### MobX store and retrofit generation

- `flutter pub run build_runner build --delete-conflicting-outputs`

### Icons generation

- `Go to pubspec file and add the path of your icon on 'flutter_launcher_icons' section`

- `The icon should be 512x512 or 1024x1024`

- `dart run flutter_launcher_icons ou flutter pub run flutter_launcher_icons`

### Native Splash Screen generation

- `flutter pub run flutter_native_splash:create`

### New Modules Generation

- `On the first time install mason: dart pub global activate mason_cli`
- `On the first time run: mason get`
- `The just run: mason make gen_module -o lib/app/modules`

### Code analysis

- `flutter analyze`

## 🏃‍♂️How to run

> First, we need to update dependencies and generate code

- `flutter pub get`
- `flutter pub run build_runner build --d`

> After that, we can run the application

#### On Android:

flavorsOptions = [staging, homolog, production]

- `flutter run --flavor [flavorOption]`
- Ex: `flutter run --flavor production`

#### On iOS:

- `cd ios && pod update && && pod install --repo-update`
- `flutter run -- flavor [flavorOption]`

#### To start a new project:

- `replace the 'com.example.loomiFlutterBoilerplateV2' across all the files with your desired bundleId`
- `on android/app/src/main/java/kotlin rename the subsequent folder names with your bundle id name`

### To set Environments content

- `On the environments.dart file check the keys you need`
- `Depending on your desired flavor, create a .env.[flavorNameHere]. Ex: .env.staging`
- `Add all the keys and corresponding values`
- `Do never upload the .env file to the repository. Encode the file content and only decode it on your project build setup`

## 📚 Stack

- **GetIt** for dependency injection
- **MobX** for reactivity
- **Retrofit** for https requests
- **Json_serializable** for json mapping
- **Build_runner** for generated code

#

Made with ❤️ by **Loomi**
