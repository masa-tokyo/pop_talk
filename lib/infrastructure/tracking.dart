import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:recase/recase.dart';

enum EventType {
  pageView,
  playTalk,
  likeTalk,
  followUser,
  signUp,
  publishTalk,
  draftTalk,
}

class Tracking {
  factory Tracking() => Tracking._instance ??= Tracking._internal();

  Tracking._internal() : _analytics = FirebaseAnalytics();

  static Tracking? _instance;
  final FirebaseAnalytics _analytics;

  void logEvent({
    required EventType eventType,
    Map<String, dynamic>? eventParams,
  }) {
    _analytics.logEvent(
      name: _getEventTypeStr(eventType),
      parameters: eventParams,
    );
  }

  Future<void> pageView(String screenName) async {
    await _analytics.setCurrentScreen(screenName: screenName);
    return logEvent(eventType: EventType.pageView);
  }

  FirebaseAnalyticsObserver getPageViewObserver() {
    // 本来nameExtractorは正しいscreenNameを設定するものだが
    // その後にscreenNameを設定するだけで発火しなそうなので明示的に発火させる
    return FirebaseAnalyticsObserver(
      analytics: _analytics,
      nameExtractor: (settings) {
        final paths = settings.name?.split('?');
        if (paths == null) {
          return null;
        }
        final path = paths.first;
        pageView(path);
        return path;
      },
    );
  }

  Future<void> setUserId(String id) {
    return _analytics.setUserId(id);
  }

  String _getEventTypeStr(EventType eventType) {
    return ReCase(eventType.toString().split('.').last).snakeCase;
  }
}
