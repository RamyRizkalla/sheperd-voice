import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shepherd_voice/models/film_response.dart';

import '../../network/api_client.dart';

class ImagePreviewer extends StatefulWidget {
  final FilmResponse item;

  const ImagePreviewer({super.key, required this.item});

  @override
  _ImagePreviewerState createState() => _ImagePreviewerState();
}

class _ImagePreviewerState extends State<ImagePreviewer> {
  String urlPath = "";
  bool exists = true;
  bool pdfReady = false;
  late PDFViewController _pdfViewController;
  bool loaded = false;
  ValueNotifier downloadProgressNotifier = ValueNotifier(0);
  CancelToken cancelToken = CancelToken();

  @override
  void dispose() {
    cancelToken.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.title),
      ),
      body: PhotoView(
        imageProvider: CachedNetworkImageProvider(
            APIClient.shared.downloadPath(id: widget.item.id)),
      ),
    );
  }
}
