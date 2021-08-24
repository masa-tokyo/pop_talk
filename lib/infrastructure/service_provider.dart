import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:pop_talk/domain/repository/user.dart';
import 'package:pop_talk/infrastructure/repository/dummy/talk_topic.dart';
import 'package:pop_talk/infrastructure/repository/firestore/talk_topic.dart';

Future<bool> registerDIContainer() async {
  await dotenv.load();

  final getIt = GetIt.instance;
  await getIt.reset();
  _registerRepository(getIt);
  return true;
}

void _registerRepository(GetIt getIt) {
  if (dotenv.env['USE_DUMMY_DATA'] == 'true') {
    getIt.registerLazySingleton<TalkTopicRepository>(
      () => DummyTalkTopicRepository(),
    );
  } else {
    getIt.registerLazySingleton<TalkTopicRepository>(
      () => FirestoreTalkTopicRepository(),
    );
  }
}
