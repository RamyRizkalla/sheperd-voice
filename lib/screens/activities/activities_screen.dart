import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shepherd_voice/global/constants/color_constants.dart';
import 'package:shepherd_voice/models/film_response.dart';
import 'package:shepherd_voice/models/module.dart';
import 'package:shepherd_voice/screens/shared/details_screen.dart';
import 'package:shepherd_voice/screens/shared/image_previewer.dart';

import '../../global/constants/image_constants.dart';
import '../../network/api_client.dart';

class ActivitiesScreen extends StatefulWidget {
  const ActivitiesScreen({
    super.key,
  });

  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  @override
  Widget build(BuildContext context) {
    return DetailsWidget(
      module: Module.activity,
      icon: Images.activityIcon,
      headerImage: Images.activitiesHeader,
      headerTitle: AppLocalizations.of(context)!.activitiesTitle,
      apiCall: ({required page}) {
        return APIClient.shared.getActivities(
          page: page,
        );
      },
      themeColor: ColorConstants.gray,
      onPressed: (item) {
        FilmResponse film = item as FilmResponse;
        Future.delayed(Duration.zero, () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              fullscreenDialog: true,
              builder: (context) => ImagePreviewer(
                item: film,
              ),
            ),
          );
        });
      },
    );
  }
}
