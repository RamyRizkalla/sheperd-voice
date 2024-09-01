import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shepherd_voice/global/constants/color_constants.dart';
import 'package:shepherd_voice/models/film_response.dart';
import 'package:shepherd_voice/models/module.dart';
import 'package:shepherd_voice/screens/films/film_player.dart';
import 'package:shepherd_voice/screens/shared/details_screen.dart';

import '../../global/constants/image_constants.dart';
import '../../network/api_client.dart';

class BooksScreen extends StatefulWidget {
  const BooksScreen({super.key});

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  @override
  Widget build(BuildContext context) {
    return DetailsWidget(
      module: Module.book,
      icon: Images.booksIcon,
      headerImage: Images.booksHeader,
      headerTitle: AppLocalizations.of(context)!.bookTitle,
      apiCall: ({required page}) {
        return APIClient.shared.getBooks(page: page);
      },
      themeColor: ColorConstants.yellow,
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
