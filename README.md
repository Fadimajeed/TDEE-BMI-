# Smart BMI Calculator

## Project Overview

This is a Flutter-based mobile application designed to accurately calculate Body Mass Index (BMI) and Total Daily Energy Expenditure (TDEE). It provides users with personalized health advice based on their input, helping them understand their current health status and offering guidance on weight management and healthy lifestyle choices.

## Features

*   **Intuitive User Interface:** Clean and modern design with easy-to-use input fields for gender, age, height, and weight.
*   **Interactive Input Widgets:** Custom-built widgets for age selection and height/weight input, providing a smooth and engaging user experience.
*   **Gender Toggle:** Seamless selection between male and female for accurate calculations.
*   **BMI Calculation:** Calculates BMI based on standard formulas.
*   **TDEE Calculation:** Computes Total Daily Energy Expenditure using the Mifflin-St Jeor equation, considering age, gender, weight, height, and exercise level.
*   **Personalized Health Advice:** Generates dynamic advice and tips based on calculated BMI and TDEE, categorized for underweight, healthy weight, overweight, and obese individuals.
*   **Visual BMI Indicator:** A color-coded bar visually represents BMI categories (Underweight, Healthy Weight, Obese).
*   **Responsive Design:** The application UI adapts to different screen sizes, ensuring a consistent experience across various devices.
*   **Clean Code Architecture:** Organized codebase with modular components for maintainability and scalability.

## Technologies Used

*   **Flutter SDK:** For cross-platform mobile application development.
*   **Dart Language:** The programming language used for building the application.
*   **Material Design & Cupertino Widgets:** Adherence to modern UI/UX principles for a visually appealing and user-friendly interface.

## Getting Started

To get a local copy up and running, follow these simple steps.

### Prerequisites

Make sure you have Flutter installed on your machine. If not, follow the official Flutter installation guide: [https://flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install)

### Installation

1.  Clone the repository:
    ```bash
    git clone https://github.com/Fadimajeed/TDEE-BMI-.git
    ```
2.  Navigate to the project directory:
    ```bash
    cd smart_bmi_calculator
    ```
3.  Get Flutter packages:
    ```bash
    flutter pub get
    ```
4.  Run the application:
    ```bash
    flutter run
    ```

## Project Structure

```
lib/
├── main.dart
├── Screens/
│   ├── First_screen.dart
│   ├── Mainscreen.dart
│   └── Resultscreen.dart
└── Extras/
    ├── Age.dart
    ├── Bmi_color.dart
    ├── Exercise_level.dart
    ├── height_weidth.dart
    └── Text_after_result.dart
```

## State Management

This project primarily utilizes Flutter's built-in **`StatefulWidget`** and **`setState()`** for local state management. The core application state is managed within the `Mainscreen` widget, which then passes data down to child widgets via constructor parameters. Child widgets communicate updates back to their parent using **callback functions**, demonstrating the 


common **"Lifting State Up"** pattern. This approach is effective for small to medium-sized applications, providing clear data flow and maintainability without external state management libraries.

## Screenshots

![BMI App - First Screen](https://github.com/Fadimajeed/TDEE-BMI-/blob/main/BMI_TDEE-app-images/Screenshot_1751326952.png?raw=true)
![BMI App - Main Screen](https://github.com/Fadimajeed/TDEE-BMI-/blob/main/BMI_TDEE-app-images/Screenshot_1751326961.png?raw=true)
![BMI App - Age Input](https://github.com/Fadimajeed/TDEE-BMI-/blob/main/BMI_TDEE-app-images/Screenshot_1751357588.png?raw=true)
![BMI App - Exercise Level](https://github.com/Fadimajeed/TDEE-BMI-/blob/main/BMI_TDEE-app-images/Screenshot_1751357596.png?raw=true)
![BMI App - Result Screen](https://github.com/Fadimajeed/TDEE-BMI-/blob/main/BMI_TDEE-app-images/Screenshot_1751326988.png?raw=true)
![BMI App - Result Advice](https://github.com/Fadimajeed/TDEE-BMI-/blob/main/BMI_TDEE-app-images/Screenshot_1751326990.png?raw=true)

## License

This project is licensed under the MIT License - see the LICENSE.md file for details.

## Note 
if the app does not work , try changing the path name from "smart_bmi_calculator" to "bad"


