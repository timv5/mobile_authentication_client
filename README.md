# mobile_authnetication_client
Mobile flutter client for basic OAuth and authentication 

## Usage and installation
### Localization
- flutter gen-l10n
- run app and localization should work now

## Firebase
- go to: implementation https://console.firebase.google.com/u/1/
- add new project
- add new app (android + ios if necessary), follow instructions
- add authentication to this project
  - add new sign in method
  - add new user (for login purposes)
- add Firestore Database and define new collection "users" with fields (additionally add rule for read&write)
  - auto generated ID
  - email
  - username

## Access to the internet
- source: https://docs.flutter.dev/cookbook/networking/fetch-data