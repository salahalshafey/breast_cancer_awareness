# Breast Cancer Awareness



## A Flutter project is mainly used for 
* Assisting Doctors with `deep learning models` for Breast Cancer detection.
* Providing `information and awareness` of this disease.
* Facilitating `self-examination` through a symptom checker.
* Offering support `resources` and `guidance` for patients. 
* Chatbot providing answers and guidance through `text-to-speech` and `speech-to-text` capabilities.
* Web Search `Google Search`, `Google Scholar`, and `Wikipedia`.


## This link provides the details of how we built the Breast Cancer Detection Models for both histopathology and X-ray
* https://github.com/salahalshafey/breast_cancer_detection.git


## Download the app from the Play Store
[//]: # "* [Download the app](https://play.google.com/store/apps/details?id=com.salahalshafey.breastcancerawareness)"
<a href="https://play.google.com/store/apps/details?id=com.salahalshafey.breastcancerawareness"><img src="https://playerzon.com/asset/download.png" width="300"></img></a>



# The main Technologies & Packages/Plugins used in the App
  * The **Backend** is `Firbease`:
    * `Cloud Firestore` to save the user data.
    * `Firebase Storage` to save the images of the user.
    * `Firebase Auth` to handle the **Authentication** and it uses 5 different `Sign-in providers`:
      * `Email/Password`.
      * `Google`.
      * `Facebook`.
      * `Twitter`.
      * `Anonymous`.
    * `Machine Learning` using `Custom models`, for the **models that we built**. And `download` the model for **Model Inference** using `firebase_ml_model_downloader`.
  * Providing `Offline Capabilities` Using [shared_preferences](https://pub.dev/packages/shared_preferences) plugin to save the `notes`, `Settings`, and user data in the device.
  * The app supports `Localizations` in `6 languages`:
    * English `en`.
    * Arabic `ar`.
    * Spanish `es`.
    * Frensh `fr`.
    * German `de`.
    * Turkish `tr`.
  * The app supports `Theming` for `Light` and `Dark`.
  * Using [tflite](https://pub.dev/packages/tflite) plugin for in-app `Models Inference`.
  * Using `Large Language Model` API from Google [Gemini Pro](https://makersuite.google.com/app/prompts/new_chat) for `Chat Prompt`.
  * Searching the web Using `Web Scraping` using [html](https://pub.dev/packages/html) the dom package.
  * `Speech-to-text` And `Text-to-speech` Capabilities:
    * Using [speech_to_text](https://pub.dev/packages/speech_to_text) plugin for speech recogintion.
    * Using [flutter_tts](https://pub.dev/packages/flutter_tts) for `Text-to-speech`.
    * Using [flutter_langdetect](https://pub.dev/packages/flutter_langdetect) to detect the language for `Text-to-speech`.
  * Using [youtube_player_flutter](https://pub.dev/packages/youtube_player_flutter) for playing `YouTube` videos.
  * Using [flutter_local_notifications](https://pub.dev/packages/flutter_local_notifications) plugin to set `reminder every 2 weeks`.
  * Using [flutter_sound](https://pub.dev/packages/flutter_sound) package for `recording` and `sound player`.
  * Using [path_provider](https://pub.dev/packages/path_provider) plugin to save The files `images` and `sounds` in `ApplicationDocumentsDirectory`.
  * Using [url_launcher](https://pub.dev/packages/url_launcher) plugin.
  * Providing `Check for updates` Capabilities.
  * The `Animation` in the App is done Using [flutter_animate](https://pub.dev/packages/flutter_animate) Package.




# The App Architecture, Directory structure, And State Management
  * Using `Provider` State Management.
  * Using `get_it` for Dependency injection.
  * Using the `Clean Architecture` of `Uncle Bob`.

 
    ![Screenshot 2024-01-05 200144](https://github.com/salahalshafey/breast_cancer_awareness/assets/64344500/45754ffb-f8ee-4115-a5ca-79977638e27a)
  * And

    ![0_zUtZYiJ1bDTugOYY](https://github.com/salahalshafey/breast_cancer_awareness/assets/64344500/b17e7fc7-ddaa-4371-933d-1bff4a577622)
## Directory Structure
```
lib
│
│───main.dart
│───firebase_options.dart
│───l10n
│  
└───src
    │
    │───core
    |    |
    |    |──error
    |    │──network
    |    │──theme
    |    |   │──colors
    |    |   │──dark_theme
    |    |   └──light_theme   
    |    |
    |    └──util
    |        |──builders
    |        │──classes
    |        │──extensions
    |        │──functions
    |        └──widgets   
    |    
    │───features
    |    |
    |    |──account
    |    │──breast_cancer_detection
    |    │──breast_cancer_for_normal
    |    │──breast_cancer_for_patient
    |    │──main_and_menu_screens
    |    └──settings
    |
    │───app.dart      
    │───dispose_container.dart  
    └───injection_container.dart
```
### Example of One feature: `breast_cancer_for_patient`
```
│───features
         |
         |──account
         │──breast_cancer_detection
         │──breast_cancer_for_normal
         │──breast_cancer_for_patient
         |   |
         |   │──data
         |   |   |──datasources
         |   |   |   |──ai_chat.dart
         |   |   |   |──google_scholar_search.dart
         |   |   |   |──google_search.dart
         |   |   |   └──wikipedia_search.dart
         |   |   |
         |   |   |──models
         |   |   |   └──search_result_model.dart
         |   |   |
         |   |   └──repositories
         |   |       └──search_repositories_impl.dart
         |   |   
         |   │──domain
         |   |   |──entities
         |   |   |   |──search_result.dart
         |   |   |   └──search_types.dart
         |   |   |
         |   |   |──repositories
         |   |   |   └──search_repositories.dart
         |   |   |
         |   |   └──usecases
         |   |       |──ai_result.dart
         |   |       └──custom_web_search.dart
         |   |   
         |   |   
         |   └──presentation
         |       |──pages
         |       |   |──for_patients_screen.dart
         |       |   |──other_resources_screen.dart
         |       |   |──search_screen.dart
         |       |   └──tips_for_your_visit_screen.dart
         |       |
         |       |──providers
         |       |   |──instructions_with_lang.dart
         |       |   └──search.dart
         |       | 
         |       └──widgets
         |           |──ai_result.dart
         |           |──for_patients_item.dart
         |           |──resource_item.dart
         |           |──search_field.dart
         |           |──search_keywords.dart
         |           |──search_type_choices.dart
         |           |──speech_to_text.dart
         |           └──web_search_result.dart
         |       
         |      
         |
         │──main_and_menu_screens
         └──settings
``` 


# App pages



## Login
### The Login screen 
  ![Login screen](https://github.com/salahalshafey/breast_cancer_awareness/assets/64344500/01c35c8c-211f-4ee0-ae21-06ef8995e841)
  * The login can be with `Email & Password`.
  * Notice that the API error appears in the **TextField error**.
### Continue on the Login screen 
  ![Login screen](https://github.com/salahalshafey/breast_cancer_awareness/assets/64344500/eca81bf3-91ea-4a83-90be-9cccb152d049)
  * you can change the `Theme` or `Language` from the **Login screen**.
### If the Password is forgotten screen
  ![Forget Password Screen](https://github.com/salahalshafey/breast_cancer_awareness/assets/64344500/b5a16dcb-be14-4b24-8135-dd9d9b410ece)
### Sign-in Can be done with Social
  ![Login with Social](https://github.com/salahalshafey/breast_cancer_awareness/assets/64344500/3febb26a-d71a-4f98-a9e7-8890f094b60d)
  * It can be with `Google`, `Facebook` or `X i.e. Twitter'`.
  * Social authentication is a multi-step authentication flow, allowing you to sign a user into an account or link them with an existing one.
  * Both native and web support creating a credential.
  * Follow this link for more details: https://firebase.flutter.dev/docs/auth/social
### Sign-in Can also be done as a Guest user
  * But some functionality is not available in the `Guest` account.


## sign-up
### First sign-up screen
  ![First sign-up screen](https://github.com/salahalshafey/breast_cancer_awareness/assets/64344500/21c7b7ec-384f-4b57-981d-8fd0ba5ae6ce)
  * In case if creating a new Account with `Email & Password`.
### Second sign-up screen
  ![Second sign-up screen](https://github.com/salahalshafey/breast_cancer_awareness/assets/64344500/20a7fb94-aeaa-449b-b40b-cca7ded47ac6)
  * Continuing to create an account on a second screen (optional), the user can choose an image of his, and select what kind of user he is if the user didn’t select the user type will be a "Normal user" as a default
  * In case of an `error` the `Skip For Now` button will appear to just go to the `home screen`.


## Home
### Home Screen
  ![Home Screen](https://github.com/salahalshafey/breast_cancer_awareness/assets/64344500/11bc2a20-2406-4150-b27f-17c7a92132ee)
  * The Home Screens contain the `Awareness info`, `self-check`, and the `history` of self-checks.
### Awareness screens
  ![Awareness screens](https://github.com/salahalshafey/breast_cancer_awareness/assets/64344500/299a3180-29ce-4f00-a277-01547c45cbe9)
  * some helpful `Information` and `Awareness` with `videos`.
  * Using [youtube_player_flutter](https://pub.dev/packages/youtube_player_flutter) for playing `YouTube` videos.
### Self-Check Screens
  ![Starting Self-Check Screens](https://github.com/salahalshafey/breast_cancer_awareness/assets/64344500/63624070-7ce7-47da-b9e3-f279f1720cf3)
### Continue on Self-Check and Finding Screens
  ![Self-Check Screens](https://github.com/salahalshafey/breast_cancer_awareness/assets/64344500/98efca1a-8fe9-4d64-ba58-4176dc835045)
### Reminder and notes adding screen
  ![Reminder and notes adding screen](https://github.com/salahalshafey/breast_cancer_awareness/assets/64344500/2271fee4-2047-4e9c-85fb-6c19715740f9)
  * If the user clicks `Ok` button, he will be notified every `2 weeks` to check again.
  * Using [flutter_local_notifications](https://pub.dev/packages/flutter_local_notifications) plugin to set `reminder every 2 weeks`.
  * The user can remove this reminder from `Settings`.
### Adding notes
  ![adding notes](https://github.com/salahalshafey/breast_cancer_awareness/assets/64344500/8e9b60c6-8adb-4933-94e7-05ac5dd57b16)
  * Notes can be `Text`, `Voice`, or `Image`.
  * You can record a `Voice` and `play the sound` and continue recording like a `WhatsApp` recording message.
  * Using [flutter_sound](https://pub.dev/packages/flutter_sound) package for `recording` and `sound player`.
  * Using [image_picker](https://pub.dev/packages/image_picker) plugin for choosing the image.
### Self-checks history
  ![Self-checks history](https://github.com/salahalshafey/breast_cancer_awareness/assets/64344500/4df242b0-f71b-42b8-b73a-1f7e645e552c)
  * Self-checks history saved in the local device and not on the server `Only the user can see` and it contains the `Notes`.
  * Using [shared_preferences](https://pub.dev/packages/shared_preferences) plugin to save the notes data in the device.
  * The files `images` and `sounds` saved in `ApplicationDocumentsDirectory` using [path_provider](https://pub.dev/packages/path_provider) plugin.
### The Image of Self-check Note
  ![image of Self-check](https://github.com/salahalshafey/breast_cancer_awareness/assets/64344500/d85a3d10-d949-4d62-b58c-a8f8b3346017)
  * The **Image** can be opened in a **New Screen** and Using [photo_view](https://pub.dev/packages/photo_view) package to `zoom` in or out.
  * The `Image screen` contains actions buttons `save to gallery` and `share`, Using [gallery_saver](https://pub.dev/packages/gallery_saver) and [share_plus](https://pub.dev/packages/share_plus) plugins.
  * The `Text Note` will be above the image, and can be `toggled` to appear or disappear.
### deleting self-check
  ![deleting self-check](https://github.com/salahalshafey/breast_cancer_awareness/assets/64344500/b2a30dcb-0c82-45eb-9984-a2574622ea6b)
  * You can delete `one` or `All` self-checks.


## For doctors
  * In this feature we **infer** the `Deep Learning` models that we built to make a `prediction` if Breast Cancer exists.
  * Using [firebase_ml_model_downloader](https://pub.dev/packages/firebase_ml_model_downloader) and [tflite](https://pub.dev/packages/tflite) plugins to `Download` the model from `Firebase` and making `model inference`.
### For doctors' screen
  ![For doctors' screen](https://github.com/salahalshafey/breast_cancer_awareness/assets/64344500/9e161c73-8838-43b6-91a2-9afeb608da65)
  * The user `Doctor or radiologist` can pick an image and there are four ways to do that:
    * **Open the Camera** and take a picture of the medical image if he has it physically
    * **Pick an image from the device** if he has it in the file system
    * Get an image link by **reading the QR code** of the medical image if the image exists online
    * Alternatively, he can simply **paste the link** in the text field.
### Only Available For Doctors
  ![Only Available For Doctors](https://github.com/salahalshafey/breast_cancer_awareness/assets/64344500/84c6e039-93c4-4843-a294-3a97bcb910b1)
  * In case of a `Guest user` or the user is not a `Doctor`, this feature is **not available**.
### The image link must be valid and point to an image
  ![the image link must be valid and point to an image](https://github.com/salahalshafey/breast_cancer_awareness/assets/64344500/47b6cd1e-14e9-4e63-9be7-8e04303cdd6e)
  * For `Pasting` the link in the `TextField`.
### The image link must be valid and point to an image
  ![The image link must be valid and point to an image](https://github.com/salahalshafey/breast_cancer_awareness/assets/64344500/fe506624-f0fd-4369-8f66-4ea924d64018)
  * The same case for `getting image link by QR Code`.
### Select medical image
  ![Select medical image](https://github.com/salahalshafey/breast_cancer_awareness/assets/64344500/5f7477f0-ce94-420c-b797-f067f975770a)
  * After the user chooses an image `x-ray or histology` and clicks the **show result** button, he must select the medical image type to get the right **model** for the image.
### Prediction screen
  ![Prediction screen](https://github.com/salahalshafey/breast_cancer_awareness/assets/64344500/2a81bb69-5c71-42ea-a322-6ca18afce9c4)
  *	The user `Doctor or radiologist` can see the model prediction on the chosen image
  *	In the case of the above, the medical image is `X-Ray`, and the right model is specified.
### Prediction screen
  ![Prediction screen](https://github.com/salahalshafey/breast_cancer_awareness/assets/64344500/ebfc318a-7f42-4695-bb6e-fa4881640e14)
  *	In the case of the above, the medical image is `Histology`, and the right model is specified. 
### Warning for using these models
  ![Warning for using these models](https://github.com/salahalshafey/breast_cancer_awareness/assets/64344500/99d4cbbf-dbaf-40fe-8019-532f6fa33152)
  * Warning for using these models in different `Theme` and `Language`.


## For Patients
### For Patients' Screen
  ![For Patients' Screen](https://github.com/salahalshafey/breast_cancer_awareness/assets/64344500/f5e8858a-420a-4e02-97ad-b21fdeb9b6f9)
  * Offering support `resources` and `guidance` for patients. 
### Tips and Other Resources screens
  ![Tips and Other resources screens](https://github.com/salahalshafey/breast_cancer_awareness/assets/64344500/f54d2a71-2045-4ee4-b62b-ec3896eb87db)
  * In the Other resources screen the `link` will open in the `browser`
  * Using [url_launcher](https://pub.dev/packages/url_launcher) plugin.
### Tips for translation
  ![Tips for translation](https://github.com/salahalshafey/breast_cancer_awareness/assets/64344500/5cb1c7fc-9929-4a15-8052-64964139edf0)
### GIF to explain the above
  ![Tips for translation](https://github.com/salahalshafey/breast_cancer_awareness/assets/64344500/c0f0593c-0d91-4e96-b74e-1915a18c5493)
### Some resources for diet and fitness for patients
  ![some resources for diet and fitness for patients](https://github.com/salahalshafey/breast_cancer_awareness/assets/64344500/cba17428-5ac1-405d-9f47-efef2334d3e3)
### Search Screen
  ![Search Screen](https://github.com/salahalshafey/breast_cancer_awareness/assets/64344500/8a1337d9-adfa-41dc-b2ff-291784066eed)
  * Warning dialog will `pop up when opening the `Search screen`.
  * This feature is not available for `Guest users`.
### Ways of search
  ![Ways of search](https://github.com/salahalshafey/breast_cancer_awareness/assets/64344500/3d22afd8-09a4-41b9-8c9e-b088dc01947c)
  * The **Search** can be with `Voice`, `Text`, or `Some keywords`.
  * The `Voice Search` is available in +70 languages. 
  * Using [speech_to_text](https://pub.dev/packages/speech_to_text) plugin for speech recogintion.
### Ask AI
  ![Ask AI](https://github.com/salahalshafey/breast_cancer_awareness/assets/64344500/b47f9150-11d7-4038-a7e0-d7175bea710b)
  * You can `Ask AI` for Guidance.
  * The result is in the `Markdown` format, and it can be spoken if possible `i.e. settings allow it`.
  * Using [flutter_tts](https://pub.dev/packages/flutter_tts) for `Text-to-speech`.
  * Using [flutter_langdetect](https://pub.dev/packages/flutter_langdetect) to detect the language for `Text-to-speech`.
  * The `AI` is from [Gemini Pro](https://makersuite.google.com/app/prompts/new_chat) API from Google.
### Web Search
  ![Web Search](https://github.com/salahalshafey/breast_cancer_awareness/assets/64344500/22f8579a-802f-47bf-af29-948e82c9dd9f)
  * You can Search with `Google`, `GoogleScholar`, or `Wikipedia`.
  * The Web Search is achieved using `Web Scraping`.
  * The `Web Scraping` using [html](https://pub.dev/packages/html) the dom package.
  * The first result also will be spoken.
### The Possible errors in the result
  ![The Possible errors in the result](https://github.com/salahalshafey/breast_cancer_awareness/assets/64344500/4c88ed53-846d-488d-8bc5-74d7fcc883e2)


## Menu Screen
  ![Menu Screen](https://github.com/salahalshafey/breast_cancer_awareness/assets/64344500/7df7183c-12a1-4713-8148-c890d7c0327c)
  * you can `share` the app `the link to the Play Store`
  * The most right screen is the view of `guest user`.


## Profile
### Profile Screen
  ![Profile Screen](https://github.com/salahalshafey/breast_cancer_awareness/assets/64344500/b0076bc0-7efe-48e6-9d28-cdbc7c81de3d)
  * Notice the difference if the user signed with `Email & Password`, `Twitter`, `Facebook`, `Google`, or `as a Guest`.
### Delete the account
  ![Delete the account](https://github.com/salahalshafey/breast_cancer_awareness/assets/64344500/a16fa8ff-5926-414d-8f80-ca1d0de3b84c)
  * If the account is `Email & Password` the user will asked to put `his password`.
  * If the account is `social`, the user will be asked to `Authorize` the social account `for deletion`.
### Edit Profile screen
  ![Edit Profile screen](https://github.com/salahalshafey/breast_cancer_awareness/assets/64344500/02a1b2bd-4c0f-4a6f-984f-255980ca4fc8)
  * The user can **Change** the `image`, `Names`, `user type`, or `phone number`.
  * The `phone number` must be **valid** or **no phone number**.


## Settings
### Settings screen
  ![Settings screen](https://github.com/salahalshafey/breast_cancer_awareness/assets/64344500/f0bf3ce6-e133-4f30-8e1f-395f6a06c59b)
### Theme can be changed
  ![Theme can be changed](https://github.com/salahalshafey/breast_cancer_awareness/assets/64344500/fe0ce2ac-2634-4669-86d9-0faeaacc5901)
  * Some `examples` of `Dark theme`.
### Language can be changed
  ![language can be changed](https://github.com/salahalshafey/breast_cancer_awareness/assets/64344500/192ebc23-1882-4aeb-8a45-53390a314b51)
  * The App is available in `6 languages`.
  * Some `examples` of `Arabic` language.
### Search result settings
  ![Search result settings](https://github.com/salahalshafey/breast_cancer_awareness/assets/64344500/22ffdfcd-2bd7-46b1-9b9c-6c6c401bbc77)
  * You can choose `to speak` the `search result` or **not**.
  * You can `change` the `Voice search language`, available `+70` languages.


## About Screen
  ![About Screen](https://github.com/salahalshafey/breast_cancer_awareness/assets/64344500/1d950464-93dc-43d5-8138-27753abb6b20)
  * You can `check for updates`.
  * App `privacy policy` and `terms of services`, etc...


## Check for updates
  * In all scenarios below the `current app version` is 1.0.1
  * And `current App Datetime` is Jan 4th, 2024 at 1:36 PM.
### The data on Firebase
  ![The data on Firebase](https://github.com/salahalshafey/breast_cancer_awareness/assets/64344500/4f152123-a2de-4849-91a1-a4562de6931e)
  * The App will read this data from `Firebase` to show the user a `dialog` with info about `Updates` the app's `status`.
  * Notice that in the `security rules` adding a part to allow only `read` to work with `unauthenticated` read, for example, `sign-in` screen, **, in other words,** `can check for updates from the sign-in screen`.
### No updates
  ![Screenshot 2024-01-06 110634](https://github.com/salahalshafey/breast_cancer_awareness/assets/64344500/6b128140-9d4d-40fe-9e1b-ce120cf9e42c)
  * In this scenario `latest_version` is the same as `current app version`, no `update dialog` is shown.
### Selective update
  ![Selective Check for updates](https://github.com/salahalshafey/breast_cancer_awareness/assets/64344500/f2634a7a-2d48-41d9-baf9-5d74f7aa6ed7)
  * In this scenario `latest_version` is higher than `current app version`, but no `force updates`.
### Force update after period of time
  ![Force updates after period of time](https://github.com/salahalshafey/breast_cancer_awareness/assets/64344500/d9979ebe-7049-4500-8e40-0c679bcdc7d2)
  * In this scenario `latest_version` and `force_update_versions_below` is higher than `current app version`, but the `current App time` is before `force_update_after`.
  * Using [ntp](https://pub.dev/packages/ntp) Plugin for getting `Network Time Protocol (NTP)` in case the user changes the `local device time` manually, to still get the right `Time`.
### Force update
  ![Screenshot 2024-01-05 174151](https://github.com/salahalshafey/breast_cancer_awareness/assets/64344500/a6529ec0-d9d4-4dae-a930-1926e330c79e)
   * In this scenario `latest_version` and `force_update_versions_below` is higher than `current app version`, but the `current App time` is after `force_update_after`.
   * Also Using [ntp](https://pub.dev/packages/ntp) Plugin.
   * The user can't use the app, and he must update the app from the `Play Store`.







