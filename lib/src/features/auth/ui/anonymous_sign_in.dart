import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:truck_trucker/src/features/auth/bloc/states.dart';
import '../../../global_widgets/global_sized_box.dart';
import '../../../global_widgets/global_text_form_field.dart';
import '../bloc/cubit.dart';

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

  void submit() async {
    _formKey.currentState!.validate()
        ? await context.read<AuthCubit>().submit(
              context: context,
              name: _nameController.text,
              phone: _phoneController.text,
            )
        : null;
  }

  // serviceLocator.get<Database>().test();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
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
                        onFieldSubmitted: (String? name) =>
                            _phoneEditingComplete,
                        validator: (String? name) =>
                            name == null || name.isEmpty
                                ? 'Please enter your name'
                                : null,
                        controller: _nameController,
                      ),
                      const GlobalSizedBox(height: 10),
                      GlobalTextFormField(
                        labelText: 'Phone',
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (String? phone) => submit,
                        validator: (String? phone) =>
                            phone == null || phone.isEmpty
                                ? 'Please enter your phone'
                                : null,
                        controller: _phoneController,
                      ),
                      const GlobalSizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: state is AuthLoading ? null : submit,
                          child: state is AuthLoading
                              ? const CircularProgressIndicator()
                              : const Text('Submit'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
