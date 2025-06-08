import 'package:flutter/cupertino.dart';
import 'package:shepherd_voice/l10n/app_localizations.dart';
import 'package:shepherd_voice/global/constants/color_constants.dart';
import 'package:shepherd_voice/models/category_response.dart';
import 'package:shepherd_voice/models/item_response.dart';
import 'package:shepherd_voice/models/module_name.dart';
import 'package:shepherd_voice/screens/films/film_player.dart';
import 'package:shepherd_voice/screens/shared/details_screen.dart';

import '../../global/constants/image_constants.dart';
import '../../network/api_client.dart';

class FilmsScreen extends StatefulWidget {
  final CategoryResponse? category;

  const FilmsScreen({super.key, this.category});

  @override
  State<FilmsScreen> createState() => _FilmsScreenState();
}

class _FilmsScreenState extends State<FilmsScreen> {
  @override
  Widget build(BuildContext context) {
    return DetailsWidget(
      module: ModuleName.song,
      icon: Images.filmsIcon,
      headerImage: Images.filmsHeader,
      headerTitle:
          widget.category?.title ?? AppLocalizations.of(context)!.filmsTitle,
      apiCall: ({required page}) {
        return APIClient.shared.getMovies(
          categoryId: widget.category?.id,
          page: page,
        );
      },
      themeColor: ColorConstants.purple,
      onPressed: (item) {
        ItemResponse film = item as ItemResponse;
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
      },
    );
  }
}
