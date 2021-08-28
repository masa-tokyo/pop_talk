import 'package:audio_service/audio_service.dart';
import 'package:get_it/get_it.dart';
import 'package:pop_talk/domain/repository/playlist.dart';
import 'package:pop_talk/infrastructure/audio_handler.dart';
import 'package:pop_talk/infrastructure/repository/dummy/playlist.dart';
import 'package:pop_talk/presentation/notifier/player.dart';

GetIt getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // services
  getIt.registerSingleton<AudioHandler>(await initAudioService());
  getIt.registerLazySingleton<PlaylistRepository>(() => DemoPlaylist());

  // page state
  getIt.registerLazySingleton<PageManager>(() => PageManager());
}
