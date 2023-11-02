# Welcome to Fiserv Onboarding Experience Application

**fiservonboardingexp** is a mobile application that aims to address & resolve concerns with the current onboarding experience at Fiserv. 

## Getting Started

### Mobile Operating System Compatibility
| O/S | Status |
| :--- | :------: |
| `Android` | :white_check_mark: |
| `iOS` | :x: |

Currently, this app is only set up for Android mobile devices. Flutter supports cross-platform, for more information regarding this [click here](https://docs.flutter.dev/get-started/install).

## Software & Versioning
| Type | Name | Version |
| :---- | :----: | :-------: |
| `IDE` | VS Code | insert |
| `SDK` | Android Studio | insert |
| `SDK` | Flutter | >=2.19.4 <3.0.0 |
| `Language` | Dart | insert |
| `Database` | Firebase | -- |

For information on the decisions behind why these tools were used, please view the [Software Decisions & Considerations](https://github.com/MichaelCalbay/fiservonboardingexp/wiki/Software-Decisions-&-Considerations) page. 

## Plugins & Dependencies

Flutter and Dart require VS Code plugins to work. Install instructions & futher information can be found [here.](https://docs.flutter.dev/get-started/editor?tab=vscode)

fiservonboardingexp comes with a lot of dependencies. You can take a look from _line 30_ in [pubspec.yaml](https://github.com/MichaelCalbay/fiservonboardingexp/blob/master/pubspec.yaml) file and/or view the [Software Version & Dependencies](https://github.com/MichaelCalbay/fiservonboardingexp/wiki/Software-Version-&-Dependencies) page for more details.

### Installing Dependencies

There are two methods of adding dependencies to your projects in Flutter using VS Code: 
1. The first method to add dependencies in Flutter requires the pubspec.yaml file to be edited manually.
    First, add the code under the `dependencies` section (edit **placeholder** with the package name, and add the version after the colon 
    if required).
   
    ```
    dependencies:
    placeholder:
    ```
    then in the file, add the following line to the top of the file that will use it (edit the info **between the inverted commas** to match 
    the package info).
   
    ```
    import 'package:placeholder/placeholder.dart';
    ```
2. The second method utilizes the VS Code hotkeys.

    For Mac: `CMD` + `SHIFT` + `P`.

    For Windows: `CTRL` + `SHIFT` + `P`.

    Then, select `Dart: Add Dependency`
   
    ![Screenshot of VS Code hotkey result](https://github.com/MichaelCalbay/fiservonboardingexp/blob/master/assets/images/Adding_dependency1.png)
   
    Type in the dependency you want to install
   
   ![Screenshot of VS Code search result](https://github.com/MichaelCalbay/fiservonboardingexp/blob/master/assets/images/Adding_dependency2.PNG)
   
   Then in the file, add the following line to the top of the file that will use it (edit the info **between the inverted commas** to match 
   the package info).
   
   ![Screenshot of file import](https://github.com/MichaelCalbay/fiservonboardingexp/blob/master/assets/images/import.png)
  




























