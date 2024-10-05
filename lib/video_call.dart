// import 'package:flutter/material.dart';
// import 'package:zego_express_engine/zego_express_engine.dart';
//
// class VideoCallPage extends StatefulWidget {
//   final String userID;
//   final String roomID;
//
//   VideoCallPage({required this.userID, required this.roomID});
//
//   @override
//   _VideoCallPageState createState() => _VideoCallPageState();
// }
//
// class _VideoCallPageState extends State<VideoCallPage> {
//   late ZegoExpressEngine _zegoExpressEngine;
//   late List<String> _remoteUserIDs = [];
//   bool _isCameraOn = true;
//   bool _isMicrophoneOn = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeZego();
//   }
//
//   Future<void> _initializeZego() async {
//     _zegoExpressEngine = ZegoExpressEngine.create(
//       appID: 123456789, // Replace with your App ID
//       appSign: "YOUR_APP_SIGN", // Replace with your App Sign
//     );
//
//     _zegoExpressEngine.setEventHandler(ZegoEventHandler(
//       onRoomUserUpdate: (roomID, userList) {
//         setState(() {
//           _remoteUserIDs = userList.map((user) => user.userID).toList();
//         });
//       },
//       onRemoteVideoStateUpdate: (userID, state, _) {
//         if (state == ZegoRemoteVideoState.Stopped) {
//           setState(() {
//             _remoteUserIDs.remove(userID);
//           });
//         }
//       },
//     ));
//
//     final user = ZegoUser(id: widget.userID);
//     await _zegoExpressEngine.loginRoom(widget.roomID, user);
//     await _zegoExpressEngine.startPreview();
//     await _startCall();
//   }
//
//   Future<void> _startCall() async {
//     await _zegoExpressEngine.startPublishingStream(widget.userID);
//   }
//
//   Future<void> _endCall() async {
//     await _zegoExpressEngine.stopPublishingStream();
//     await _zegoExpressEngine.logoutRoom(widget.roomID);
//     Navigator.pop(context);
//   }
//
//   Future<void> _toggleCamera() async {
//     _isCameraOn = !_isCameraOn;
//     await _zegoExpressEngine.enableCamera(_isCameraOn);
//     setState(() {});
//   }
//
//   Future<void> _toggleMicrophone() async {
//     _isMicrophoneOn = !_isMicrophoneOn;
//     await _zegoExpressEngine.muteMicrophone(!_isMicrophoneOn);
//     setState(() {});
//   }
//
//   @override
//   void dispose() {
//     _endCall();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Video Call'),
//         actions: [
//           IconButton(
//             icon: Icon(_isMicrophoneOn ? Icons.mic : Icons.mic_off),
//             onPressed: _toggleMicrophone,
//           ),
//           IconButton(
//             icon: Icon(_isCameraOn ? Icons.videocam : Icons.videocam_off),
//             onPressed: _toggleCamera,
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Container(
//               decoration: BoxDecoration(color: Colors.black),
//               child: ZegoVideoView(
//                 userID: widget.userID,
//                 mode: ZegoVideoViewMode.Local, // Local view for the user
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: _remoteUserIDs.length,
//               itemBuilder: (context, index) {
//                 return Container(
//                   height: 120,
//                   color: Colors.black,
//                   child: ZegoVideoView(
//                     userID: _remoteUserIDs[index],
//                     mode: ZegoVideoViewMode.Remote, // Remote view for other users
//                   ),
//                 );
//               },
//             ),
//           ),
//           ElevatedButton(
//             onPressed: _endCall,
//             child: Text('End Call'),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _startCall,
//         child: Icon(Icons.call),
//       ),
//     );
//   }
// }
//
// class ZegoVideoView extends StatelessWidget {
//   final String userID;
//   final ZegoVideoViewMode mode;
//
//   const ZegoVideoView({
//     Key? key,
//     required this.userID,
//     required this.mode,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ZegoExpressEngine.createVideoView(
//       userID: userID,
//       mode: mode,
//       onViewCreated: (viewID) {
//         ZegoExpressEngine.instance.setVideoView(viewID, userID);
//       },
//     );
//   }
// }
