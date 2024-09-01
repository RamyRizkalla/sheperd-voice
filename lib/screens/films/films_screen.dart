import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shepherd_voice/global/constants/color_constants.dart';
import 'package:shepherd_voice/models/film_response.dart';
import 'package:shepherd_voice/models/module.dart';
import 'package:shepherd_voice/screens/films/film_player.dart';
import 'package:shepherd_voice/screens/shared/details_screen.dart';

import '../../global/constants/image_constants.dart';
import '../../network/api_client.dart';

class FilmsScreen extends StatefulWidget {
  const FilmsScreen({super.key});

  @override
  State<FilmsScreen> createState() => _FilmsScreenState();
}

class _FilmsScreenState extends State<FilmsScreen> {
  @override
  Widget build(BuildContext context) {
    return DetailsWidget(
      module: Module.song,
      icon: Images.filmsIcon,
      headerImage: Images.filmsHeader,
      headerTitle: AppLocalizations.of(context)!.filmsTitle,
      apiCall: ({required page}) {
        return APIClient.shared.getMovies(page: page);
      },
      themeColor: ColorConstants.purple,
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
