import 'package:get_it/get_it.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pop_talk/domain/repository/authed_user.dart';
import 'package:pop_talk/domain/repository/talk_topic.dart';
import 'package:pop_talk/domain/repository/talk_item.dart';
import 'package:pop_talk/infrastructure/repository/dummy/authed_user.dart';
import 'package:pop_talk/infrastructure/repository/dummy/talk_topic.dart';
import 'package:pop_talk/infrastructure/repository/dummy/talk_item.dart';
import 'package:pop_talk/infrastructure/repository/firestore/authed_user.dart';
import 'package:pop_talk/infrastructure/repository/firestore/talk_topic.dart';
import 'package:pop_talk/infrastructure/repository/firestore/talk_item.dart';

Future<bool> registerDIContainer() async {
  await dotenv.load();
  final getIt = GetIt.instance;
  await getIt.reset();
  _registerRepository(getIt);
  return true;
}

void _registerRepository(GetIt getIt) {
  if (dotenv.env['USE_DUMMY_DATA'] == 'true') {
    getIt
      ..registerLazySingleton<TalkTopicRepository>(
        () => DummyTalkTopicRepository(),
      )
      ..registerLazySingleton<AuthedUserRepository>(
        () => DummyAuthedUserRepository(),
      )
      ..registerLazySingleton<TalkItemRepository>(
          () => DummyTalkItemRepository());
  } else {
    getIt
      ..registerLazySingleton<TalkTopicRepository>(
        () => FirestoreTalkTopicRepository(),
      )
      ..registerLazySingleton<AuthedUserRepository>(
        () => FirestoreAuthedUserRepository(),
      )
      ..registerLazySingleton<TalkItemRepository>(
          () => FirestoreTalkItemRepository());
  }
}
