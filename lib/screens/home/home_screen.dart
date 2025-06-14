import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shepherd_voice/global/constants/color_constants.dart';
import 'package:shepherd_voice/global/extensions/locale_ext.dart';
import 'package:shepherd_voice/global/extensions/text_style_ext.dart';
import 'package:shepherd_voice/main.dart';
import 'package:shepherd_voice/network/push_notification_service.dart';
import 'package:shepherd_voice/screens/activities/activities_screen.dart';
import 'package:shepherd_voice/screens/books/books_screen.dart';
import 'package:shepherd_voice/screens/change_language/LanguageChangerDialog.dart';
import 'package:shepherd_voice/screens/films/films_category.dart';
import 'package:shepherd_voice/screens/films/films_screen.dart';
import 'package:shepherd_voice/screens/home/home_button.dart';
import 'package:shepherd_voice/screens/hymens/hymens_screen.dart';
import 'package:shepherd_voice/screens/usb/usb_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../global/components/stroke_text.dart';
import '../../global/constants/domain_constants.dart';
import '../../global/constants/image_constants.dart';
import '../../global/helpers/shared_pref_manager.dart';
import '../books/books_categories.dart';
import '../films/film_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    globalContext = context;
    PushNotificationService.getInitialMessage();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Images.homeBackgroundPath),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SafeArea(
                  top: true,
                  bottom: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () => _dialogBuilder(context),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(AppLocalizations.of(context)!
                                      .changeLanguage),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Icon(
                                    Icons.edit,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      StrokeText(
                        AppLocalizations.of(context)!.sheperdVoiceTitle,
                        fontSize: 48,
                        fontWeight: FontWeight.w700,
                        color: ColorConstants.homeTitle,
                        strokeColor: Colors.white,
                        strokeWidth: 10,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      DecoratedBox(
                        decoration: const BoxDecoration(
                          color: Colors.white70,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(80),
                            topRight: Radius.circular(80),
                          ),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  35.0, 35, 35.0, 35.0),
                              child: Column(
                                children: [
                                  HomeButton(
                                    title: AppLocalizations.of(context)!
                                        .filmsTitle,
                                    icon: Images.filmsIcon,
                                    backgroundColor: ColorConstants.purple,
                                    onPressed: () {
                                      if (SharedPrefManager.getLocale() ==
                                          LocaleExt.arabic) {
                                        // Categories are available for Arabic language only.
                                        Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) =>
                                                const FilmsCategoriesScreen(),
                                          ),
                                        );
                                      } else {
                                        Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) =>
                                                const FilmsScreen(),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 25),
                                  HomeButton(
                                    title: AppLocalizations.of(context)!
                                        .musicTitle,
                                    icon: Images.musicIcon,
                                    backgroundColor: ColorConstants.turquoise,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) =>
                                              const HymensScreen(),
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 25),
                                  HomeButton(
                                    title:
                                        AppLocalizations.of(context)!.bookTitle,
                                    icon: Images.booksIcon,
                                    backgroundColor: ColorConstants.yellow,
                                    onPressed: () {
                                      if (SharedPrefManager.getLocale() ==
                                          LocaleExt.arabic) {
                                        // Categories are available for Arabic language only.
                                        Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) =>
                                                const BooksCategoriesScreen(),
                                          ),
                                        );
                                      } else {
                                        Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                              builder: (context) =>
                                                  const BooksScreen()),
                                        );
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  HomeButton(
                                    title: AppLocalizations.of(context)!
                                        .activitiesTitle,
                                    icon: Images.activityIcon,
                                    backgroundColor: ColorConstants.gray,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) =>
                                              const ActivitiesScreen(),
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  HomeButton(
                                    title:
                                        AppLocalizations.of(context)!.popeTitle,
                                    icon: Images.popeIcon,
                                    backgroundColor: ColorConstants.red,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          fullscreenDialog: true,
                                          builder: (context) => FilmPlayer(
                                            youtubeLink:
                                                Constants.popeWordVideoLink,
                                            title: AppLocalizations.of(context)!
                                                .popeTitle,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  HomeButton(
                                    title: AppLocalizations.of(context)!
                                        .flashDriveTitle,
                                    icon: Images.usbIcon,
                                    backgroundColor: ColorConstants.blue,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) =>
                                              const USBScreen(),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  30.0, 0, 30.0, 35.0),
                              child: SizedBox(
                                height: 60,
                                child: FilledButton(
                                  style: ButtonStyle(
                                    shape: WidgetStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        side: const BorderSide(
                                          style: BorderStyle.solid,
                                          width: 4,
                                          color: ColorConstants.whatsappGreen,
                                        ),
                                      ),
                                    ),
                                    backgroundColor:
                                        WidgetStateProperty.all<Color?>(
                                      Colors.white.withOpacity(0.05),
                                    ),
                                  ),
                                  onPressed: () {
                                    _launchWhatsapp(
                                      number:
                                          Constants.contactNumber.substring(1),
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(child: Text(
                                        AppLocalizations.of(context)!.contactUs,
                                        style: TextStyleExt.scheherazadeNew(
                                          textStyle: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      )),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Images.whatsappIcon,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return const LanguageChangerDialog();
      },
    );
  }

  _launchWhatsapp({required String number}) async {
    String contact = number;
    String url = "https://wa.me/$contact";

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}
