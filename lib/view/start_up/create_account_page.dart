
import 'package:checklist_child_grow_up/utils/firestore/authentications.dart';
import 'package:checklist_child_grow_up/utils/firestore/users.dart';
import 'package:checklist_child_grow_up/utils/function_utils.dart';
import 'package:checklist_child_grow_up/utils/widget_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../model/account.dart';
import '../../utils/loading/loading_button.dart';
import '../../utils/validator.dart';
import 'check_email_page.dart';


class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final RoundedLoadingButtonController btnController = RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetUtils.createAppBar('アカウント作成'),
      body: SingleChildScrollView(
        child: SizedBox(
            width: double.infinity,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 40),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: nameController,
                    validator: (value) {
                      return Validator.getRequiredValidatorMessage(value);
                    },
                    decoration: const InputDecoration(
                      labelText: 'ユーザ名 (必須)',
                      labelStyle: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: emailController,
                      validator: (value) {
                        return Validator.getEmailRegValidatorMessage(value);
                      },
                      decoration: const InputDecoration(
                        labelText: 'メールアドレス (必須)',
                        labelStyle: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: passwordController,
                    validator: (value) {
                      return Validator.getPasswordValidatorMessage(value);
                    },
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'パスワード (必須)',
                      labelStyle: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                LoadingButton(
                  btnController: btnController,
                  onPressed: () async {
                    if(!formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        WidgetUtils.errorSnackBar('正しく入力されていない項目があります')
                      );
                      return FunctionUtils.showErrorButtonFor4Seconds(btnController);
                    }
                    var signUpResult = await AuthenticationFirestore.signUp(
                      email: emailController.text,
                      password: passwordController.text
                    );
                    if (signUpResult is! UserCredential) {
                      if(!mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        WidgetUtils.errorSnackBar(signUpResult)
                      );
                      return FunctionUtils.showErrorButtonFor4Seconds(btnController);
                    }
                    Account newAccount = Account(
                      id: signUpResult.user!.uid,
                      name: nameController.text,
                    );
                    var setUserResult = await UserFirestore.setUser(newAccount);
                    if(!setUserResult) {
                      if(!mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        WidgetUtils.errorSnackBar('アカウント作成に失敗しました')
                      );
                      return FunctionUtils.showErrorButtonFor4Seconds(btnController);
                    }
                    signUpResult.user!.sendEmailVerification();
                    await FunctionUtils.showSuccessButtonFor1Seconds(btnController);
                    if(!mounted) return;
                    Navigator.push(
                      context, MaterialPageRoute(
                        builder: (context) => CheckEmailPage(
                          email: emailController.text,
                          password: passwordController.text,
                        )
                      )
                    );
                  },
                  child: const Text('作成')
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
