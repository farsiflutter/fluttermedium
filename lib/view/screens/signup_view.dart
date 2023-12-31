import 'package:dblog/view/widgets/logo.dart';
import 'package:dblog/viewmodel/providers/password_visibility.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/enums/enums.dart';
import '../../viewmodel/providers/auth_viewmodel.dart';
import '../style/colors/colorstyle.dart';
import '../widgets/login_signup_form.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController confirmpassword;
  late TextEditingController username;
  late TextEditingController fullname;

  final _formstate = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    email = TextEditingController();
    password = TextEditingController();
    confirmpassword = TextEditingController();
    fullname = TextEditingController();
    username = TextEditingController();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    confirmpassword.dispose();
    fullname.dispose();
    username.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: _formstate,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 70.h),
        child: Column(
          children: [
            const Logo(),
             SizedBox(height: 40.h),
            Text('Join Medium.',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 25.sp)),
             SizedBox(
              height: 20.h,
            ),
            TextFormField(
                style: Theme.of(context).textTheme.labelMedium,
                controller: username,
                validator: (val) => val!.isEmpty ? "Enter your username" : null,
                decoration: formDecoration.copyWith(
                    hintStyle: Theme.of(context).textTheme.labelMedium,
                    labelStyle: Theme.of(context).textTheme.labelMedium,
                    hintText: "Username",
                    labelText: "Username")),
             SizedBox(
              height: 10.h,
            ),
            TextFormField(
                style: Theme.of(context).textTheme.labelMedium,
                controller: email,
                validator: (val) => val!.isEmpty ? "Enter your email" : null,
                decoration: formDecoration.copyWith(
                    hintStyle: Theme.of(context).textTheme.labelMedium,
                    labelStyle: Theme.of(context).textTheme.labelMedium,
                    hintText: "Email",
                    labelText: "Email")),
            SizedBox(
              height: 10.h,
            ),
            TextFormField(
                style: Theme.of(context).textTheme.labelMedium,
                controller: fullname,
                validator: (val) =>
                    val!.isEmpty ? "Enter your full name" : null,
                decoration: formDecoration.copyWith(
                    hintStyle: Theme.of(context).textTheme.labelMedium,
                    labelStyle: Theme.of(context).textTheme.labelMedium,
                    hintText: "Full name",
                    labelText: "Full name")),
            SizedBox(
              height: 10.h,
            ),
            _PasswordField(
              controller: password,
            ),
            SizedBox(
              height: 10.h,
            ),
            _ConfirmPasswordField(
              controller: confirmpassword,
            ),
             SizedBox(
              height: 20.h,
            ),
            InkWell(
              onTap: () async {
                if (_formstate.currentState!.validate() &&
                    password.text == confirmpassword.text) {
                  Map<String, String> formdata = {
                    'username': username.text.trim(),
                    'email': email.text.trim(),
                    'fullname': fullname.text.trim(),
                    'password': password.text,
                    'confirm_password': confirmpassword.text
                  };
                  Provider.of<SignUpAuthChangeNotifer>(context, listen: false)
                      .signUp(formdata);
                }
              },
              child: Consumer<SignUpAuthChangeNotifer>(
                builder: (context, value, child) => Container(
                  alignment: Alignment.center,
                  width: double.maxFinite,
                  height: 50.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: ColorStyle.lightgreen[400],
                  ),
                  child: value.fetchstate == PageState.loading
                      ? const Center(
                          child: CircularProgressIndicator(
                              color: ColorStyle.white),
                        )
                      :  Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: ColorStyle.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            const _ErrorMessage(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account"),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: const Text(
                      "Sign In",
                    ))
              ],
            )
          ],
        ),
      ),
    ));
  }
}

class _PasswordField extends StatelessWidget {
  final TextEditingController controller;
  const _PasswordField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Consumer<VisibilityNotifier>(
      builder: (context, value, child) => TextFormField(
          style: Theme.of(context).textTheme.labelMedium,
          controller: controller,
          obscureText: value.passwordtoggle ? true : false,
          validator: (val) => val!.isEmpty ? "Enter your Password" : null,
          decoration: formDecoration.copyWith(
              hintStyle: Theme.of(context).textTheme.labelMedium,
              labelStyle: Theme.of(context).textTheme.labelMedium,
              suffixIcon: IconButton(
                onPressed: () {
                  Provider.of<VisibilityNotifier>(context, listen: false)
                      .visibility('password');
                },
                icon: value.passwordtoggle
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
              ),
              hintText: "Password",
              labelText: "Password")),
    );
  }
}

class _ConfirmPasswordField extends StatelessWidget {
  final TextEditingController controller;
  const _ConfirmPasswordField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Consumer<VisibilityNotifier>(
      builder: (context, value, child) => TextFormField(
          style: Theme.of(context).textTheme.labelMedium,
          obscureText: value.confirmtoggle ? true : false,
          controller: controller,
          validator: (val) =>
              val!.isEmpty ? "Enter your ComfirmPassword" : null,
          decoration: formDecoration.copyWith(
              hintStyle: Theme.of(context).textTheme.labelMedium,
              labelStyle: Theme.of(context).textTheme.labelMedium,
              suffixIcon: IconButton(
                onPressed: () {
                  Provider.of<VisibilityNotifier>(context, listen: false)
                      .visibility('confirmPassword');
                },
                icon: value.confirmtoggle
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
              ),
              hintText: "Comfirm Password",
              labelText: "Comfirm Password")),
    );
  }
}

class _ErrorMessage extends StatelessWidget {
  const _ErrorMessage();

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpAuthChangeNotifer>(
      builder: (context, value, child) => value.errormessage == ""
          ? const SizedBox()
          : Text(
              value.errormessage,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(color: Colors.red),
            ),
    );
  }
}
