import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shepherd_voice/global/constants/color_constants.dart';
import 'package:shepherd_voice/global/extensions/text_style_ext.dart';
import 'package:shepherd_voice/screens/change_language/LanguageChangerDialog.dart';
import 'package:shepherd_voice/screens/films/films_screen.dart';
import 'package:shepherd_voice/screens/home/home_button.dart';
import 'package:shepherd_voice/screens/home/home_screen_title_box.dart';
import 'package:shepherd_voice/screens/hymens/hymens_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../global/components/stroke_text.dart';
import '../../global/constants/domain_constants.dart';
import '../../global/constants/image_constants.dart';
import '../films/film_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(60, 0, 60, 0),
                        child: MainScreenTitleBox(
                            title: AppLocalizations.of(context)!.homeTitle),
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
                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) =>
                                              const FilmsScreen(),
                                        ),
                                      );
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
                                      // Navigator.push(
                                      //   context,
                                      //   CupertinoPageRoute(
                                      //     builder: (context) =>
                                      //         const BooksCategoriesScreen(),
                                      //   ),
                                      // );
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  HomeButton(
                                    title: AppLocalizations.of(context)!
                                        .activitiesTitle,
                                    icon: Images.activityIcon,
                                    backgroundColor: ColorConstants.gray,
                                    onPressed: () {
                                      // Navigator.push(
                                      //   context,
                                      //   CupertinoPageRoute(
                                      //     builder: (context) =>
                                      //         const ActivitiesCategoriesScreen(),
                                      //   ),
                                      // );
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
                                          builder: (context) =>
                                              const FilmPlayer(
                                            youtubeLink:
                                                Constants.popeWordVideoLink,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            FilledButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color?>(
                                        Colors.white.withOpacity(0.05)),
                              ),
                              onPressed: () {
                                _launchCaller(number: Constants.contactNumber);
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.contactUs,
                                    style: TextStyleExt.scheherazadeNew(
                                      textStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        Constants.contactNumber,
                                        style: TextStyleExt.scheherazadeNew(
                                          textStyle: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Images.whatsappIcon,
                                    ],
                                  ),
                                ],
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

  _launchCaller({required String number}) async {
    final url = Uri.parse('tel:$number');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
