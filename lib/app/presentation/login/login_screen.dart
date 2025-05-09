import 'package:parfumhana_kasir/app/presentation/home/home_screen.dart';
import 'package:parfumhana_kasir/app/presentation/login/login_notifier.dart';
import 'package:parfumhana_kasir/core/helper/dialog_helper.dart';
import 'package:parfumhana_kasir/core/helper/global_helper.dart';
import 'package:parfumhana_kasir/core/widget/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class LoginScreen extends AppWidget<LoginNotifier, void, void> {
  @override
  Widget bodyBuild(BuildContext context) {
    return SafeArea(
        child: Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
              alignment: Alignment.centerRight,
              child: IconButton(
                  onPressed: () => _onPressUrlButton(context),
                  icon: Icon(Icons.link))),
          Expanded(
            child: Center(
              child: Text(
                'parfumhana Kasir',
                style: GlobalHelper.getTextTheme(context,
                    appTextStyle: AppTextStyle.DISPLAY_SMALL),
              ),
            ),
          ),
          TextField(
            controller: notifier.emailController,
            decoration: InputDecoration(
                label: Text('Email'), border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: notifier.passwordController,
            obscureText: true,
            decoration: InputDecoration(
                label: Text('Password'), border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              width: double.maxFinite,
              child: FilledButton(
                  onPressed: () => _onPressLogin(context),
                  child: Text('Login'))),
          SizedBox(
            height: 50,
          )
        ],
      ),
    ));
  }

  @override
  checkVariable(BuildContext context) {
    if (notifier.isLogged) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ));
    }
    return super.checkVariable(context);
  }

  _onPressUrlButton(BuildContext context) {
    DialogHelper.showBottomSheetDialog(
        context: context,
        title: 'Pengaturan Base URL',
        content: Column(
          children: [
            TextField(
              controller: notifier.baseUrlController,
              decoration: InputDecoration(
                  label: Text('Base URL'), border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                width: double.maxFinite,
                child: FilledButton(
                    onPressed: () => _onPressSaveBaseUrl(context),
                    child: Text('Simpan')))
          ],
        ));
  }

  _onPressLogin(BuildContext context) {
    notifier.login();
  }

  _onPressSaveBaseUrl(BuildContext context) {
    notifier.saveBaseUrl();
    Navigator.pop(context);
  }
}
