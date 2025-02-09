# Bluetooth Data Receiver

Bluetooth Data Receiver is a Flutter application designed to receive data from Bluetooth devices. This app demonstrates how to connect to a Bluetooth device, receive data, and display it in a user-friendly interface.

## Features

- Connect to bonded Bluetooth devices
- Receive and display data from the connected device
- Reconnect to the device if the connection is lost

## Getting Started

### Prerequisites

- Flutter SDK
- Dart SDK
- A Bluetooth-enabled device

### Installation

1. Clone the repository:
    ```sh
    git clone https://github.com/yourusername/Bluetooth-Data-Receiver.git
    ```
2. Navigate to the project directory:
    ```sh
    cd Bluetooth-Data-Receiver
    ```
3. Install the dependencies:
    ```sh
    flutter pub get
    ```

### Running the App

1. Connect your mobile device or start an emulator.
2. Run the app:
    ```sh
    flutter run
    ```

## Usage

1. Open the app on your device.
2. Select a bonded Bluetooth device from the list.
3. The app will connect to the selected device and start receiving data.
4. The received data will be displayed on the screen.

## Code Overview

The main components of the app are:

- `BluetoothDataApp`: The main application widget.
- `BluetoothDataScreen`: The screen that handles Bluetooth connection and data display.
- `initializeBluetooth()`: Initializes the Bluetooth connection and listens for incoming data.
- `selectBluetoothDevice()`: Displays a dialog to select a bonded Bluetooth device.

## Dependencies

- `flutter_bluetooth_serial`: A Flutter plugin for Bluetooth serial communication.


## Acknowledgements

- Flutter team for the amazing framework
- Contributors of `flutter_bluetooth_serial` plugin

For more information, visit the [official Flutter documentation](https://flutter.dev/docs).

