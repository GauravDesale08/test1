import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zego Video Call',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String appID = '1543974590';  // Replace with your Zego Cloud App ID
  final String appSign = '1aa7cc4df5028140b157eb63446a72eb8d273ba3786fc15183f2a9cdb2b4e11b';  // Replace with your App Sign

  final TextEditingController _callIDController = TextEditingController();
  String userID = 'user_${DateTime.now().millisecondsSinceEpoch}'; // Generate a unique user ID

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Enter Call ID',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _callIDController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'Call ID',
                hintText: 'Enter the call ID',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final callID = _callIDController.text.trim();
                if (callID.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CallPage(
                        appID: appID,
                        appSign: appSign,
                        userID: userID,
                        callID: callID,
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter a call ID')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 40,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Start Call'),
            ),
          ],
        ),
      ),
    );
  }
}

class CallPage extends StatelessWidget {
  final String appID;
  final String appSign;
  final String userID;
  final String callID;

  const CallPage({
    Key? key,
    required this.appID,
    required this.appSign,
    required this.userID,
    required this.callID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ZegoUIKitPrebuiltCall(
          appID: int.parse(appID),  // Your Zego App ID
          appSign: appSign,  // Your Zego App Sign
          userID: userID,  // Unique user ID for this session
          userName: 'User $userID',  // Display name
          callID: callID,  // Unique call ID for the room
          config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
        ),
      ),
    );
  }
}
