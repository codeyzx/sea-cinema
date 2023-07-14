import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:seacinema/src/features/auth/domain/users.dart';
import 'package:seacinema/src/features/auth/presentation/sign_in_screen.dart';
import 'package:seacinema/src/features/home/presentation/home_botnavbar_screen.dart';

import 'package:logger/logger.dart';

import 'package:go_router/go_router.dart';

class AuthController extends StateNotifier<Users> {
  AuthController() : super(const Users());

  Future<void> signIn(BuildContext context, String username, String password) async {
    try {
      final email = '$username@gmail.com';
      var userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        var checkUsers = await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).get();
        final users = Users.fromJson(checkUsers.data()!);
        state = users;
        if (!mounted) return;
        context.goNamed(HomeBotNavBarScreen.routeName);
      }
    } on FirebaseAuthException catch (e) {
      String message = '';
      switch (e.code) {
        case 'wrong-password':
          message = 'Your password is wrong';
        case 'user-not-found':
          message = 'User not found';
        case 'invalid-email':
          message = 'Your username is invalid';
          break;
        default:
          message = 'An error occurred, please try again later';
      }
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(message),
          backgroundColor: Colors.red,
        ),
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
    }
  }

  Future<void> signUp(BuildContext context, Users user, String password) async {
    try {
      final email = '${user.username}@gmail.com';
      var userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
          'uid': userCredential.user!.uid,
          'name': user.name,
          'username': user.username,
          'birth': user.birth,
          'balance': 0,
        });
        final users = user.copyWith(uid: userCredential.user!.uid);
        state = users;
        if (!mounted) return;
        context.goNamed(HomeBotNavBarScreen.routeName);
      }
    } on FirebaseAuthException catch (e) {
      String message = '';
      switch (e.code) {
        case 'email-already-in-use':
          message = 'This username is already taken';
        case 'weak-password':
          message = 'Your password is too weak';
          break;
        default:
          message = 'An error occurred, please try again later';
      }
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(message),
          backgroundColor: Colors.red,
        ),
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
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      if (!mounted) return;
      context.goNamed(SignInScreen.routeName);
    } catch (e) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<int> getBalances({required String userId}) async {
    final users = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    int balance = 0;
    if (users.exists) {
      balance = users.data()!['balance'];
    }
    return balance;
  }

  Future<void> getUsers({required String uid}) async {
    var checkUsers = await FirebaseFirestore.instance.collection('users').doc(uid).get();

    final users = Users.fromJson(checkUsers.data()!);
    state = users;
  }

  Future<void> updateProfile(Users user) async {
    await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
      'name': user.name,
      'birth': user.birth,
    });

    await getUsers(uid: user.uid.toString());
  }

  Future<String> checkUsers() async {
    final result = FirebaseAuth.instance.currentUser;
    Logger().i(result);
    if (result != null) {
      await getUsers(uid: result.uid);
      return result.uid;
    }
    return '';
  }
}

final authControllerProvider = StateNotifierProvider<AuthController, Users>(
  (ref) => AuthController(),
);
