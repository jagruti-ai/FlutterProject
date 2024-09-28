# flutterapp_task

 Flutter project.

## Getting Started

# Flutter Firebase Ecommerce

This is a Flutter application that demonstrates how to use Firebase Authentication,how to Fetch data from API i.e Prodct Listing and apply Product Filtering.

## Features

- **Firebase Authentication:** User sign-in and sign-up using email/password.
- **Use the API :** Fetching a list of products from API.
- **Product Filtering:**  Simple search functionality to filter products by title.

## Getting Started

### Prerequisites

- **Flutter:** Ensure you have Flutter installed and set up on your system: [https://flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install)
- **Dart:** Dart is included with Flutter.
- **Firebase:**  Create a Firebase project and enable Firebase Authentication and Cloud Firestore. Get your Firebase config: [https://firebase.google.com/docs/web/setup](https://firebase.google.com/docs/web/setup)

### Setup

1. **Create a Firebase Project:** Create a Firebase project at [https://console.firebase.google.com/](https://console.firebase.google.com/).
2. **Enable Firebase Authentication:**  In your Firebase project, enable the "Email/Password"  method.
3. **Download Firebase Configuration:** Download the Firebase configuration file (`google-services.json`) 
5. **Install Dependencies:**
 This is all dependencies that used in my app:

  firebase_auth: ^5.2.0
  google_sign_in: ^6.2.1
  firebase_core: ^3.5.0

   flutter pub get

   ### Project Stucture

   FlutterApp_task/
├── lib/
│   ├── main.dart
│   ├── HomePage.dart
│   ├── SignUpPage.dart  
│   ├── LoginPage.dart  
│   ├── Productlistpage.dart  
│   ├── ProductfilterPage.dart  
│     
│   
├── pubspec.yaml
└── README.md

## Project Explanations

Firstly, I created the application with the help of various packages and APIs. In this app, I implemented Firebase Authentication for the signup and login screens, designing three screens in total: the Home Screen, Login Screen, and Signup Screen.

When the app starts, the user is directed to the Auth Screen. They can sign in or create an account using Firebase Authentication. Once authenticated, the app navigates to the Home Screen.

The Home Screen displays the ProductList widget, which fetches product data from an API. The search bar in the ProductList widget allows users to filter the products. The filtering logic updates the _filteredProducts list, and the ListView.builder re-renders to display the filtered results.