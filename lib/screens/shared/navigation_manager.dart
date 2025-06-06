import 'package:flutter/material.dart';
import 'package:shepherd_voice/models/item_response.dart';
import 'package:shepherd_voice/screens/shared/pdf_viewer.dart';

import '../../main.dart';
import '../films/film_player.dart';
import 'image_previewer.dart';

class NavigationManager {
  static void navigate({required ItemResponse item}) {
    switch (item.itemType) {
      case 'film':
      case 'song':
        _push((context) => FilmPlayer(
              youtubeLink: item.youtubeLink!,
              title: item.title,
            ));
        break;
      case 'book':
        _push((context) => PDFViewer(item: item));
        break;
      case 'activity':
        _push((context) => ImagePreviewer(item: item));
        break;
      default:
        break;
    }
  }

  static void _push(WidgetBuilder builder) {
    Navigator.push(
      globalContext,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: builder,
      ),
    );
  }
}
