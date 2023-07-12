import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:suitmedia_mobile_apps/providers/name_provider.dart';
import 'package:suitmedia_mobile_apps/providers/selected_user_provider.dart';
import 'package:suitmedia_mobile_apps/providers/user_provider.dart';
import 'package:suitmedia_mobile_apps/ui/widgets/appbar.dart';

class ThirdScreen extends HookConsumerWidget {
  const ThirdScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncCount = ref.watch(totalUserCountProvider);

    return SafeArea(
      child: Scaffold(
          appBar: appBar(context, 'Third Screen'),
          body: asyncCount.when(
              data: (totalCount) => RefreshIndicator(
                    onRefresh: () async {
                      return ref.invalidate(usersProvider);
                    },
                    child: ListView.separated(
                        itemCount: totalCount,
                        separatorBuilder: (_, index) => const Divider(
                              indent: 20,
                              endIndent: 20,
                            ),
                        itemBuilder: (_, index) => ListItem(index: index)),
                  ),
              error: (err, stacktrace) {
                return const Center(child: Text('error'));
              },
              loading: () => const Center(child: CircularProgressIndicator()))),
    );
  }
}

class ListItem extends ConsumerWidget {
  const ListItem({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncUser = ref.watch(userAtIndexProvider(index));
    final selectedUser = ref.watch(selectedUserProvider);

    return asyncUser.when(
        data: (user) => ListTile(
            selected: user == selectedUser,
            onTap: () => {
                  if (user == selectedUser)
                    {ref.read(selectedUserProvider.notifier).select(null)}
                  else
                    {ref.read(selectedUserProvider.notifier).select(user)}
                },
            title: Text(
              '${user.firstName} ${user.lastName}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(user.email),
            leading: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(user.avatar),
                ))),
        error: (i, j) => const ListTile(
              title: Text('err'),
            ),
        loading: () => const ListTile(
              title: Text('loading'),
            ));
  }
}
