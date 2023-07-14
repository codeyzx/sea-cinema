import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seacinema/src/features/auth/domain/users.dart';
import 'package:seacinema/src/features/auth/presentation/auth_controller.dart';
import 'package:seacinema/src/features/home/presentation/home_botnavbar_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/quickalert.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic>? data;
  static const routeName = 'edit-profile-screen';
  const EditProfileScreen({Key? key, this.data}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullnameController = TextEditingController();
  final _usernameController = TextEditingController();
  bool _isLoading = false;
  String? _dateofbirth;

  void setInitialValue() {
    Users user = widget.data?['user'];
    _fullnameController.text = user.name!;
    _usernameController.text = user.username!;
    _dateofbirth = user.birth;
  }

  @override
  void initState() {
    super.initState();
    setInitialValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 34.0.sp,
            vertical: 100.0.sp,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                                enabled: false,
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 14.0.sp),
                                  hintText: 'USERNAME',
                                  label: Text(
                                    'USERNAME',
                                    style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 14.0.sp),
                                  ),
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
                                style: TextStyle(color: Colors.white, fontSize: 14.0.sp),
                                controller: _fullnameController,
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 14.0.sp),
                                  hintText: 'FULL NAME',
                                  label: Text(
                                    'FULL NAME',
                                    style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 14.0.sp),
                                  ),
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
                                    return 'please enter your full name';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 40.0.sp),
                              Container(
                                height: 50.0.sp,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.7),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 15.sp),
                                        child: Text(
                                          _dateofbirth ?? 'DATE OF BIRTH',
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(0.7),
                                            fontSize: 14.0.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime.now(),
                                        ).then((value) {
                                          setState(() {
                                            _dateofbirth = DateFormat('dd/MM/yyyy').format(value!);
                                          });
                                        });
                                      },
                                      child: Container(
                                        height: double.infinity,
                                        width: 50.0.sp,
                                        decoration: BoxDecoration(
                                          color: HexColor('#353653'),
                                          borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(10.0),
                                            bottomRight: Radius.circular(10.0),
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.calendar_today_outlined,
                                          color: Colors.white.withOpacity(0.7),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 80.0.sp),
                        SizedBox(
                          width: double.infinity,
                          height: 50.0.sp,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate() && _isLoading == false) {
                                if (_dateofbirth == null) {
                                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      content: Text('please enter your date of birth'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                } else {
                                  setState(() {
                                    _isLoading = true;
                                  });

                                  final users = Users(
                                    uid: widget.data?['user'].uid,
                                    name: _fullnameController.text,
                                    username: _usernameController.text,
                                    birth: _dateofbirth,
                                  );
                                  try {
                                    await ref.read(authControllerProvider.notifier).updateProfile(users);
                                    if (!mounted) return;
                                    QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.success,
                                      text: 'Success Update Profile!',
                                      onConfirmBtnTap: () {
                                        context.goNamed(HomeBotNavBarScreen.routeName);
                                      },
                                      barrierDismissible: false,
                                    );
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        behavior: SnackBarBehavior.floating,
                                        content: Text(e.toString()),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  }

                                  setState(() {
                                    _isLoading = false;
                                  });
                                }
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
                                    'SAVE',
                                    style: TextStyle(
                                      fontSize: 14.0.sp,
                                      fontWeight: FontWeight.w500,
                                      color: HexColor('##F2F2F1'),
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
