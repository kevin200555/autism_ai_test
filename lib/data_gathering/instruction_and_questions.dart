//class to store the instructions and questions given to the user
//change as needed
class InstructionAndQuestions {
  //Edit this list to display different instructions to the user, these are used in the video_recording_section
  static final List<String> videoNames = [
    'Hi!',
    'Silly Face',
    'What\'s that?',
    'Bring me the bear',
    'Snack time',
    'Feeding the beaer',
    'Free playing',
    'What do you hear?',
    'Bubbles',
  ];
  static final List<String> videoInstructions = [
    // Task 1
    '1. Position yourself 5-10 feet from your child. In a happy tone, call your child\'s name (“Hey Billy!”)\n'
        '\ta) If s/he looks in your direction/makes eye contact, smile at them and go to the next step.\n'
        '\tb) If s/he doesn’t respond (is only verbal/doesn’t turn to you), then wait 5 seconds and try again. If they don’t respond a 2nd time, then simply proceed to the next step.\n\n'
        '2. Call your child\'s name once. If the child looks at you, smile and wave and say “Hi!” in a happy voice.\n'
        '\ta) If your child responds to your wave, you can interact with him/her as you would typically.\n'
        '\tb) If your child does not respond to your wave, that\'s OK.',

    // Task 2
    '1. Position yourself 5-10 feet from your child. In a happy tone, call your child\'s name (“Hey Billy!”)\n'
        '\ta) If s/he looks in your direction/makes eye contact, smile at them and make a silly face (stick out tongue), record his/her response.\n'
        '\tb) If s/he doesn’t respond (is only verbal/doesn’t turn to you), wait 5 seconds and try again. If they don’t respond a 2nd time, face them and make a silly face (be sure not to block them from the camera view). It\'s ok if your child does not respond.',

    // Task 3
    '1. Position yourself 5-10 feet from your child and place the bear between you and the child. In a happy tone, call your child\'s name (“Hey Billy!”)\n'
        '\ta) If s/he looks in your direction/makes eye contact, smile at them and go to the next step.\n'
        '\tb) If s/he doesn’t respond (is only verbal/doesn’t turn to you), then wait 5 seconds and try again.\n'
        '\t   Don’t try a 3rd time; proceed to the next step.\n\n'
        '2. Point and look at the bear and ask, "What\'s that?" (Use exact sentence and only ask once!)\n'
        '\tContinue looking and pointing at the bear but keep the camera on the child, and continue recording for at least 30 sec. If the child responds, you can interact with him/her normally.',

    // Task 4
    '1. Position yourself 5-10 feet from your child and place the bear near your child. In a happy tone, call your child\'s name (“Hey Billy!”).\n'
        '\ta) If s/he looks in your direction/makes eye contact, smile at them and go to the next step.\n'
        '\tb) If s/he doesn’t respond (is only verbal/doesn’t turn to you), then wait 5 seconds and try again.\n'
        '\t   Don’t try a 3rd time; proceed to the next step.\n\n'
        '2. Say, "Bring me the bear" (use exact sentence and only ask once). If they respond, interact with the child.',

    // Task 5
    '1. Position yourself 5-10 feet from your child. In a happy tone, call your child\'s name (“Hey Billy!”).\n'
        '\ta) If s/he looks in your direction/makes eye contact, smile at them and go to the next step.\n'
        '\tb) If s/he doesn’t respond (is only verbal/doesn’t turn to you), then wait 5 seconds and try again.\n'
        '\t   Don’t try a 3rd time; proceed to the next step.\n\n'
        '2. Hold up 2 snacks the child likes which are beyond his/her reach, and ask "Which would you like to eat?" (Use this exact sentence and ask only once).\n'
        '\ta) If the child responds, just continue interaction with him/her.\n'
        '\tb) If the child does not respond, it is ok.',

    // Task 6
    '1. Position yourself 5-10 feet from your child and place the bear between you and the child. In a happy tone, call your child\'s name (“Hey Billy!”)\n'
        '\ta) If s/he looks in your direction/makes eye contact, smile at them and go to the next step.\n'
        '\tb) If s/he doesn’t respond (is only verbal/doesn’t turn to you), then wait 5 seconds and try again.\n'
        '\t   Don’t try a 3rd time; proceed to the next step.\n\n'
        '2. Say "The bear is hungry, what should we do?" (Use the exact sentence.)\n'
        '\ta) If child responds, just continue interaction with him/her and record for at least 30 sec until he/she loses interest in feeding bear.\n'
        '\tb) If no response after 5 seconds, ask "should we feed the bear?" (Use the exact sentence.) If no response after 5 seconds, pretend to feed the bear with a spoon and give the spoon to the child.\n'
        '\t   If s/he does not feed the bear, that\'s OK.',

    // Task 7
    '1. Place the bear, bubbles (if age appropriate), or other favorite toys where s/he can reach them.\n'
        '2. Record him/her playing for at least 3 minutes even if it is not with these specific toys. You do NOT need to call out to the child like in the other tasks, just let them play freely. (You do not need to be in this video, unless your child is too distracted by you recording.)\n'
        '3. Please try to keep your child\'s whole body and face in the video screen as much as possible, since they may walk around, you might put the phone camera in a relatively high place and keep certain distance to record the whole playing.',

    // Task 8
    '1. Position yourself 5-10 feet from your child. In a happy tone, call your child\'s name (“Hey Billy!”).\n'
        '\ta) If s/he looks in your direction/makes eye contact, smile at them and go to the next step.\n'
        '\tb) If s/he doesn’t respond (is only verbal/doesn’t turn to you), then wait 5 seconds and try again.\n'
        '\t   Don’t try a 3rd time; proceed to the next step.\n\n'
        '2. When the child is holding something ask, "What do you have?" (exact phrase/ask only once)\n'
        '\ta) If the child responds, record the child\'s response, and interact with the child. If the child does not respond, it is ok.',

    // Task 9
    '1. Position yourself 5-10 feet from your child. In a happy tone, call your child\'s name (“Hey Billy!”).\n'
        '\ta) If s/he looks in your direction/makes eye contact, smile at them and go to the next step.\n'
        '\tb) If s/he doesn’t respond (is only verbal/doesn’t turn to you), then wait 5 seconds and try again.\n'
        '\t   Don’t try a 3rd time; proceed to the next step.\n\n'
        '2. Say, "Look, I have bubbles!" Then blow bubbles 3 times for the child, then stop blowing bubbles and pretend to ignore the child.\n'
        '\ta) If s/he requests bubbles in any way or tries to get your attention, blow more bubbles, and continue to interact with your child.\n'
        '\tb) If s/he never requests bubbles or tries to get your attention after 30 seconds, just end the bubbles task. Again, not all children like bubbles and not all kids will respond.',
  ];

  //Edit this list to change the questions for the short answers
  static final autismIntakeForm = [
    ['SAQ', 'What is your child\'s full name?'],
    ['SAQ','What is your child\'s middle name? (if they have one)'],
    ['SAQ', 'What is your child\'s last name?'],
    ['SAQ','What is their date of birth? (MM/DD/YYYY)'],
    ['MCQ', 'What is their gender?', 'Male', 'Female'],
  ];

  static final autismIntakeForm2 = [
    ['What is your Child\'s Gender?','Male','Female'],
    ['Autism Diagnosis','Diagnosed with Autism','Autism suspected, but no formal diagnosis','No known/suspected autism diagnosis']
  ];

  static final autismIntakeForm3 = [];

  static List<String> getVideoInstructios() {
    return videoInstructions;
  }
  static List<List<String>> getIntakeForm(){
    return autismIntakeForm;
  }

}
//EOF instruction_and_questions.dart