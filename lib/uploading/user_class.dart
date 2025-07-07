import 'package:camera/camera.dart';

class UserClass {
  final String userId;
  final String mChatRresponses;
  final String intakeResponses;
  final List<XFile> recordedVideos;
  const UserClass(
    this.userId,
    this.mChatRresponses,
    this.intakeResponses,
    this.recordedVideos,
  );
} // EOF user
