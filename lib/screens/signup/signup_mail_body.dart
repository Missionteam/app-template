import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:make_friends_app/config/app_text.dart';
import 'package:make_friends_app/modules/auth/auth.repository.dart';
import 'package:make_friends_app/widgets/error/show_app_error_message.dart';

class SingupMailBody extends ConsumerStatefulWidget {
  const SingupMailBody({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SingupScreenState();
}

class _SingupScreenState extends ConsumerState<SingupMailBody> {
  String email = '';
  String password = '';
  final formKey = GlobalKey<FormState>();

  Widget circleIcon(String imagePath) {
    return Padding(
      padding: EdgeInsets.only(right: 10, bottom: 20),
      child: CircleAvatar(radius: 60, foregroundImage: AssetImage(imagePath)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authRepository = ref.watch(firebaseAuthRepositoryProvider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      circleIcon('images/GirlIcon.png'),
                      circleIcon('images/BoyIcon.png'),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'ふたりべやを始めましょう！',
                    style: AppText.style(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ..._formFields(),
                  const SizedBox(
                    height: 10,
                  ),
                  _buttons(authRepository, context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _formFields() {
    return [
      TextFormField(
        decoration: const InputDecoration(labelText: 'メールアドレス'),
        onChanged: (String value) {
          setState(() {
            email = value;
          });
        },
      ),
      const SizedBox(
        height: 20,
      ),
      TextFormField(
        decoration: const InputDecoration(labelText: 'パスワード'),
        obscureText: true,
        validator: (String? value) {
          return (value!.length < 6) ? 'パスワードは6文字以上にしてください。' : null;
        },
        onChanged: (String value) {
          setState(() {
            password = value;
          });
        },
      ),
    ];
  }

  Widget _buttons(FirebaseAuthRepository authRepository, BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: ElevatedButton(
                child: const Text('ユーザ登録'),
                onPressed: () async {
                  try {
                    if (formKey.currentState!.validate()) {
                      authRepository.singUpWithMail(
                        email,
                        password,
                      );
                    }
                  } catch (e) {
                    showAppErrorMessage(context: context, e: e);
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                child: const Text('ログイン'),
                onPressed: () {
                  try {
                    // メール/パスワードでログイン
                    authRepository.signInWithMail(email, password);
                  } catch (e) {
                    showAppErrorMessage(context: context, e: e);
                  }
                },
              ),
            ),
          ],
        ),
        MaterialButton(
          child: const Text('パスワードリセット'),
          onPressed: () {
            try {
              authRepository.resetPassword(email);
            } catch (e) {
              showAppErrorMessage(context: context, e: e);
            }
          },
        ),
      ],
    );
  }
}
