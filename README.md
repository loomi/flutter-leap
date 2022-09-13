#
<p align="center">
  <img src="" alt="" width="" />
</p>

<h1 align="center">Loomi Flutter Leap</h1>


### Userful links
- [Mockup]()
- [Tasks list]()

###
#### Depends on Flutter 2.10.0

## 📋 Flutter APP commands

### Dependencies update

+  `flutter pub get`

### MobX store and retrofit generation

+  `flutter pub run build_runner build --delete-conflicting-outputs`

### Icons generation

+ `Go to pubspec file and add the path of your icon on 'flutter_icon'`

+ `The icon should be 512x512 or 1024x1024`

+ `flutter pub run flutter_launcher_icons:main`

### Native Splash Screen generation

+ `flutter pub run flutter_native_splash:create`

### Code analysis

+ `flutter analyze`

## 🏃‍♂️How to run

> First, we need to update dependencies and generate code

+  `flutter pub get`
+  `flutter pub run build_runner build --delete-conflicting-outputs`

> After that, we can run the application

#### On Android:

flavorsOptions = [staging, homolog, production]

+ `flutter run --flavor [flavorOption]`
+ Ex: `flutter run --flavor production`

#### On iOS:

+ `cd ios && pod install`
+ `flutter run -- flavor [flavorOption]`

#### To start a new project:

+ `replace the 'com.example.loomiFlutterBoilerplate' across all the files with your desired bundleId`
+ `on android/app/src/main/java/kotlin rename the subsequent folder names with your bundle id name`


## 📚 Stack

- **GetIt** for dependency injection
- **MobX** for reactivity
- **Retrofit** for https requests
- **Json_serializable** for json mapping
- **Build_runner** for generated code


#
Made with ❤️ by **Loomi**

