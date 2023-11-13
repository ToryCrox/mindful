
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mindful/app/app_router.dart';
import 'package:mindful/widget/popup_loading.dart';

import 'login_with_password_store.dart';

class LoginWithPasswordPage extends StatefulWidget {
  const LoginWithPasswordPage({super.key});

  @override
  State<LoginWithPasswordPage> createState() => _LoginWithPasswordPageState();
}

class _LoginWithPasswordPageState extends State<LoginWithPasswordPage> {


  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _store = LoginWithPasswordStore();

  @override
  void initState() {
    super.initState();
    if (_store.phoneNumber.isNotEmpty) {
      _phoneController.text = _store.phoneNumber;
    }
    _phoneController.addListener(() {
      _store.setPhoneNumber(_phoneController.text);
    });
    _passwordController.addListener(() {
      _store.setPassword(_passwordController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('登录/注册'),
      ),
      body: Observer(
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: _buildBody(),
          );
        }
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        const SizedBox(height: 40),
        TextField(
          controller: _phoneController,
          decoration:  const InputDecoration(
            hintText: '请输入手机号',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.phone),
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _passwordController,
          decoration: const InputDecoration(
            hintText: '请输入密码',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.lock),
          ),
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
        ),
        const Spacer(),
        ElevatedButton(
          onPressed: _store.isLoginEnable ? _login : null,
          child: const Text('登录'),
        ),
      ],
    );
  }

  Future _login() async {
    showPopupLoading(context);
    final result = await _store.login();
    hidePopupLoading();
    if (result && mounted) {
      AppRouter.pushUntilHome(context);
    }
  }
}
