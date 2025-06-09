import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shepherd_voice/global/helpers/shared_pref_manager.dart';

import '../../global/extensions/locale_ext.dart';
import '../../main.dart';

class LanguageChangerDialog extends StatefulWidget {
  const LanguageChangerDialog({super.key});

  @override
  State<LanguageChangerDialog> createState() => _LanguageChangerDialogState();
}

class _LanguageChangerDialogState extends State<LanguageChangerDialog> {
  Locale? _locale;

  _LanguageChangerDialogState() {
    _locale = SharedPrefManager.getLocale();
  }

  _setLocale(Locale? value) {
    setState(() {
      _locale = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.chooseLanguage),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ListTile(
            title: const Text('عربي'),
            leading: Radio<Locale>(
              value: LocaleExt.arabic,
              groupValue: _locale,
              onChanged: (Locale? value) {
                _setLocale(value);
              },
            ),
          ),
          ListTile(
            title: const Text('English'),
            leading: Radio<Locale>(
              value: LocaleExt.english,
              groupValue: _locale,
              onChanged: (Locale? value) {
                _setLocale(value);
              },
            ),
          ),
          ListTile(
            title: const Text('Français'),
            leading: Radio<Locale>(
              value: LocaleExt.french,
              groupValue: _locale,
              onChanged: (Locale? value) {
                _setLocale(value);
              },
            ),
          )
        ],
      ),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: Text(AppLocalizations.of(context)!.cancel),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: Text(AppLocalizations.of(context)!.apply),
          onPressed: () {
            SharedPrefManager.setLocale(locale: _locale!);
            Navigator.of(context).pop();
            AppRootWidget.restartApp(context);
          },
        ),
      ],
    );
  }
}
