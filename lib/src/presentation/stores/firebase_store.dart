import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobx/mobx.dart';
import 'package:the_apple_sign_in/apple_sign_in_button.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

part 'firebase_store.g.dart';

class FirebaseStore = _FirebaseStoreBase with _$FirebaseStore;

abstract class _FirebaseStoreBase with Store {
  final googleSignIn = GoogleSignIn();

  @observable
  GoogleSignInAccount? googleUser;

  @observable
  User? user;

  @observable
  FirebaseAuth auth = FirebaseAuth.instance;

  @observable
  bool isLoading = false;

  @action
  setIsLoading(bool value) => isLoading = value;

  @action
  Future googleLogin(BuildContext context) async {
    isLoading = true;
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      isLoading = false;
      showRequestErrorMessage(
          context, "Erro ao realizar a autenticação com o google");
      return;
    }

    this.googleUser = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await auth.signInWithCredential(credential);

    isLoading = false;
  }

  @action
  Future signAnonymous(BuildContext context) async {
    try {
      isLoading = true;
      UserCredential result = await auth.signInAnonymously();
      isLoading = false;
      user = result.user;
    } catch (e) {
      isLoading = false;
    }
  }

  @action
  Future signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      isLoading = true;
      UserCredential result = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (result.user == null) {
        isLoading = false;
        showRequestErrorMessage(context, "Erro ao autenticar o usuário");
        return;
      }
      user = result.user!;
      isLoading = false;
    } catch (e) {
      isLoading = false;
      showRequestErrorMessage(context, e.toString());
    }
  }

  @action
  Future<bool> checkIfAppleSignInIsAvaliable() async {
    try {
      return await TheAppleSignIn.isAvailable();
    } catch (e) {
      return false;
    }
  }

  @action
  Future signInWithApple(
      {required BuildContext context, List<Scope> scopes = const []}) async {
    final bool isAvaliable = await checkIfAppleSignInIsAvaliable();
    if (!isAvaliable) {
      showRequestErrorMessage(
          context, "O dispositivo não suporta essa operação");
      return;
    }
    final result = await TheAppleSignIn.performRequests(
        [AppleIdRequest(requestedScopes: scopes)]);
    switch (result.status) {
      case AuthorizationStatus.authorized:
        final appleIdCredential = result.credential!;
        final oAuthProvider = OAuthProvider('apple.com');
        final credential = oAuthProvider.credential(
          idToken: String.fromCharCodes(appleIdCredential.identityToken!),
          accessToken:
              String.fromCharCodes(appleIdCredential.authorizationCode!),
        );
        final userCredential = await auth.signInWithCredential(credential);
        user = userCredential.user!;
        if (scopes.contains(Scope.fullName)) {
          final fullName = appleIdCredential.fullName;
          if (fullName != null &&
              fullName.givenName != null &&
              fullName.familyName != null) {
            final displayName = '${fullName.givenName} ${fullName.familyName}';
            await user!.updateDisplayName(displayName); //.updateDisplayName();
          }
        }
        return user;
      case AuthorizationStatus.error:
        showRequestErrorMessage(context, result.error.toString());
        return null;

      case AuthorizationStatus.cancelled:
        showRequestErrorMessage(context, result.error.toString());
        return null;
      default:
        throw UnimplementedError();
    }
  }

  @action
  Future registerWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      isLoading = true;
      UserCredential result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (result.user == null) {
        isLoading = false;
        showRequestErrorMessage(context, "Erro ao salvar o usuário");
        return;
      }
      user = result.user!;
      isLoading = false;
    } catch (e) {
      isLoading = false;
      showRequestErrorMessage(context, e.toString());
    }
  }

  void showRequestErrorMessage(BuildContext context, String message) {
    SnackBar snackBar;

    String errorMessage = message;
    snackBar = SnackBar(
      backgroundColor: Colors.red,
      content: Text(errorMessage),
    );

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
