import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shepherd_voice/global/constants/color_constants.dart';
import 'package:shepherd_voice/models/film_response.dart';
import 'package:shepherd_voice/screens/books/books_screen.dart';

import '../../global/constants/image_constants.dart';
import '../../models/module.dart';
import '../../network/api_client.dart';
import '../shared/categories/category_widget.dart';

class BooksCategoriesScreen extends StatefulWidget {
  const BooksCategoriesScreen({super.key});

  @override
  State<BooksCategoriesScreen> createState() => _BooksCategoriesScreenState();
}

class _BooksCategoriesScreenState extends State<BooksCategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return CategoryWidget(
      icon: Images.bookItemCategory,
      headerImage: Images.musicHeader,
      headerTitle: AppLocalizations.of(context)!.musicTitle,
      crossAxisCount: 2,
      apiCall: ({required page}) {
        return APIClient.shared.getCategories(module: Module.book);
      },
      themeColor: ColorConstants.yellow,
      onPressed: (item) {
        FilmResponse film = item as FilmResponse;
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => const BooksScreen(),
          ),
        );
      },
    );
  }
}
