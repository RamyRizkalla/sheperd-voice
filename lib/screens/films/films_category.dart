import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shepherd_voice/global/constants/color_constants.dart';
import 'package:shepherd_voice/models/category_response.dart';
import 'package:shepherd_voice/screens/films/films_screen.dart';

import '../../global/constants/image_constants.dart';
import '../../models/module.dart';
import '../../network/api_client.dart';
import '../shared/categories/category_widget.dart';

class FilmsCategoriesScreen extends StatefulWidget {
  const FilmsCategoriesScreen({super.key});

  @override
  State<FilmsCategoriesScreen> createState() => _FilmsCategoriesScreenState();
}

class _FilmsCategoriesScreenState extends State<FilmsCategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return CategoryWidget(
      icon: Images.filmsIcon,
      headerImage: Images.filmsCategoryHeader,
      headerTitle: AppLocalizations.of(context)!.moviesCategories,
      crossAxisCount: 2,
      apiCall: ({required page}) {
        return APIClient.shared.getCategories(module: Module.film);
      },
      themeColor: ColorConstants.purple,
      onPressed: (item) {
        CategoryResponse category = item as CategoryResponse;
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => FilmsScreen(
              categoryId: category.id,
            ),
          ),
        );
      },
    );
  }
}
