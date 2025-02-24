Driver Behavior Prediction App
Flutter
TensorFlow

This Flutter app uses smartphone sensor data (accelerometer, gyroscope, and GPS) to predict driver behavior in real-time. The app leverages a CNN-LSTM deep learning model to classify driving patterns such as aggressive driving, normal driving, and distracted driving.

Features
Real-Time Sensor Data Collection: Collects accelerometer, gyroscope, and GPS data from the smartphone.

Driver Behavior Prediction: Predicts driver behavior using a pre-trained CNN-LSTM model.

User-Friendly Interface: Displays real-time predictions and driving insights.

Data Logging: Logs sensor data and predictions for further analysis.

Customizable Model: Allows integration of new models or retraining of the existing model.

How It Works
Data Collection: The app collects sensor data (accelerometer, gyroscope, and GPS) from the smartphone.

Preprocessing: The raw sensor data is preprocessed and fed into the CNN-LSTM model.

Model Inference: The CNN-LSTM model predicts the driver's behavior (e.g., aggressive, normal, or distracted).

Real-Time Feedback: The app displays the predicted behavior and provides feedback to the user.

Model Architecture
The deep learning model consists of a Convolutional Neural Network (CNN) for feature extraction and a Long Short-Term Memory (LSTM) network for sequence modeling. The model is trained on a dataset of labeled sensor data to classify driver behavior.

Model Pipeline:
Input: Raw sensor data (time-series).

CNN: Extracts spatial features from the sensor data.

LSTM: Captures temporal dependencies in the data.

Output: Predicted driver behavior class (e.g., aggressive, normal, distracted).

Installation
Prerequisites
Flutter SDK (version 3.0 or higher)

TensorFlow Lite (for model inference)

Android/iOS device with sensors (accelerometer, gyroscope, GPS)

Steps to Run the App
Clone the repository:

bash
Copy
git clone https://github.com/jishnucr07/driver-guard-flutter.git
Navigate to the project directory:

bash
Copy
cd driver-guard-flutter
Install dependencies:

bash
Copy
flutter pub get
Run the app:

bash
Copy
flutter run
Usage
Open the app on your smartphone.

Grant permissions for accessing sensors (accelerometer, gyroscope, GPS).

Start driving. The app will collect sensor data and predict your driving behavior in real-time.

View the predictions and insights on the app's dashboard.

Dataset
The model is trained on a publicly available dataset of driver behavior, which includes labeled sensor data for various driving patterns. You can find the dataset on the drive-guard-ml repo

Model Training
To train or retrain the CNN-LSTM model:

Preprocess the sensor data.

Train the model using TensorFlow or PyTorch.

Convert the trained model to TensorFlow Lite for integration with the Flutter app.

For detailed instructions, refer to the Model Training Guide (replace with a link to your training guide).

Screenshots
Home Screen	Real-Time Prediction	Insights Dashboard
Home Screen	Real-Time Prediction	Insights Dashboard
Contributing
Contributions are welcome! If you'd like to contribute, please follow these steps:

Fork the repository.

Create a new branch (git checkout -b feature/YourFeatureName).

Commit your changes (git commit -m 'Add some feature').

Push to the branch (git push origin feature/YourFeatureName).

Open a pull request.

License
This project is licensed under the MIT License. See the LICENSE file for details.

Acknowledgments
Thanks to the Flutter and TensorFlow communities for their amazing tools and libraries.

Special thanks to Dataset Provider for providing the driver behavior dataset.

Contact
For questions or feedback, feel free to reach out:

Jishnu C R

Email: jishnucr07@gmail.com

GitHub: jishnucr07
