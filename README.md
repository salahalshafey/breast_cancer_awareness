# Breast Cancer Awareness



## A Flutter project is mainly used for 
* Assisting Doctors with `deep learning models` for Breast Cancer detection.
* Providing `information and awareness` of this disease.
* Facilitating `self-examination` through a symptom checker.
* Offering support `resources` and `guidance` for patients. 
* Chatbot providing answers and guidance through text-to-speech and speech-to-text capabilities.
* Web Search `Google Search, Google Scholar, Wikipedia`.


## This link provides the details of how we built the Breast Cancer Detection Models for both histopathology and X-ray
* https://github.com/salahalshafey/breast_cancer_detection.git


[//]: # " ## Download the app in apk for android"
[//]: # " * [Download the app](https://firebasestorage.googleapis.com/v0/b/breast-cancer-awareness-bf348.appspot.com/o/the%20app%20in%20apk%2Fbreast_cancer_awareness_v_0_5_0.apk?alt=media&token=e3d928cc-7c89-452c-aee3-20eadfb352f1)"


## Download the app from the Play Store
[Download the app](https://play.google.com/store/apps/details?id=com.salahalshafey.breastcancerawareness)


# App pages



## Login
### the Login screen 
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
### Self-Check Screens
  ![Starting Self-Check Screens](https://github.com/salahalshafey/breast_cancer_awareness/assets/64344500/63624070-7ce7-47da-b9e3-f279f1720cf3)
### Continue on Self-Check and Finding Screens
  ![Self-Check Screens](https://github.com/salahalshafey/breast_cancer_awareness/assets/64344500/98efca1a-8fe9-4d64-ba58-4176dc835045)
### Reminder and notes adding screen
  ![Reminder and notes adding screen](https://github.com/salahalshafey/breast_cancer_awareness/assets/64344500/2271fee4-2047-4e9c-85fb-6c19715740f9)
### Adding notes
  ![adding notes](https://github.com/salahalshafey/breast_cancer_awareness/assets/64344500/8e9b60c6-8adb-4933-94e7-05ac5dd57b16)
  * Notes can be `Text`, `Voice`, or `Image`.
  * You can record a `Voice` and `play the sound` and continue recording like a `WhatsApp` recording message.
  * Used [flutter_sound](https://pub.dev/packages/flutter_sound) package for `recording` and `sound player`.
### Self-checks history
  ![Self-checks history](https://github.com/salahalshafey/breast_cancer_awareness/assets/64344500/4df242b0-f71b-42b8-b73a-1f7e645e552c)
  * Self-checks history saved in the local device and not on the server `Only the user can see` and it contains the `Notes`.
  * Used [shared_preferences](https://pub.dev/packages/shared_preferences) plugin to save the notes data in the device.
  * The files `images` and `sounds` saved in `ApplicationDocumentsDirectory` using [path_provider](https://pub.dev/packages/path_provider) plugin.
### The Image of Self-check Note
  ![image of Self-check](https://github.com/salahalshafey/breast_cancer_awareness/assets/64344500/d85a3d10-d949-4d62-b58c-a8f8b3346017)
  * The **Image** can be opened in a **New Screen** and used [photo_view](https://pub.dev/packages/photo_view) package to `zoom` in or out.
  * The `Image screen` contains actions buttons `save to gallery` and `share`, used [gallery_saver](https://pub.dev/packages/gallery_saver) and [share_plus](https://pub.dev/packages/share_plus) plugins.
  * The `Text Note` will be above the image, and can be `toggled` to appear or disappear.
### deleting self-check
  ![deleting self-check](https://github.com/salahalshafey/breast_cancer_awareness/assets/64344500/b2a30dcb-0c82-45eb-9984-a2574622ea6b)
  * You can delete `one` or `All` self-checks.


## For doctors
  * In this feature we **infer** the `Deep Learning` models that we built to make a `prediction` if Breast Cancer exists.
  * Used [firebase_ml_model_downloader](https://pub.dev/packages/firebase_ml_model_downloader) and [tflite_flutter](https://pub.dev/packages/tflite_flutter) plugins to `Download` the model from `Firebase` and making `model inference`.
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
### 


## Menu and Profile screen
  ![Menu and Profile screen](https://github.com/salahalshafey/breast_cancer_awareness/assets/64344500/37488f81-eae5-4659-8480-f99b7e0c3eb3)


## Settings screen
  ![Settings screen](https://github.com/salahalshafey/breast_cancer_awareness/assets/64344500/d55e7c0b-5707-4290-8159-64e401181eac)


## Home screen and for patient screen
  ![Home screen and for patient screen](https://github.com/salahalshafey/breast_cancer_awareness/assets/64344500/6904a1d2-7604-48bd-8b89-8a54da444e22)
  * These screens are “optional” and will be implemented in the future

