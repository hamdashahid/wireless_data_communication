import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

void main() => runApp(BluetoothDataApp());

class BluetoothDataApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bluetooth Data Receiver',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: BluetoothDataScreen(),
    );
  }
}

class BluetoothDataScreen extends StatefulWidget {
  @override
  _BluetoothDataScreenState createState() => _BluetoothDataScreenState();
}

class _BluetoothDataScreenState extends State<BluetoothDataScreen> {
  String receivedData = "No Data Yet";
  BluetoothConnection? connection;
  bool isConnecting = true;
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    initializeBluetooth();
  }

  void initializeBluetooth() async {
    try {
      BluetoothDevice? selectedDevice = await selectBluetoothDevice();
      if (selectedDevice != null) {
        BluetoothConnection.toAddress(selectedDevice.address).then((_connection) {
          setState(() {
            connection = _connection;
            isConnecting = false;
            isConnected = true;
          });

          connection!.input!.listen((data) {
            setState(() {
              receivedData = String.fromCharCodes(data);
            });
          }).onDone(() {
            setState(() {
              isConnected = false;
            });
          });
        });
      }
    } catch (e) {
      setState(() {
        isConnecting = false;
      });
    }
  }

  Future<BluetoothDevice?> selectBluetoothDevice() async {
    var devices = await FlutterBluetoothSerial.instance.getBondedDevices();
    return showDialog<BluetoothDevice>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Bluetooth Device"),
          content: SizedBox(
            width: double.maxFinite,
            height: 200,
            child: ListView(
              children: devices
                  .map((device) => ListTile(
                        title: Text(device.name ?? "Unknown Device"),
                        subtitle: Text(device.address),
                        onTap: () => Navigator.of(context).pop(device),
                      ))
                  .toList(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bluetooth Data Receiver"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Received Data:",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueAccent),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                receivedData,
                style: TextStyle(fontSize: 18, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: isConnected ? null : initializeBluetooth,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Text(isConnected ? "Connected" : "Reconnect"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    connection?.dispose();
    super.dispose();
  }
}
