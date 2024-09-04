import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:make_friends_app/config/app_text.dart';
import 'package:make_friends_app/modules/user/user.entity.dart';
import 'package:make_friends_app/modules/user/user.service.dart';
import 'package:make_friends_app/widgets/error/show_app_error_message.dart';
import 'package:make_friends_app/widgets/error/show_snack_bar.dart';

class RegisterScreen extends HookConsumerWidget {
  const RegisterScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = useState<String>('');
    final isGirl = useState<bool>(true);
    final userService = ref.watch(userServiceProvider);

    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(right: 10, bottom: 20),
                      child: CircleAvatar(
                          radius: 60,
                          foregroundImage: AssetImage('images/GirlIcon.png')),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 10, bottom: 20),
                      child: CircleAvatar(
                          radius: 60,
                          foregroundImage: AssetImage('images/BoyIcon.png')),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'ふたりべやを始めましょう！',
                  style: AppText.style(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'お名前'),
                  onChanged: (String value) {
                    name.value = value;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio(
                        value: true,
                        groupValue: isGirl.value,
                        onChanged: (value) {
                          isGirl.value = value as bool;
                        }),
                    const Text('女性'),
                    const SizedBox(
                      width: 50,
                    ),
                    Radio(
                        value: false,
                        groupValue: isGirl.value,
                        onChanged: (value) {
                          isGirl.value = value as bool;
                        }),
                    const Text('男性'),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    child: const Text('登録完了'),
                    onPressed: () async {
                      try {
                        String userimage = isGirl == true ? 'Girl' : 'Boy';
                        await userService.createUser(
                          AppUser(
                            photoURL: userimage,
                            displayName: name.value,
                          ),
                        );
                        // showDialog(
                        //     context: context,
                        //     builder: (_) {
                        //       return AlertDialog(
                        //         title: Text('ご登録ありがとうございます！'),
                        //         content: Text('恋人との連携は、ホーム画面の設定から行えます。'),
                        //         actions: [
                        //           TextButton(
                        //             child: Text('OK'),
                        //             onPressed: (() {
                        //               Navigator.of(context).pop();
                        //             }),
                        //           )
                        //         ],
                        //       );
                        //     });
                      } catch (e) {
                        showSnackBar(context: context, message: e.toString());
                        // showAppErrorMessage(context: context, e: e);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
