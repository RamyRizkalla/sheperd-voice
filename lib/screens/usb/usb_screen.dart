import 'package:flutter/material.dart';
import 'package:shepherd_voice/l10n/app_localizations.dart';
import 'package:shepherd_voice/global/constants/color_constants.dart';
import 'package:shepherd_voice/models/category_response.dart';
import 'package:shepherd_voice/models/item_response.dart';
import 'package:shepherd_voice/models/module_name.dart';
import 'package:shepherd_voice/screens/films/film_player.dart';
import 'package:shepherd_voice/screens/shared/details_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../global/constants/image_constants.dart';
import '../../network/api_client.dart';

class USBScreen extends StatefulWidget {
  final CategoryResponse? category;

  const USBScreen({super.key, this.category});

  @override
  State<USBScreen> createState() => _USBScreenState();
}

class _USBScreenState extends State<USBScreen> {
  @override
  Widget build(BuildContext context) {
    return DetailsWidget(
      module: ModuleName.usb,
      icon: Images.usbIcon,
      headerImage: Images.usbHeader,
      headerTitle: widget.category?.title ??
          AppLocalizations.of(context)!.flashDriveTitle,
      apiCall: ({required page}) {
        return APIClient.shared.getUSB(context);
      },
      themeColor: ColorConstants.blue,
      onPressed: (item) {
        ItemResponse itemResponse = item as ItemResponse;

        if (itemResponse.id == '1') {
          Navigator.push(
            context,
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) => FilmPlayer(
                youtubeLink: itemResponse.youtubeLink!,
                title: AppLocalizations.of(context)!.usbExplanation,
              ),
            ),
          );
        } else if (itemResponse.id == '2') {
          _launchUrl(url: itemResponse.youtubeLink!);
        }
      },
    );
  }

  Future<void> _launchUrl({required String url}) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}
