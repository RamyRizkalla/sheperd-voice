import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shepherd_voice/models/item_response.dart';
import 'package:shepherd_voice/network/api_client.dart';

import '../../global/constants/color_constants.dart';

class PDFViewer extends StatefulWidget {
  final ItemResponse item;

  const PDFViewer({super.key, required this.item});

  @override
  _PDFViewerState createState() => _PDFViewerState();
}

class _PDFViewerState extends State<PDFViewer> {
  String urlPDFPath = "";
  bool exists = true;
  bool pdfReady = false;
  late PDFViewController _pdfViewController;
  bool loaded = false;
  ValueNotifier downloadProgressNotifier = ValueNotifier(0);
  CancelToken cancelToken = CancelToken();

  String get itemTitle =>
      '${widget.item.id}_${widget.item.title}_${widget.item.updatedAtDate.millisecondsSinceEpoch}';

  void requestPersmission() async {
    await Permission.storage.status;
  }

  Future<Directory?> requestDirectory() async {
    if (Platform.isAndroid) {
      return getDownloadsDirectory();
    } else {
      return getApplicationDocumentsDirectory();
    }
  }

  void downloadFileFromServer() async {
    downloadProgressNotifier.value = 0;
    Directory directory = await requestDirectory() ?? Directory("");

    String localFilePath = '${directory.path}/$itemTitle.pdf';
    await Dio().download(
      APIClient.shared.downloadPath(id: widget.item.id),
      localFilePath,
      onReceiveProgress: (actualBytes, int totalBytes) {
        downloadProgressNotifier.value =
            (actualBytes / totalBytes * 100).floor();
      },
      cancelToken: cancelToken,
    );
    setState(() {
      urlPDFPath = localFilePath;
      loaded = true;
      exists = true;
    });
  }

  @override
  void initState() {
    requestPersmission();

    localFilePath().then((value) {
      if (File(value).existsSync()) {
        setState(() {
          urlPDFPath = value;
          loaded = true;
          exists = true;
        });
      } else {
        downloadFileFromServer();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    cancelToken.cancel();
    super.dispose();
  }

  Future<String> localFilePath() async {
    Directory directory = await requestDirectory() ?? Directory("");

    return '${directory.path}/$itemTitle.pdf';
  }

  @override
  Widget build(BuildContext context) {
    if (loaded) {
      return buildPdfView(context);
    } else {
      if (exists) {
        return buildProgressView(context);
      } else {
        //Replace Error UI
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.item.title),
          ),
          body: const Text(
            "PDF Not Available",
            style: TextStyle(fontSize: 20),
          ),
        );
      }
    }
  }

  Widget buildPdfView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => _onShareWithResult(context),
          ),
        ],
      ),
      body: PDFView(
        filePath: urlPDFPath,
        autoSpacing: true,
        enableSwipe: true,
        nightMode: false,
        onViewCreated: (PDFViewController vc) {
          setState(() {
            _pdfViewController = vc;
          });
        },
      ),
    );
  }

  Widget buildProgressView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.item.title)),
      body: Center(
        child: ValueListenableBuilder(
          valueListenable: downloadProgressNotifier,
          builder: (context, value, snapshot) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularPercentIndicator(
                  radius: 50.0,
                  lineWidth: 10.0,
                  // animation: true,
                  percent: downloadProgressNotifier.value / 100,
                  center: Text(
                    "${downloadProgressNotifier.value}%",
                    style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  backgroundColor: Colors.grey.shade300,
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: ColorConstants.yellow,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _onShareWithResult(BuildContext context) async {
    final result =
        await Share.shareXFiles([XFile(urlPDFPath)], text: widget.item.title);

    if (result.status == ShareResultStatus.success) {
      print('Thank you for sharing the picture!');
    }
  }
}
