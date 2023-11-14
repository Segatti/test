import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

part 'auth_store.g.dart';

class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {
  final GlobalKey<FormState> keyForm = GlobalKey();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @observable
  bool debugError = false;
  @action
  setDebugError(bool value) => debugError = value;

  @action
  Future<bool> validateForm() async {
    if (keyForm.currentState!.validate()) {
      if (debugError) setDebugError(false);
      return true;
    } else {
      setDebugError(true);
      return false;
    }
  }
}
