import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Images {
  static const String _path = 'assets/images';
  static const String _jpg = 'jpg';
  static const String _svg = 'svg';

  static final Image homeBackground =
      Image.asset('$_path/home_background.$_jpg');
  static const String homeBackgroundPath = '$_path/home_background.$_jpg';

  static final Widget activityIcon =
      SvgPicture.asset('$_path/activity_icon.$_svg');
  static final Widget booksIcon = SvgPicture.asset('$_path/books_icon.$_svg');
  static final Widget filmsIcon = SvgPicture.asset('$_path/films_icon.$_svg');
  static final Widget musicIcon = SvgPicture.asset('$_path/music_icon.$_svg');
  static final Widget popeIcon = SvgPicture.asset('$_path/pope_icon.$_svg');
  static final Widget whatsappIcon = Image.asset('$_path/whatsapp_icon.png');

  // Headers
  static final Widget filmsHeader = Image.asset('$_path/films_header.png');
  static final Widget musicHeader = Image.asset('$_path/music_header.png');
  static final Widget booksHeader = Image.asset('$_path/books_header.png');
  static final Widget activitiesHeader =
      Image.asset('$_path/activities_header.svg');
  static final Widget popeHeader = Image.asset('$_path/pope_header.svg');

  // Categories
  static final Widget bookItemCategory =
      SvgPicture.asset('$_path/book_category.$_svg');
  static final Widget activityItemCategory =
      SvgPicture.asset('$_path/activity_category.$_svg');
}
