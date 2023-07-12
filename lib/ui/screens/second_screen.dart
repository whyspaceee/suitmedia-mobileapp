import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suitmedia_mobile_apps/data/models/user_model.dart';
import 'package:suitmedia_mobile_apps/providers/name_provider.dart';
import 'package:suitmedia_mobile_apps/providers/selected_user_provider.dart';
import 'package:suitmedia_mobile_apps/ui/widgets/appbar.dart';

class SecondScreen extends ConsumerWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    User? user = ref.watch(selectedUserProvider);

    return SafeArea(
      child: Scaffold(
        appBar: appBar(
          context,
          'Second Screen',
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Welcome'),
                    Text(
                      ref.watch(nameProvider),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ],
                ),
                user != null
                    ? Text(
                        '${user.firstName} ${user.lastName}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      )
                    : const Text(
                        textAlign: TextAlign.center,
                        'No User Selected',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/third');
                    },
                    child: const Text('Choose A User')),
              ]),
        ),
      ),
    );
  }
}
