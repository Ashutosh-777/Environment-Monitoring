# IoT-Based Environmental Monitoring System

## Overview

[Report](https://github.com/Ashutosh-777/Environment-Monitoring/blob/master/Design%20Lab%20Report_Group%207.pdf)

This project is an **IoT-based environmental monitoring system** designed to continuously assess and provide real-time data on air, water, and soil quality. The system leverages various sensors integrated with a NodeMCU microcontroller and utilizes the ThingSpeak cloud platform for data storage, processing, and visualization. A mobile application built with Flutter allows users to remotely monitor environmental conditions and receive alerts based on predefined thresholds.

## Features

- **Real-Time Environmental Monitoring**: Collects data on air quality (CO2, humidity, temperature), water quality (temperature, total dissolved solids), and soil moisture.
- **Remote Access and Control**: Users can monitor environmental data remotely via a mobile application.
- **Data Storage and Visualization**: Uses ThingSpeak cloud platform to store and visualize data, providing insightful graphical representations.
- **Alerts and Notifications**: The mobile app provides real-time alerts based on environmental conditions to help users take immediate action.

## Components Used

### Hardware

- **NodeMCU (ESP32/ESP8266)**: An open-source IoT platform that serves as the primary microcontroller for the system.
- **DHT11 Sensor**: Measures temperature and humidity in the air.
- **MQ135 Sensor**: Detects levels of various harmful gases (e.g., CO2, NH4).
- **DS18B20 Sensor**: Measures water temperature.
- **TDS Sensor**: Determines the total dissolved solids in water.
- **Soil Moisture Sensor**: Assesses soil moisture levels to monitor soil health.
- **Additional Components**: Breadboard, jumper wires, power supply, etc.

### Software

- **Arduino IDE**: Used for programming the NodeMCU with the necessary sensor data collection and transmission code.
- **Flutter**: A cross-platform mobile app framework used to develop the mobile application for remote monitoring and alert notifications.
- **ThingSpeak**: An IoT analytics platform service for aggregating, visualizing, and analyzing live data streams in the cloud.

## Repository Contents

- **Arduino Code**: Located in the `arduino` directory, this code handles data collection from various sensors and communication with the ThingSpeak platform.
- **Flutter Mobile App Code**: Found in the `flutter_app` directory, this code is for the mobile application that displays real-time environmental data and sends alerts.
- **Design Lab Report**: A comprehensive report (`Design Lab Report_Group 7.pdf`) detailing the project's design, implementation, results, and future scope.

## Getting Started

### Prerequisites

- **Hardware**: Ensure you have all the sensors, NodeMCU, and other components set up as per the circuit design.
- **Software**: Install the Arduino IDE for microcontroller programming and Flutter SDK for mobile app development.

### Setup

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/Ashutosh-777/Environment-Monitoring.git
   cd Environment-Monitoring
   ```

2. **Arduino Setup**:
   - Open the `arduino/Design Lab.ino` file in the Arduino IDE.
   - Connect the NodeMCU to your computer via USB.
   - Select the appropriate board and port from the Arduino IDE.
   - Upload the code to the NodeMCU.

3. **Flutter Mobile App Setup**:
   - Navigate to the `flutter_app` directory.
   - Run `flutter pub get` to install dependencies.
   - Use `flutter run` to launch the app on an emulator or connected device.

### Usage

- **Arduino**: Once the Arduino code is running on the NodeMCU, it will begin collecting data from the sensors and uploading it to the ThingSpeak platform.
- **Flutter App**: The mobile app will fetch the real-time data from ThingSpeak and display it in a user-friendly interface, providing alerts based on environmental thresholds.

## Results and Discussion

- The system successfully demonstrated real-time monitoring of environmental conditions.
- The results include data visualizations for air quality, water quality, and soil moisture levels, which are available in the ThingSpeak dashboard and the mobile app.
- The full discussion, analysis, and future scope of this project are detailed in the **Design Lab Report** included in this repository.

## Future Improvements

- **Machine Learning Integration**: Train ML models using collected data for predictive analytics and early warnings.
- **Extended Sensor Support**: Add more sensors for comprehensive environmental monitoring.
- **Improved UI/UX**: Enhance the mobile app interface for better user experience and additional functionalities.

## Contributing

Contributions are welcome! Please fork this repository and submit a pull request for any enhancements or bug fixes.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

Special thanks to Prof. Shaik Rafi Ahamed and the Department of Electronics and Electrical Engineering at IIT Guwahati for their guidance and support.
