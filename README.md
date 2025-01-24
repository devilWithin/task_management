# Task Management App

- This project is a task management app that is developed using Flutter and Dart.

# Project Structure:

- The project is structured in a clean architecture way, my approach to the solution that it would be scalable
- in the future and maybe the stakeholders or people responsible for business would ask for new features.
- The project is divided into the following folders:
    - Configs
    - Core
    - Features
    - Injection Container

- Configs: Contains all the configurations of the project like routing, theme.
- Core: Contains all the core files that are used in the project like error, utils, api, local_db, widgets.
- Features: Contains all the features that are used in the project like auth and task.
- Injection Container: Contains all the dependency injection of the project.

## Configs.Routing:
- Routing consists of 2 classes [App Routing, Routes]
- AppRouting is class responsible for navigating between screens.
- Routes contains all the accessible screens for the user.
- The project uses the Generated Routing mechanism in order to achieve animation effects when navigating between screens.

## Core.Settings:

- At the core folder, there is a directory name settings.
- The settings directory holds all the settings for the project includes String, Colors, Padding and all the common settings for the project.

## Core.Utils:

- Contains the notification service which is an interface that is implemented by Local Notification Service to apply Abstraction and also DI , Open Closed Principles.
- Can't apply the Push Notifications on this solution as it is a pay-as-you-go plan.
- But we usually generate FCM token for each device and associate it with a user in case if the user logged in the app from another device.
- Then we have 2 approaches to send push notifications, Either from a backend server written in the tech stack of the company (PHP, Node.js, C#).
- Or we could write Vanilla.js or TypeScript in Firebase cloud functions to achieve the desired feature.
- String Validator: is a file that holds all the validation done on String data type through extension, a powerful tool in Dart to add functionality on existing libraries.

## Core.Widgets

- Holds all the shared widgets between many components.
- BaseState : A Generic class that is used with Bloc/Cubit classes to remove boilerplate code when calling apis.
- We Usually emit Loading State when a user click a button waiting for the response.
- This response would be Failure or success and we emit a new state for each situation.
- So, instead of creating a state class for each Bloc/Cubit, I created this class to use it to remove the boilerplate code associated with BloC.

## Lib.injectionContainer

- Injection container is a class that holds all the dependencies of the project.
- It is used to inject the dependencies in the project.
- I used the GetIt package to achieve this feature as it's easy to initialize and maintain.
- Working on a complex or mega project makes the injection_container class a mess.
- So i used a file named after the name of the feature like (auth_injection.dart) to hold the dependencies of the feature.
- This approach makes the code more readable and maintainable.

# Suggestions:

- A better approach to the solution is that each user should have its own tasks.
- So, I would add a user_id field to the task model and associate each task with a user.
- This approach would make the solution more scalable and secure.
- Also, I would not use Stream to listen for task changes, instead i would use an HTTP request to get the tasks of the user.
- Using this approach would allow us to apply SSOT (Single Source of Truth) to save the task in a local DB like (Hive) and significantly increase the UX for the user.
- I like to use Hive DB as it is a NoSQL DB and fast.
- The user would see the tasks even if he is offline and the app would sync the tasks when the user is online.
- Including any operations like (Create, Update, Delete) would be done on the local DB and then synced with the Firebase.

# Notes:

- The design of the app is simple as it is done for the purpose of the task.
- Normally, UI/UX designers would design the app and the developer would implement the design.
- To Achieve responsive design i would suggest using Flexible, Expanded, MediaQuery, LayoutBuilder, OrientationBuilder, AspectRatio.
- There are also many packages to achieve the responsive design like flutter_screenutil, sizer.
- My mindset is to write the code by myself and avoid using packages as much as possible.
- So a feature like responsive design would be done by me without using any package if i am working independently.
- Choosing between using packages or writing the code by yourself depends on the project requirements and the time frame also the team familiarity.


