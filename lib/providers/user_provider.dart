import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suitmedia_mobile_apps/data/models/paginated_user.dart';
import 'package:suitmedia_mobile_apps/data/models/user_model.dart';
import 'package:suitmedia_mobile_apps/providers/dio_provider.dart';

const perPage = 6;

final usersProvider =
    FutureProvider.family<PaginatedUsers, int>((ref, page) async {
  final dio = ref.watch(dioProvider);

  final response = await dio.get('/api/users',
      queryParameters: {'page': page + 1, 'per_page': perPage});
  if (response.statusCode == 200) {
    return PaginatedUsers.fromJSON(response.data);
  } else {
    throw Exception('Failed to load user');
  }
}, dependencies: [dioProvider]);

final userAtIndexProvider =
    Provider.family<AsyncValue<User>, int>((ref, index) {
  final indexInPage = index % perPage;
  final page = index ~/ perPage;

  final users = ref.watch(usersProvider(page));
  return users.whenData((value) => value.users[indexInPage]);
}, dependencies: [usersProvider]);

final totalUserCountProvider = Provider<AsyncValue<int>>(
    (ref) => ref.watch(usersProvider(0)).whenData((value) => value.total),
    dependencies: [usersProvider]);
