import 'dart:io';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:video_player/video_player.dart';
import '../Utils/learning_colors.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerScreen({super.key, required this.videoUrl});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {
          _chewieController = ChewieController(
            videoPlayerController: _videoPlayerController,
            autoPlay: true,
            looping: false,
          );
        });
      });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LearningColors.black,
      appBar: AppBar(backgroundColor: LearningColors.black, elevation: 0, iconTheme: const IconThemeData(color: Colors.white),),
      body: _chewieController != null && _chewieController!.videoPlayerController.value.isInitialized
          ? Chewie(controller: _chewieController!)
          : const Center(
        child: CircularProgressIndicator(color: LearningColors.darkBlue),
      ),
    );
  }
}

class ImagePreviewScreen extends StatelessWidget {
  final String imageUrl;

  const ImagePreviewScreen({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LearningColors.black,
      appBar: AppBar(backgroundColor: LearningColors.black, elevation: 0, iconTheme: const IconThemeData(color: Colors.white),),
      body: Center(
        child: Image.network(imageUrl, fit: BoxFit.contain),
      ),
    );
  }
}

class PdfViewerScreen extends StatelessWidget {
  final String pdfUrl;

  const PdfViewerScreen({super.key, required this.pdfUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LearningColors.black,
      appBar: AppBar(backgroundColor: LearningColors.black, elevation: 0, iconTheme: const IconThemeData(color: Colors.white),),
      body: SfPdfViewer.network(pdfUrl),
    );
  }
}

class ExcelViewerScreen extends StatelessWidget {
  final File excelFile;

  const ExcelViewerScreen({super.key, required this.excelFile});

  @override
  Widget build(BuildContext context) {
    final excel = Excel.decodeBytes(excelFile.readAsBytesSync());
    final Sheet sheet = excel.tables.values.first;

    return Scaffold(
      backgroundColor: LearningColors.black,
      appBar: AppBar(backgroundColor: LearningColors.black, elevation: 0, iconTheme: const IconThemeData(color: Colors.white),),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: sheet.rows.first
              .map((cell) => DataColumn(label: Text(cell?.value.toString() ?? '', style: const TextStyle(color: Colors.white))))
              .toList(),
          rows: sheet.rows.skip(1).map((row) {
            return DataRow(
              cells: row
                  .map((cell) => DataCell(Text(cell?.value.toString() ?? '', style: const TextStyle(color: Colors.white))))
                  .toList(),
            );
          }).toList(),
        ),
      ),
    );
  }
}
