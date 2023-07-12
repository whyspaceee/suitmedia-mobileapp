import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suitmedia_mobile_apps/data/models/user_model.dart';

final selectedUserProvider =
    NotifierProvider<SelectedUser, User?>(SelectedUser.new);

class SelectedUser extends Notifier<User?> {
  @override
  build() {
    return null;
  }

  void select(User? user) {
    state = user;
  }
}
