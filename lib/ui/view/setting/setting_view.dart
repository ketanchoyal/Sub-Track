import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:sub_track/ui/shared/shared.dart';
import 'package:sub_track/ui/theme/app_colors.dart';
import './setting_viewmodel.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingView extends StatelessWidget {
  Widget appbar(model, context) {
    return Platform.isIOS
        ? CupertinoNavigationBar(
            // border: Border(bottom: BorderSide.none),
            automaticallyImplyLeading: false,
            backgroundColor: AppColor.STPureWhite,
            transitionBetweenRoutes: true,
            middle: Text("Setting"),
            leading: Padding(
              padding:
                  const EdgeInsetsDirectional.only(start: 0, end: 0, top: 7),
              child: GestureDetector(
                onTap: model.pop,
                child: Text.rich(
                  TextSpan(
                    text: String.fromCharCode(CupertinoIcons.back.codePoint),
                    style: TextStyle(
                      inherit: false,
                      color: CupertinoTheme.of(context).primaryColor,
                      fontSize: 30.0,
                      fontFamily: CupertinoIcons.back.fontFamily,
                      package: CupertinoIcons.back.fontPackage,
                    ),
                  ),
                ),
              ),
            ),
          )
        : AppBar(
            backgroundColor: AppColor.STAccent,
            title: Text(
              "Setting",
              style: kHeader3Style,
            ),
            leading: GestureDetector(
              onTap: model.pop,
              child: Icon(
                Icons.arrow_back,
                size: 25,
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SettingViewModel>.reactive(
      viewModelBuilder: () => SettingViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: AppColor.STLight,
        appBar: appbar(model, context) as PreferredSizeWidget,
        body: buildSettingsList(model),
      ),
    );
  }

  Widget buildSettingsList(SettingViewModel model) {
    return SettingsList(
      sections: [
        if (model.isLoggedIn && !model.isAnonymous)
          SettingsSection(
            title: 'Account',
            tiles: [
              SettingsTile(title: 'Phone number', leading: Icon(Icons.phone)),
              SettingsTile(title: 'Email', leading: Icon(Icons.email)),
              SettingsTile(
                title: 'Sign out',
                leading: Icon(Icons.exit_to_app),
                onPressed: (context) {
                  model.signOut();
                },
              ),
            ],
          ),
        if (!model.isLoggedIn || model.isAnonymous)
          SettingsSection(
            title: 'Account',
            tiles: [
              SettingsTile(
                title: 'Sign In',
                leading: Icon(Icons.exit_to_app),
                onPressed: (context) {
                  model.navigateToSignIn();
                },
              ),
            ],
          ),
        SettingsSection(
          title: 'Common',
          tiles: [
            SettingsTile(
              title: 'Theme',
              subtitle: 'Light',
              leading: Icon(Icons.wb_sunny),
              onPressed: (context) {},
            ),
            SettingsTile(
              title: 'Currency',
              subtitle: 'CAD',
              leading: Icon(Icons.monetization_on),
            ),
          ],
        ),
        SettingsSection(
          title: 'Security',
          tiles: [
            SettingsTile.switchTile(
                title: 'Use fingerprint',
                subtitle: 'Allow application to access stored fingerprint IDs.',
                leading: Icon(Icons.fingerprint),
                switchActiveColor: AppColor.STAccent,
                onToggle: (bool value) {},
                switchValue: false),
            SettingsTile.switchTile(
              title: 'Enable Notifications',
              enabled: true,
              switchActiveColor: AppColor.STAccent,
              leading: Icon(Icons.notifications_active),
              switchValue: true,
              onToggle: (value) {},
            ),
          ],
        ),
        SettingsSection(
          title: 'Misc',
          tiles: [
            SettingsTile(
              title: 'FAQs',
              leading: Icon(Icons.question_answer),
            ),
            SettingsTile(
              title: 'Rate',
              leading: Icon(Icons.rate_review),
              iosChevron: null,
            ),
            SettingsTile(
              title: 'Privacy',
              leading: Icon(Icons.privacy_tip_rounded),
            ),
            SettingsTile(
              title: 'Terms of Service',
              leading: Icon(Icons.description),
            ),
            SettingsTile(
              title: 'Open source licenses',
              leading: Icon(Icons.collections_bookmark),
            ),
          ],
        ),
        CustomSection(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 5),
                child: Image.asset(
                  "assets/launcher_icons/splash_screen.png",
                  height: 45,
                  width: 45,
                  color: Color(0xFF777777),
                ),
              ),
              Text(
                'Version: 1.0.0-beta.3',
                style: kSmallStyle.copyWith(color: Color(0xFF777777)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
