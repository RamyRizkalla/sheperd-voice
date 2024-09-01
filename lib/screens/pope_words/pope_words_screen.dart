import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shepherd_voice/global/constants/color_constants.dart';
import 'package:shepherd_voice/models/film_response.dart';
import 'package:shepherd_voice/models/module.dart';
import 'package:shepherd_voice/screens/films/film_player.dart';
import 'package:shepherd_voice/screens/shared/details_screen.dart';

import '../../global/constants/image_constants.dart';
import '../../network/api_client.dart';

class PopeWordsScreen extends StatefulWidget {
  const PopeWordsScreen({super.key});

  @override
  State<PopeWordsScreen> createState() => _PopeWordsScreenState();
}

class _PopeWordsScreenState extends State<PopeWordsScreen> {
  @override
  Widget build(BuildContext context) {
    return DetailsWidget(
      module: Module.popeWord,
      icon: Images.popeIcon,
      headerImage: Images.popeHeader,
      headerTitle: AppLocalizations.of(context)!.popeTitle,
      apiCall: ({required page}) {
        return APIClient.shared.getPopeWords(page: page);
      },
      themeColor: ColorConstants.red,
      onPressed: (item) {
        FilmResponse film = item as FilmResponse;
        Future.delayed(Duration.zero, () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              fullscreenDialog: true,
              builder: (context) => FilmPlayer(youtubeLink: film.youtubeLink),
            ),
          );
        });
      },
    );
  }
}
