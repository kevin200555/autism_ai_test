import 'dart:io';
import 'package:autism_ai_test/constants/instruction_and_questions.dart';
import 'package:autism_ai_test/uploading/upload_to_firebase.dart';
import 'package:autism_ai_test/uploading/video_storage_class.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:archive/archive_io.dart';
import 'package:hive/hive.dart';

// Class that stores information about the User
// all variables are static because only one user should be active at a time
// This class is helpful for saving infromation about the user, espicelly if they disconnect or leaef during their
// exam
class UserClass {
  static String? userId;
  // These variables keep track of what screen the user is on, a full detail of this can be seen in main.dart
  static String currentScreen = 'start';
  static int totalScreenNumber = 15;
  // These store all information from the questionaires
  static List<String?>? iCResponses;
  static File? signiture;
  static List<String?>? mChatRresponses;
  static List<String?>? childIntakeResponses;
  static List<String?>? parentIntakeResponses;
  static List<String?>? compensationResponses;

  // These store the videos (size of these could change later)
  /*
  static List<XFile?>? recordedVideos = List<XFile?>.filled(
    InstructionAndQuestions.videoNames.length,
    null,
    growable: false,
  );
  */

  static List<VideoStorageClassItem> videoList = [];

  // This is used after the user has completed the test, since their data should be uploaded to Google Cloud
  // is not needed locally on their mobile device anymore and
  // These need to be updated in case I change anything about the above static variables
  static void resetAll() {
    userId = null;
    currentScreen = 'start';
    totalScreenNumber = 15;
    iCResponses = null;
    signiture = null;
    mChatRresponses = null;
    childIntakeResponses = null;
    parentIntakeResponses = null;
    compensationResponses = null;

    /*
    recordedVideos = List<XFile?>.filled(
      InstructionAndQuestions.videoNames.length,
      null,
      growable: false,
    );
    */
    videoList = [];
    saveToHive();
  }

  // saves all variables in the user class into Hive, this allows information to be sotred in case the user want to
  // leave during the test and come back later
  // This function is called after every 'next' button is pressed
  // This means its NOT being called continously
  static Future<void> saveToHive() async {
    final box = Hive.box('user_data');
    await box.put('userId', userId);
    await box.put('currentScreen', currentScreen);
    await box.put('iCResponses', iCResponses);
    await box.put('mChatRresponses', mChatRresponses);
    await box.put('childIntakeResponses', childIntakeResponses);
    await box.put('parentIntakeResponses', parentIntakeResponses);
    await box.put('compensationResponses', compensationResponses);
    await box.put('signiturePath', signiture?.path);
    await box.put('videoList', videoList);
  }

  // load any saved data that have been stored as result of saveToHive()
  static Future<void> loadFromHive() async {
    final box = Hive.box('user_data');
    userId = box.get('userId');
    currentScreen = box.get('currentScreen') ?? 'main_menu';
    iCResponses = (box.get('iCResponses') as List?)?.cast<String?>();
    mChatRresponses = (box.get('mChatRresponses') as List?)?.cast<String?>();
    childIntakeResponses = (box.get('childIntakeResponses') as List?)
        ?.cast<String?>();
    parentIntakeResponses = (box.get('parentIntakeResponses') as List?)
        ?.cast<String?>();
    compensationResponses = (box.get('compensationResponses') as List?)
        ?.cast<String?>();

    final signPath = box.get('signiturePath');
    if (signPath != null) {
      signiture = File(signPath);
    }

    videoList = [];
    final rawList = box.get(
      'videoList',
      defaultValue: <VideoStorageClassItem>[],
    );
    if (rawList != null) {
      try {
        videoList = (rawList as List).cast<VideoStorageClassItem>();
      } catch (e) {
        if (kDebugMode) print('Failed to cast videoList: $e');
        videoList = [];
      }
    }

    printSummary();
  }

  static bool formCompleted(List<String?>? list) {
    if (list == null || list.isEmpty) return false;

    for (int i = 0; i < list.length; i++) {
      if (list[i] == '' || list[i] == null) {
        return false;
      }
    }

    return true;
  }

  // prints all relevant variables in the UserClass
  static void printSummary() {
    if (kDebugMode) {
      print("User ID: $userId");
      print("Informed Consent Responses: $iCResponses");
      print("Signiture FilePath: ${signiture?.path}");
      print("mChatR Responses: $mChatRresponses");
      print("Child Intake Form Responses: $childIntakeResponses");
      print("Parent Intake Form Responses: $parentIntakeResponses");
      print("Compensation Form Responses: $compensationResponses");
      print("currentScreen:  $currentScreen");
      print("Video List: $videoList");
    }
  }

  static void uploadScreenShot() {
    if (signiture == null) return;
    uploadFile(signiture!.path);
  }

  // function that will take all responses from the the questionaires and turn them into a string,
  // this string will then be written to a file
  // the format of this can be seen in my figma designs
  static Future<void> generateIntakeReport() async {
    List<List<String>> childIntake =
        InstructionAndQuestions.getChildIntakeForm();
    String childIntakeString = '';
    for (int i = 0; i < childIntake.length; i++) {
      childIntakeString += "Q: ${childIntake[i][1]}\n";
      childIntakeString += "A: ${childIntakeResponses?[i]}\n";
    }

    List<List<String>> parentIntake =
        InstructionAndQuestions.getParentIntakeForm();
    String parentIntakeString = '';
    for (int i = 0; i < parentIntake.length; i++) {
      parentIntakeString += "Q: ${parentIntake[i][1]}\n";
      parentIntakeString += "A: ${parentIntakeResponses?[i]}\n";
    }
    String fullIntakeString =
        '--- Child Intake ---\n$childIntakeString\n--- Parent Intake ---\n$parentIntakeString';

    // Get app documents directory
    final directory = await getApplicationDocumentsDirectory();

    // Create a file called intake.txt in the documents directory
    final file = File('${directory.path}/intake.txt');

    // Write the combined intake string to the file
    await file.writeAsString(fullIntakeString);
    await uploadFile(file.path);
  }

  static Future<void> generateCompensationReport() async {
    List<List<String>> compensation = InstructionAndQuestions.getMChatR();
    String cString = '';
    for (int i = 0; i < compensation.length; i++) {
      if (compensation[i][1] == 'Social Security Number: ') {
        cString += "Q: ${compensation[i][1]}\n";
        cString += "Q: ###-###-####";
      } else {
        cString += "Q: ${compensation[i][1]}\n";
        cString += "A: ${mChatRresponses?[i]}\n";
      }
    }
    String fullCString = '--- Compensation ---\n$cString\n';

    // Get app documents directory
    final directory = await getApplicationDocumentsDirectory();

    // Create a file called intake.txt in the documents directory
    final file = File('${directory.path}/compensation.txt');

    // Write the combined intake string to the file
    await file.writeAsString(fullCString);
    await uploadFile(file.path);
  }

  static Future<void> generatemChatRReport() async {
    List<List<String>> mChatR = InstructionAndQuestions.getMChatR();
    String mString = '';
    for (int i = 0; i < mChatR.length; i++) {
      mString += "Q: ${mChatR[i][1]}\n";
      mString += "A: ${mChatRresponses?[i]}\n";
    }
    String fullMString = '--- Compensation ---\n$mString\n';

    // Get app documents directory
    final directory = await getApplicationDocumentsDirectory();

    // Create a file called intake.txt in the documents directory
    final file = File('${directory.path}/mchatr.txt');

    // Write the combined intake string to the file
    await file.writeAsString(fullMString);
    await uploadFile(file.path);
  }

  // makes the user_report.txt file
  static Future<File> get _localFile async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    return File('$path/${userId}_user_report.txt');
  }

  // writes to user_report.txt file
  static Future<File> writeToReportFile(String content) async {
    final file = await _localFile;
    return file.writeAsString(content);
  }

  static Future<void> uploadAllFiles(File userReport) async {
    final directory = await getApplicationDocumentsDirectory();
    final folder = Directory(path.join(directory.path, userId));

    if (!(await folder.exists())) {
      await folder.create(recursive: true);
    }

    // Copy user report
    final userReportDest = File(
      path.join(folder.path, path.basename(userReport.path)),
    );
    await userReport.copy(userReportDest.path);

    // Copy each recorded video (assuming you have (instruction length) and they're not null)

    File? imageFile = File(signiture!.path);
    final imageDest = File(
      path.join(folder.path, path.basename(imageFile.path)),
    );
    await imageFile.copy(imageDest.path);

    final zipFile = await zipFolder(folder);
    final url = await uploadFile(zipFile.path);

    if (url != null) {
      if (kDebugMode) {
        print('Uploaded file URL: $url');
      } // use this to display the file url (good if you need to just look at what's being uploaded)
    }
    if (kDebugMode) {
      print('Saved files to ${folder.path}');
    }
  }

  // to upload data, everything is put in a zipped folder before being uploaded
  static Future<File> zipFolder(Directory folder) async {
    final encoder = ZipFileEncoder();
    final zipPath = path.join(
      folder.parent.path,
      '${path.basename(folder.path)}.zip',
    );
    encoder.create(zipPath);
    encoder.addDirectory(folder);
    encoder.close();
    return File(zipPath);
  }
} // EOF user_class.dart
