// //My proper working code 10april
// import 'dart:convert';

// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// import 'package:learning_mgt/Utils/learning_colors.dart';
// import 'package:learning_mgt/main.dart';
// import 'package:learning_mgt/provider/LandingScreenProvider.dart';
// import 'package:permission_handler/permission_handler.dart';

// import 'package:provider/provider.dart';

// import 'dart:async';

// import 'package:path_provider/path_provider.dart';
// import 'dart:io';

// import 'package:video_player/video_player.dart';

// class Video {
//   final String url;
//   final String thumbnail;
//   final String title;
//   final String subtitle;
//   final String description;

//   Video({
//     required this.url,
//     required this.thumbnail,
//     required this.title,
//     required this.subtitle,
//     required this.description,
//   });
// }

// class VideoScreen extends StatefulWidget {
//   static const String route = "/videoscreen";
//   final String videoCategory; //Course,Master
//   final String video;
//   final String videoTopicSlug;
//   final String videoCourseSlug;
//   final String videoWatchTime;
//   final bool isTrailer;
//   final String courseID;
//   final String topicID;
//   // final List<particularCourse.Datum> courseDetailList;

//   const VideoScreen({
//     super.key,
//     required this.video,
//     required this.videoTopicSlug,
//     required this.videoCourseSlug,
//     required this.videoWatchTime,
//     this.isTrailer = false,
//     required this.courseID,
//     required this.topicID,
//     required this.videoCategory,
//     // required this.courseDetailList,
//   });

//   @override
//   _VideoScreenState createState() => _VideoScreenState();
// }

// class _VideoScreenState extends State<VideoScreen> with WidgetsBindingObserver {
//   late VideoPlayerController _controller;
//   late Future<void> _initializeVideoPlayerFuture;
//   bool _isFullscreen = false;
//   bool _isPlaying = false;
//   double _currentPosition = 0.0;
//   double _videoDuration = 0.0;
//   bool _hasApiCalled = false;
//   bool _showRefreshIcon = false;
//   Timer? _hideControlsTimer;
//   bool _showControls = true;

//   Map<String, double> videoProgressMap = {};

//   @override
//   void initState() {
//     super.initState();
//     _currentPosition = _parseDuration(widget.videoWatchTime);
//     _initializeVideoPlayerFuture = _initializeController(widget.video);
//     WidgetsBinding.instance.addObserver(this);
//     getPermission();
//     //step1
   
  
//   }
//   getPermission()
//   async {
//      if (Platform.isAndroid) {
//         final androidInfo = await DeviceInfoPlugin().androidInfo;
//         if (androidInfo.version.sdkInt >= 33) {
//           final status = await Permission.notification.request();
//           if (!status.isGranted) {
//             print("Notification permission denied.");
//           }
//         }
//       }
//   }

//   double _parseDuration(String duration) {
//     List<String> parts = duration.split(':');
//     if (parts.length != 3) return 0.0;
//     double hours = double.parse(parts[0]);
//     double minutes = double.parse(parts[1]);
//     double seconds = double.parse(parts[2]);
//     return (hours * 3600) + (minutes * 60) + seconds;
//   }

//   Future<void> _initializeController(String videoUrl) async {
//     _controller = VideoPlayerController.network(videoUrl);
//     await _controller.initialize();
//     _controller.setLooping(false);
//     _controller.seekTo(Duration(seconds: _currentPosition.toInt()));
//     _controller.addListener(_videoPlayerListener);
//     setState(() {
//       _videoDuration = _controller.value.duration.inSeconds.toDouble();
//     });
//   }

//   void _videoPlayerListener() {
//     if (_controller.value.isInitialized) {
//       final position = _controller.value.position;
//       final duration = _controller.value.duration;

//       setState(() {
//         _currentPosition = position.inSeconds.toDouble();
//         _videoDuration = duration.inSeconds.toDouble();
//         _showRefreshIcon = !_controller.value.isPlaying &&
//             position >= duration &&
//             duration.inSeconds > 0;
//       });

//       videoProgressMap[widget.video] = _currentPosition;

//       if (_controller.value.isPlaying &&
//           _currentPosition % 60 == 0 &&
//           _currentPosition > 0) {
//         //  _callWatchTimeAPI();
        
//       }
//     }
//   }

//   String formatWatchTime(String timeString) {
//     final duration = Duration(
//       hours: int.parse(timeString.split(":")[0]),
//       minutes: int.parse(timeString.split(":")[1]),
//       seconds: int.parse(timeString.split(":")[2]),
//     );

//     final totalMinutes =
//         duration.inMinutes.remainder(60).toString().padLeft(2, '0');
//     final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');

//     return "$totalMinutes:$seconds";
//   }


// Future<List<Map<String, dynamic>>> getDownloadedVideoMetadata(String customerId) async {
//     final baseDirectory = await getApplicationDocumentsDirectory();
//     final userDirectory = Directory('${baseDirectory.path}/$customerId');

//     if (!await userDirectory.exists()) return [];

//     final files = userDirectory.listSync();
//     List<Map<String, dynamic>> metadataList = [];

//     for (var file in files) {
//       if (file is File && file.path.endsWith('.json')) {
//         try {
//           final jsonString = await file.readAsString();
//           final metadata = jsonDecode(jsonString);
//           final videoPath = file.path.replaceAll('.json', '.mp4');

//           if (File(videoPath).existsSync()) {
//             metadata['path'] = videoPath;
//             metadataList.add(metadata);
//           }
//         } catch (e) {
//           print('Failed to read metadata from ${file.path}: $e');
//         }
//       }
//     }

//     return metadataList;
//   }
//   Future<bool> isVideoDownloadedByTypeAndId(
//     String customerId, String type, String videoId) async {
//   final metadataList = await getDownloadedVideoMetadata(customerId);
//   return metadataList.any(
//     (metadata) => metadata['type'] == type && metadata['id'] == videoId,
//   );
// }

//   // bool isVideoDownloaded(String videoName) {
//   //   for (var filePath in videoFiles) {
//   //     String fileName =
//   //         path.basename(filePath.path); // Extract only the file name
//   //     if (fileName == "${videoName}.mp4") {
//   //       return true;
//   //     }
//   //   }
//   //   return false;
//   // }

//   List<File> videoFiles = [];
//   // Future<List<File>> getDownloadedVideos() async {
//   //   final directory = await getApplicationDocumentsDirectory();
//   //   final files = Directory(directory.path).listSync();

//   //   // Filter out only video files (by extension, for example, `.mp4`)
//   //   videoFiles = files
//   //       .where((file) => file.path.endsWith('.mp4'))
//   //       .map((file) => File(file.path))
//   //       .toList();

//   //   return videoFiles;
//   // }
// Future<List<File>> getDownloadedVideos(String customerId) async {
//   final baseDirectory = await getApplicationDocumentsDirectory();
//   final userDirectory = Directory('${baseDirectory.path}/$customerId');

//   if (!await userDirectory.exists()) {
//     // Return empty list if user folder doesn't exist
//     return [];
//   }

//   final files = userDirectory.listSync();

//   // Filter and return only `.mp4` files
//   List<File> videoFiles = files
//       .whereType<File>() // Ensure it's a File, not a Directory
//       .where((file) => file.path.endsWith('.mp4'))
//       .toList();

//   return videoFiles;
// }
//   Map<int, double> downloadProgress = {};

// Future<void> downloadVideo(
//   String videoUrl,
//   String fileName,
//   int index,
//   String customerId,
//   String videoId,
//   String type,
// ) async {
//   try {
//     final directory = await getApplicationDocumentsDirectory();
//     final userDirectory = Directory('${directory.path}/$customerId');

//     if (!await userDirectory.exists()) {
//       await userDirectory.create(recursive: true);
//     }

//     final videoPath = '${userDirectory.path}/$fileName.mp4';
//     final metadataPath = '${userDirectory.path}/$fileName.json';

//     Dio dio = Dio();
//     final notificationId = index + 1; // Unique ID for notification

//     await dio.download(
//       videoUrl,
//       videoPath,
//       onReceiveProgress: (received, total) {
//         if (total != -1) {
//           double progress = received / total;

//           setState(() {
//             downloadProgress[index] = progress;
//           });

//           flutterLocalNotificationsPlugin.show(
//             notificationId,
//             'Downloading $fileName',
//             '${(progress * 100).toStringAsFixed(0)}%',
//             NotificationDetails(
//               android: AndroidNotificationDetails(
//                 'download_channel',
//                 'Video Downloads',
//                 channelDescription: 'Download progress',
//                 importance: Importance.low,
//                 priority: Priority.low,
//                 showProgress: true,
//                 maxProgress: 100,
//                 progress: (progress * 100).toInt(),
//                 onlyAlertOnce: true,
//                 ongoing: true,
//               ),
//             ),
//           );
//         }
//       },
//     );

//     // Save metadata
//     final metadata = {
//       'id': videoId,
//       'url': videoUrl,
//       'type': type,
//       'fileName': fileName,
//       'path': videoPath,
//     };
//     await File(metadataPath).writeAsString(jsonEncode(metadata));

//     // Update local state
//     videoFiles.add(File(videoPath));
//     setState(() {
//       downloadProgress[index] = 1.0;
//     });

//     // Cancel the progress notification
//     await flutterLocalNotificationsPlugin.cancel(notificationId);

//     // Show final "Download Complete" notification
//     await flutterLocalNotificationsPlugin.show(
//       notificationId,
//       'Download Complete',
//       '$fileName.mp4 has been downloaded successfully.',
//       NotificationDetails(
//         android: AndroidNotificationDetails(
//           'download_channel',
//           'Video Downloads',
//           channelDescription: 'Notification for completed video downloads',
//           importance: Importance.high,
//           priority: Priority.high,
//           onlyAlertOnce: true,
//           showProgress: false,
//         ),
//       ),
//       payload: 'download_complete',
//     );
//   } catch (e) {
//     print('Download failed: $e');

//     // Show failure notification
//     await flutterLocalNotificationsPlugin.show(
//       0,
//       'Download Failed',
//       '$fileName could not be downloaded.',
//       NotificationDetails(
//         android: AndroidNotificationDetails(
//           'download_channel',
//           'Video Downloads',
//           channelDescription: 'Notification for download errors',
//           importance: Importance.high,
//           priority: Priority.high,
//         ),
//       ),
//     );
//   }
// }

//   String _formatTime(double seconds) {
//     int hours = (seconds / 3600).floor();
//     int mins = ((seconds % 3600) / 60).floor();
//     int secs = (seconds % 60).toInt();
//     return '${hours.toString().padLeft(2, '0')}:${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
//   }

//   Future<bool> _onBackPressed() async {
//     if (_isFullscreen) {
//       setState(() {
//         _isFullscreen = false;
//         SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
//       });
//       return false;
//     } else {
//       //  _callWatchTimeAPI();
      
//       Navigator.pop(context, true);
//       return false;
//     }
//   }

//   void _toggleFullscreen() {
//     setState(() {
//       print("TOGGLE");
//       _isFullscreen = !_isFullscreen;
//     });
//     SystemChrome.setPreferredOrientations(_isFullscreen
//         ? [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]
//         : [DeviceOrientation.portraitUp]);
//     // Rebuild with new orientation
//     // WidgetsBinding.instance.addPostFrameCallback((_) {
//     //   setState(() {});
//     // });
//   }

//   void _toggleControls() {
//     setState(() => _showControls = !_showControls);
//     _resetControlsTimer();
//   }

//   void _resetControlsTimer() {
//     _hideControlsTimer?.cancel();
//     _hideControlsTimer = Timer(
//         Duration(seconds: 5), () => setState(() => _showControls = false));
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     WidgetsBinding.instance.removeObserver(this);
//     _hideControlsTimer?.cancel();
//     super.dispose();
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.paused ||
//         state == AppLifecycleState.detached) {
//          //_callWatchTimeAPI();
       
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final orientation = MediaQuery.of(context).orientation;
//     final double videoHeight = _isFullscreen
//         ? MediaQuery.of(context).size.height
//         : MediaQuery.of(context).size.height * 0.30;

//     return ChangeNotifierProvider(
//       create: (_) => LandingScreenProvider(),
//       child: Consumer<LandingScreenProvider>(
//         builder: (context, provider, _) {
//           return Scaffold(
//             backgroundColor: LearningColors.black18,
//             body: WillPopScope(
//                 onWillPop: _onBackPressed,
//                 child: _isFullscreen
//                     ? videoBlock(videoHeight)
//                     : SafeArea(
//                         child: ListView(
//                         shrinkWrap: true,
//                         physics: ScrollPhysics(),
//                         children: [
//                           videoBlock(videoHeight),
//                           //step2

                          
                         
//                         ],
//                       ))),
//           );
//         },
//       ),
//     );
//   }

//   Widget videoBlock(double videoHeight) {
//     return Stack(
//       children: [
//         Column(
//           children: [
//             GestureDetector(
//               onTap: _toggleControls,
//               child: Container(
//                 width: double.infinity,
//                 height: videoHeight,
//                 color: Colors.black,
//                 child: Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     FutureBuilder(
//                       future: _initializeVideoPlayerFuture,
//                       builder: (context, snapshot) {
//                         if (snapshot.connectionState == ConnectionState.done) {
//                           return AspectRatio(
//                             aspectRatio: _controller.value.aspectRatio,
//                             child: VideoPlayer(_controller),
//                           );
//                         } else {
//                           return Center(child: CircularProgressIndicator());
//                         }
//                       },
//                     ),
//                     if (_showControls) ...[
//                       Positioned(
//                         top: 10,
//                         right: 10,
//                         child: GestureDetector(
//                           onTap: _toggleFullscreen,
//                           child: Container(
//                               width: _isFullscreen ? 100 : 40,
//                               height: _isFullscreen ? 70 : 40,
//                               child:
//                                   Icon(Icons.fullscreen, color: Colors.white)),
//                         ),
//                       ),
//                       _showRefreshIcon
//                           ? IconButton(
//                               icon: Icon(Icons.refresh,
//                                   size: 50, color: Colors.white),
//                               onPressed: () {
//                                 _controller.seekTo(Duration.zero);
//                                 _controller.play();
//                                 setState(() => _isPlaying = true);
//                               },
//                             )
//                           : Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 IconButton(
//                                   icon: Icon(Icons.replay_10,
//                                       size: 40, color: Colors.white),
//                                   onPressed: () => _controller.seekTo(Duration(
//                                       seconds: (_currentPosition - 10)
//                                           .clamp(0, _videoDuration)
//                                           .toInt())),
//                                 ),
//                                 IconButton(
//                                   icon: Icon(
//                                       _isPlaying
//                                           ? Icons.pause
//                                           : Icons.play_arrow,
//                                       size: 50,
//                                       color: Colors.white),
//                                   onPressed: () {
//                                     setState(() {
//                                       if (_isPlaying) {
//                                         _controller.pause();
//                                       } else {
//                                         _controller.play();
//                                       }
//                                       _isPlaying = !_isPlaying;
//                                     });
//                                   },
//                                 ),
//                                 IconButton(
//                                   icon: Icon(Icons.forward_10,
//                                       size: 40, color: Colors.white),
//                                   onPressed: () => _controller.seekTo(Duration(
//                                       seconds: (_currentPosition + 10)
//                                           .clamp(0, _videoDuration)
//                                           .toInt())),
//                                 ),
//                               ],
//                             ),
//                       Positioned(
//                         bottom: 10,
//                         left: 16,
//                         right: 16,
//                         child: Row(
//                           children: [
//                             Text(_formatTime(_currentPosition),
//                                 style: TextStyle(color: Colors.white)),
//                             Expanded(
//                               child: Slider(
//                                 value:
//                                     _currentPosition.clamp(0.0, _videoDuration),
//                                 min: 0,
//                                 max: _videoDuration > 0 ? _videoDuration : 1,
//                                 onChanged: (value) {
//                                   _controller
//                                       .seekTo(Duration(seconds: value.toInt()));
//                                   setState(() => _currentPosition = value);
//                                 },
//                               ),
//                             ),
//                             Text(_formatTime(_videoDuration),
//                                 style: TextStyle(color: Colors.white)),
//                           ],
//                         ),
//                       )
//                     ]
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ],
//     );
//   }
// }
