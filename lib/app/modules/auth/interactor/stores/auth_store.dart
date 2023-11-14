import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

part 'auth_store.g.dart';

class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {
  final GlobalKey<FormState> keyForm = GlobalKey();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @observable
  bool userLogged = false;
  @action
  setUserLogged(bool value) => userLogged = value;

  @observable
  bool debugError = false;
  @action
  setDebugError(bool value) => debugError = value;

  @action
  Future<void> validateForm() async {
    if (keyForm.currentState!.validate()) {
      if (debugError) setDebugError(false);
      setUserLogged(true);
    } else {
      setDebugError(true);
    }
  }
}
