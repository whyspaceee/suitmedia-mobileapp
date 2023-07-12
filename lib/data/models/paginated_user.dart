import 'package:suitmedia_mobile_apps/data/models/user_model.dart';

class PaginatedUsers {
  const PaginatedUsers({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.users,
  });

  final int page;
  final int perPage;
  final int total;
  final int totalPages;
  final List<User> users;

  factory PaginatedUsers.fromJSON(Map<String, dynamic> json) {
    final users =
        (json['data'] as List).map((user) => User.fromJSON(user)).toList();

    return PaginatedUsers(
        page: json['page'],
        perPage: json['per_page'],
        total: json['total'],
        totalPages: json['total_pages'],
        users: users);
  }
}
