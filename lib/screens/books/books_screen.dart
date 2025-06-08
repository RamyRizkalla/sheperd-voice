import 'package:flutter/cupertino.dart';
import 'package:shepherd_voice/l10n/app_localizations.dart';
import 'package:shepherd_voice/global/constants/color_constants.dart';
import 'package:shepherd_voice/models/item_response.dart';
import 'package:shepherd_voice/models/module_name.dart';
import 'package:shepherd_voice/screens/shared/details_screen.dart';
import 'package:shepherd_voice/screens/shared/pdf_viewer.dart';

import '../../global/constants/image_constants.dart';
import '../../models/category_response.dart';
import '../../network/api_client.dart';

class BooksScreen extends StatefulWidget {
  final CategoryResponse? category;

  const BooksScreen({
    super.key,
    this.category,
  });

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  @override
  Widget build(BuildContext context) {
    return DetailsWidget(
      module: ModuleName.book,
      icon: Images.booksIcon,
      headerImage: Images.booksHeader,
      headerTitle:
          widget.category?.title ?? AppLocalizations.of(context)!.bookTitle,
      apiCall: ({required page}) {
        return APIClient.shared.getBooks(
          categoryId: widget.category?.id,
          page: page,
        );
      },
      themeColor: ColorConstants.yellow,
      onPressed: (item) {
        ItemResponse book = item as ItemResponse;
        Future.delayed(Duration.zero, () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              fullscreenDialog: true,
              builder: (context) => PDFViewer(item: book),
            ),
          );
        });
      },
    );
  }
}
