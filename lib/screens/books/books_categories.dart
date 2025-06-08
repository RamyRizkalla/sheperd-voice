import 'package:flutter/cupertino.dart';
import 'package:shepherd_voice/l10n/app_localizations.dart';
import 'package:shepherd_voice/global/constants/color_constants.dart';
import 'package:shepherd_voice/models/category_response.dart';
import 'package:shepherd_voice/screens/books/books_screen.dart';

import '../../global/constants/image_constants.dart';
import '../../models/module_name.dart';
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
      headerImage: Images.booksIcon,
      headerTitle: AppLocalizations.of(context)!.booksCategories,
      crossAxisCount: 2,
      apiCall: ({required page}) {
        return APIClient.shared.getCategories(module: ModuleName.book);
      },
      themeColor: ColorConstants.yellow,
      onPressed: (item) {
        CategoryResponse category = item as CategoryResponse;
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => BooksScreen(
              category: category,
            ),
          ),
        );
      },
    );
  }
}
