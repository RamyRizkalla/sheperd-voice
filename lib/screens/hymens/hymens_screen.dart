import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shepherd_voice/global/constants/color_constants.dart';
import 'package:shepherd_voice/models/item_response.dart';
import 'package:shepherd_voice/models/module_name.dart';
import 'package:shepherd_voice/screens/films/film_player.dart';
import 'package:shepherd_voice/screens/shared/details_screen.dart';

import '../../global/constants/image_constants.dart';
import '../../network/api_client.dart';

class HymensScreen extends StatefulWidget {
  const HymensScreen({super.key});

  @override
  State<HymensScreen> createState() => _HymensScreenState();
}

class _HymensScreenState extends State<HymensScreen> {
  @override
  Widget build(BuildContext context) {
    return DetailsWidget(
      module: ModuleName.song,
      icon: Images.musicIcon,
      headerImage: Images.musicHeader,
      headerTitle: AppLocalizations.of(context)!.musicTitle,
      apiCall: ({required page}) {
        return APIClient.shared.getHymens(page: page);
      },
      themeColor: ColorConstants.turquoise,
      onPressed: (item) {
        ItemResponse film = item as ItemResponse;
        Future.delayed(Duration.zero, () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              fullscreenDialog: true,
              builder: (context) => FilmPlayer(
                youtubeLink: film.youtubeLink!,
                title: film.title,
              ),
            ),
          );
        });
      },
    );
  }
}
