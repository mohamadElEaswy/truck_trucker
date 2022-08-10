import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../data/database/database.dart';
import '../../../data/models/user_model.dart';
import '../../../data/network/auth.dart';
import '../../../global_widgets/global_sized_box.dart';
import '../../../global_widgets/global_text_form_field.dart';
import '../../../injection.dart' as di;
import '../../../utils/routing/named_routs.dart';
import '../../../utils/routing/routing_methods.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final FocusNode _phoneFocusNode = FocusNode();

  @override
  void dispose() {
    _phoneFocusNode.dispose();
    super.dispose();
  }

  void _phoneEditingComplete() {
    FocusScope.of(context).requestFocus(_phoneFocusNode);
  }

  AuthBase auth = di.serviceLocator.get<AuthBase>();
  void submit() async {
    auth.test();
    // auth.signInAnonymously().then((User? user) {
    //   di.serviceLocator.get<Database>().setUser(
    //     user: user!,
    //     userModel: UserModel(
    //       name: _nameController.text,
    //       id: user.uid,
    //       phone: _phoneController.text,
    //     ),
    //   );
    // }).catchError((error) {});
    // User? user = await auth.currentUser();
    RoutingMethods.pushNamed(
      context: context,
      route: NamedRouts.home,
    );
  }
  // serviceLocator.get<Database>().test();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Welcome to Truck Trucker App.. \nPlease fill the following informations to continue',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                  const GlobalSizedBox(height: 40),
                  GlobalTextFormField(
                    labelText: 'Name',
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (String? name) => _phoneEditingComplete,
                  ),
                  const GlobalSizedBox(height: 10),
                  GlobalTextFormField(
                    labelText: 'Phone',
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (String? phone) => submit,
                  ),
                  const GlobalSizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: submit,
                      child: const Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
