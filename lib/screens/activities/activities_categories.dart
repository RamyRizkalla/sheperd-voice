import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shepherd_voice/global/constants/color_constants.dart';
import 'package:shepherd_voice/models/film_response.dart';
import 'package:shepherd_voice/models/module.dart';
import 'package:shepherd_voice/screens/films/film_player.dart';

import '../../global/constants/image_constants.dart';
import '../../network/api_client.dart';
import '../shared/categories/category_widget.dart';

class ActivitiesCategoriesScreen extends StatefulWidget {
  const ActivitiesCategoriesScreen({super.key});

  @override
  State<ActivitiesCategoriesScreen> createState() =>
      _ActivitiesCategoriesScreenState();
}

class _ActivitiesCategoriesScreenState
    extends State<ActivitiesCategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    // return const Placeholder();
    return CategoryWidget(
      icon: Images.musicIcon,
      headerImage: Images.musicHeader,
      headerTitle: AppLocalizations.of(context)!.musicTitle,
      crossAxisCount: 1,
      apiCall: ({required page}) {
        return APIClient.shared.getCategories(module: Module.activity);
      },
      themeColor: ColorConstants.turquoise,
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
