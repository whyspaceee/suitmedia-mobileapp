import 'package:aurora/aurora.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:suitmedia_mobile_apps/providers/name_provider.dart';

Function checkPalindrome =
    (String str) => (str == str.split('').reversed.join('')) ? true : false;

class FirstScreen extends HookConsumerWidget {
  FirstScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(nameProvider);

    final nameController = useTextEditingController(text: name);

    final palindromeController = useTextEditingController();

    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          Positioned.fill(
              child: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.centerLeft,
                          colors: [
                Color.fromARGB(255, 140, 187, 168),
                Color.fromARGB(255, 40, 94, 140),
              ])))),
          const Positioned(
              left: -250,
              top: 300,
              child: Aurora(
                size: 600,
                colors: [
                  Color.fromARGB(255, 144, 150, 172),
                  Color.fromARGB(255, 114, 144, 162),
                ],
              )),
          Positioned.fill(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90),
                          color: Colors.white.withOpacity(0.5)),
                      child: const Icon(
                        size: 30,
                        Icons.person_add_alt_1,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(children: [
                        TextFormField(
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          controller: nameController,
                          decoration: const InputDecoration(
                              hintText: 'Name',
                              hintStyle: TextStyle(color: Colors.grey)),
                          validator: (value) => value == null || value.isEmpty
                              ? 'Please enter your name'
                              : null,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          controller: palindromeController,
                          decoration: const InputDecoration(
                              hintText: 'Palindrome',
                              hintStyle: TextStyle(color: Colors.grey)),
                        )
                      ]),
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextButton(
                            onPressed: () {
                              if (checkPalindrome(palindromeController.text)) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Palindrome')));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Not Palindrome')));
                              }
                            },
                            child: const Text('CHECK',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500))),
                        const SizedBox(
                          height: 16,
                        ),
                        TextButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                ref.read(nameProvider.notifier).state =
                                    nameController.text;
                                Navigator.of(context).pushNamed('/second');
                              }
                            },
                            child: const Text(
                              'NEXT',
                            )),
                      ],
                    )
                  ],
                )),
          ),
        ]),
      ),
    );
  }
}
