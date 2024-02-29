# BrokerShaati Task

This project is developed as part of the BrokerShaati task. It includes functionality for creating a user profile and navigating to a homepage after filling in all required details.

## Description

The project consists of the following components:

- **ProfileScreen**: This screen allows users to input their profile details, including name, address, password, and profile image.
- **ProfileFormView**: A view responsible for displaying the form to input profile details.
- **ImagePicker**: A component used to pick images from the device's photo library.
- **HomePageView**: The homepage view that users navigate to after completing their profile.

## Technologies Used

- SwiftUI: For building the user interface.
- Combine: For handling asynchronous events and data flow.
- Alamofire: For handling network requests, specifically for uploading profile images.
- UIKit: Used indirectly through `UIViewControllerRepresentable` to integrate the image picker.

## Getting Started

To run this project locally, follow these steps:

1. Clone this repository to your local machine.
2. Open the project in Xcode.
3. Build and run the project on a simulator or a connected iOS device.

## Usage

- Fill in your profile details on the Profile screen.
- Tap "Let's Get Started" to navigate to the homepage.
- Ensure all required fields, including name, address, password, and profile image, are filled before proceeding.

## Screenshots

- Screenshots of the app can be found inside the project.

## License

This project is licensed under the [MIT License](LICENSE).
