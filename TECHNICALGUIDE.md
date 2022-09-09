

# Technical guide
This documentation gives informations libraries and their versions.
The app is different when a instructor or a client is log in, we provide two users for the tests.
You can find the whole project on [gitHub](https://github.com/MatthieuHagenbuch/projectmaster).

## Users for testing
- instructor user : matt@test.com (password: 123456)
- client user : oceane@test.com (password: 123456)

## Development team
- Tapparel Océane : @ocetapp on gitHub
- Hagenbuch Matthieu : @MatthieuHagenbuch on gitHub

## Specification / Technology
This application was developped with Flutter (version 3.48.0)
The language code is Dart (version 3.48.3)
Data storage was done with Firebase
The application is deployed on Google Playstore

## Library used
# Authentication
  firebase_auth: ^3.4.2
  flutterfire_ui: ^0.4.2+3
# Calendar management
  datetime_picker_formfield : ^2.0.0
  table_calendar: ^3.0.6
  syncfusion_flutter_calendar: ^20.2.46
# Firebase
  firebase_core: ^1.12.0
  cloud_firestore: ^3.1.8 
# Style
  flutter_launcher_icons: "^0.9.2"
  settings_ui: ^2.0.2
  google_fonts: ^3.0.1
  transparent_image: ^2.0.0


## Database overview
# Users:
- uId and email from Firebase Authentication
- role : The default role is client. For now the change of role can be done on Firestore
- events : A list of events that a client has accepted

# Events:
contain all the informations about each event


  

 

 