import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../global/extensions/text_style_ext.dart';

class FilmPlayer extends StatefulWidget {
  final String youtubeLink;
  final String title;

  const FilmPlayer({super.key, required this.youtubeLink, required this.title});

  @override
  State<FilmPlayer> createState() => _FilmPlayerState();
}

class _FilmPlayerState extends State<FilmPlayer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.youtubeLink)!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
        if (orientation == Orientation.landscape) {
          return Scaffold(
            body: youtubeHierarchy(),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
            ),
            body: youtubeHierarchy(),
          );
        }
      }),
    );
  }

  youtubeHierarchy() {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
      ),
      builder: (context, player) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.filmHint,
              textAlign: TextAlign.start,
              style: TextStyleExt.scheherazadeNew(
                textStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                ), // fromHeight use double.infinity as width and 40 is the height
              ),
              onPressed: () => _navigateToYoutube(),
              child: Text(
                widget.title,
                textAlign: TextAlign.start,
                style: TextStyleExt.scheherazadeNew(
                  textStyle: const TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            player,
            //some other widgets
          ],
        );
      },
    );
  }

  _navigateToYoutube() async {
    final url = Uri.parse(widget.youtubeLink);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}
