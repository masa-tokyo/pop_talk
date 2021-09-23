import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pop_talk/domain/model/authed_user.dart';
import 'package:pop_talk/presentation/notifier/auth.dart';
import 'package:pop_talk/presentation/notifier/my_talk.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({
    Key? key,
    required this.authedUser,
  }) : super(key: key);
  final AuthedUser authedUser;

  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final _form = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.authedUser.name;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 30, left: 10),
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.close,
                  size: 30,
                ),
              ),
            ),
            const SizedBox(height: 160),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.black12,
                    backgroundImage: const AssetImage(
                      'assets/images/default_avatar.png',
                    ),
                    child: ClipOval(
                      child: Image.network(
                        widget.authedUser.photoUrl,
                        fit: BoxFit.fill,
                        errorBuilder: (c, o, s) {
                          return const Icon(
                            Icons.error,
                            color: Colors.red,
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 24),
                        child: Text(
                          '名前（ニックネーム）',
                          style: TextStyle(
                            fontSize:
                                Theme.of(context).textTheme.headline3!.fontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Form(
                        key: _form,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: TextFormField(
                            controller: _nameController,
                            maxLines: 1,
                            maxLength: 10,
                            keyboardType: TextInputType.text,
                            style: const TextStyle(fontSize: 24),
                            decoration: const InputDecoration(),
                            validator: (value) {
                              if (value!.isEmpty || value.trim().isEmpty) {
                                return '名前（ニックネーム）を入力してください';
                              }
                            },
                            onChanged: (_) {
                              if (_form.currentState!.validate()) {
                                _form.currentState!.save();
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Consumer(builder: (_, watch, __) {
              return TextButton(
                onPressed: () async {
                  if (_form.currentState!.validate()) {
                    await watch(authProvider).changeUserName(
                      widget.authedUser,
                      _nameController.text,
                    );
                    Navigator.of(context).pop();
                  }
                },
                style: TextButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 40,
                  ),
                ),
                child: Text(
                  '保存する',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.white),
                ),
              );
            }),
            const SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }
}
