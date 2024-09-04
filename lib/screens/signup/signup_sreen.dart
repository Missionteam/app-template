import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:make_friends_app/screens/signup/signup_mail_body.dart';

enum SignUpMethod {
  email,
}

class SignUpSreen extends HookConsumerWidget {
  const SignUpSreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signUpMethod = useState<SignUpMethod>(SignUpMethod.email);
    switch (signUpMethod.value) {
      case SignUpMethod.email:
        return const SingupMailBody();
    }
  }
}
