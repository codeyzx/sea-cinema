import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seacinema/src/features/auth/presentation/auth_controller.dart';
import 'package:seacinema/src/features/auth/presentation/sign_up_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';

class SignInScreen extends ConsumerStatefulWidget {
  static const routeName = 'sign-in-screen';
  const SignInScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.only(
          left: 50.0.sp,
          right: 50.0.sp,
          top: 120.0.sp,
          bottom: 50.0.sp,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello there,'
                  '\nWelcome back',
                  style: TextStyle(
                    color: HexColor('#F2F2F1'),
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 45.0.sp),
                Padding(
                  padding: EdgeInsets.only(left: 12.0.sp, right: 15.0.sp),
                  child: Column(
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              style: TextStyle(color: Colors.white, fontSize: 14.0.sp),
                              controller: _usernameController,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 14.0.sp),
                                hintText: 'USERNAME',
                                contentPadding: EdgeInsets.only(bottom: 10.0.sp),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: HexColor('##F2F2F1'),
                                    width: 1.0,
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white.withOpacity(0.7),
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'please enter your username';
                                } else if (value.contains(' ')) {
                                  return 'username must not contain space';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 40.0.sp),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              style: TextStyle(color: Colors.white, fontSize: 14.0.sp),
                              decoration: InputDecoration(
                                hintStyle: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 14.0.sp),
                                hintText: 'PASSWORD',
                                contentPadding: EdgeInsets.only(bottom: 10.0.sp),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: HexColor('##F2F2F1'),
                                    width: 1.0,
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white.withOpacity(0.7),
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'please enter your password';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 60.0.sp),
                      Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 50.0.sp,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate() && _isLoading == false) {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  await ref
                                      .read(authControllerProvider.notifier)
                                      .signIn(context, _usernameController.text, _passwordController.text);
                                  setState(() {
                                    _isLoading = false;
                                  });
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: HexColor('#353653'),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: _isLoading
                                  ? const CircularProgressIndicator()
                                  : Text(
                                      'SIGN IN',
                                      style: TextStyle(
                                        fontSize: 14.0.sp,
                                        fontWeight: FontWeight.w500,
                                        color: HexColor('##F2F2F1'),
                                      ),
                                    ),
                            ),
                          ),
                          SizedBox(height: 5.0.sp),
                          TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white.withOpacity(0.9),
                            ),
                            child: Text(
                              'Forgot password?',
                              style: TextStyle(
                                fontSize: 12.0.sp,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  context.pushNamed(SignUpScreen.routeName);
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white.withOpacity(0.9),
                ),
                child: Text(
                  'New here? Create an account',
                  style: TextStyle(fontSize: 12.0.sp, fontWeight: FontWeight.w300),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
