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
        '\tb) If s/he doesn\'t respond (is only verbal/doesn\'t turn to you), then wait 5 seconds and try again. If they don\'t respond a 2nd time, then simply proceed to the next step.\n\n'
        '2. Call your child\'s name once. If the child looks at you, smile and wave and say “Hi!” in a happy voice.\n'
        '\ta) If your child responds to your wave, you can interact with him/her as you would typically.\n'
        '\tb) If your child does not respond to your wave, that\'s OK.',

    // Task 2
    '1. Position yourself 5-10 feet from your child. In a happy tone, call your child\'s name (“Hey Billy!”)\n'
        '\ta) If s/he looks in your direction/makes eye contact, smile at them and make a silly face (stick out tongue), record his/her response.\n'
        '\tb) If s/he doesn\'t respond (is only verbal/doesn\'t turn to you), wait 5 seconds and try again. If they don\'t respond a 2nd time, face them and make a silly face (be sure not to block them from the camera view). It\'s ok if your child does not respond.',

    // Task 3
    '1. Position yourself 5-10 feet from your child and place the bear between you and the child. In a happy tone, call your child\'s name (“Hey Billy!”)\n'
        '\ta) If s/he looks in your direction/makes eye contact, smile at them and go to the next step.\n'
        '\tb) If s/he doesn\'t respond (is only verbal/doesn\'t turn to you), then wait 5 seconds and try again.\n'
        '\t   Don\'t try a 3rd time; proceed to the next step.\n\n'
        '2. Point and look at the bear and ask, "What\'s that?" (Use exact sentence and only ask once!)\n'
        '\tContinue looking and pointing at the bear but keep the camera on the child, and continue recording for at least 30 sec. If the child responds, you can interact with him/her normally.',

    // Task 4
    '1. Position yourself 5-10 feet from your child and place the bear near your child. In a happy tone, call your child\'s name (“Hey Billy!”).\n'
        '\ta) If s/he looks in your direction/makes eye contact, smile at them and go to the next step.\n'
        '\tb) If s/he doesn\'t respond (is only verbal/doesn\'t turn to you), then wait 5 seconds and try again.\n'
        '\t   Don\'t try a 3rd time; proceed to the next step.\n\n'
        '2. Say, "Bring me the bear" (use exact sentence and only ask once). If they respond, interact with the child.',

    // Task 5
    '1. Position yourself 5-10 feet from your child. In a happy tone, call your child\'s name (“Hey Billy!”).\n'
        '\ta) If s/he looks in your direction/makes eye contact, smile at them and go to the next step.\n'
        '\tb) If s/he doesn\'t respond (is only verbal/doesn\'t turn to you), then wait 5 seconds and try again.\n'
        '\t   Don\'t try a 3rd time; proceed to the next step.\n\n'
        '2. Hold up 2 snacks the child likes which are beyond his/her reach, and ask "Which would you like to eat?" (Use this exact sentence and ask only once).\n'
        '\ta) If the child responds, just continue interaction with him/her.\n'
        '\tb) If the child does not respond, it is ok.',

    // Task 6
    '1. Position yourself 5-10 feet from your child and place the bear between you and the child. In a happy tone, call your child\'s name (“Hey Billy!”)\n'
        '\ta) If s/he looks in your direction/makes eye contact, smile at them and go to the next step.\n'
        '\tb) If s/he doesn\'t respond (is only verbal/doesn\'t turn to you), then wait 5 seconds and try again.\n'
        '\t   Don\'t try a 3rd time; proceed to the next step.\n\n'
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
        '\tb) If s/he doesn\'t respond (is only verbal/doesn\'t turn to you), then wait 5 seconds and try again.\n'
        '\t   Don\'t try a 3rd time; proceed to the next step.\n\n'
        '2. When the child is holding something ask, "What do you have?" (exact phrase/ask only once)\n'
        '\ta) If the child responds, record the child\'s response, and interact with the child. If the child does not respond, it is ok.',

    // Task 9
    '1. Position yourself 5-10 feet from your child. In a happy tone, call your child\'s name (“Hey Billy!”).\n'
        '\ta) If s/he looks in your direction/makes eye contact, smile at them and go to the next step.\n'
        '\tb) If s/he doesn\'t respond (is only verbal/doesn\'t turn to you), then wait 5 seconds and try again.\n'
        '\t   Don\'t try a 3rd time; proceed to the next step.\n\n'
        '2. Say, "Look, I have bubbles!" Then blow bubbles 3 times for the child, then stop blowing bubbles and pretend to ignore the child.\n'
        '\ta) If s/he requests bubbles in any way or tries to get your attention, blow more bubbles, and continue to interact with your child.\n'
        '\tb) If s/he never requests bubbles or tries to get your attention after 30 seconds, just end the bubbles task. Again, not all children like bubbles and not all kids will respond.',
  ];

  //This List contains the SAQ and MCQ for the "Intake Form for Autism Video Project"
  static final List<List<String>> autismIntakeForm = [
    ['SAQ', 'What is your child\'s full name?'],
    ['SAQ', 'What is your child\'s middle name? (Enter N/A if not applicable)'],
    ['SAQ', 'What is your child\'s last name?'],
    ['SAQ', 'What is their date of birth? (MM/DD/YYYY)'],
    ['MCQ', 'What is their gender?', 'Male', 'Female'],
    ['SAQ', 'What is the date of their Diagnosis?'],
    [
      'MCQ',
      'Has your child received any type of psychiatric diagnosis',
      'yes',
      'no',
    ],
    [
      'MCQ',
      'Does your child received any visual impairment that cannot be corrected?',
      'yes',
      'no',
    ],
    ['MCQ', 'Does your child have severe hearing loss', 'yes', 'no'],
    [
      'MCQ',
      'Child\'s Race',
      'White',
      'Asian',
      'American Indian/Alaska Native',
      'Native Hawaiian/Other Pacific Islander',
      'Unknown or not reported',
    ],
    ['MCQ', 'Child\'s Ethnicity', 'Hispanic', 'Not Hispanic'],
    [
      'MCQ',
      'Household Income',
      'less than \$24,999',
      '\$25,000 - 34,999',
      '\$35,000 - 49,999',
      '\$50,000 - 74,999',
      '\$75,000 - 99,999',
      '\$100,000 - 149,999',
      '\$150,000 - 199,999',
      'over \$200,000',
      'Do not wish to say',
    ],
    ['SAQ', 'What is the Parent/Guardian\'s first Name'],
    [
      'SAQ',
      'What is the Parent/Guardian\'s Middle Name (Enter N/A if not applicable)',
    ],
    ['SAQ', 'What is the Parent/Guardian\'s Last Name?'],
    ['SAQ', 'What is the Parent/Guardian\'s Cell Phone?'],
    ['SAQ', 'What is the Parent/Guardian\'s Home Phone?'],
    ['SAQ', 'What is the Parent/Guardian\'s E-mail address?'],
    ['SAQ', 'Street Addresss'],
    ['SAQ', 'City'],
    ['SAQ', 'State'],
    ['SAQ', 'Zip Code'],
    [
      'SAQ',
      'What is Parent/Guardian\'s Relationship to Child',
      'Mother',
      'Father',
      'Guardian',
    ],
  ];

  static final List<List<String>> mChatRQuestions = [
    [
      'MCQ',
      'If you point at something across the room, does your child look at it?',
      'yes',
      'no',
    ],
    ['MCQ', 'Have you ever wondered if your child might be deaf?', 'yes', 'no'],
    [
      'MCQ',
      'Does your child play pretend or make-believe? (e.g., pretend to drink from an empty cup or feed a doll)',
      'yes',
      'no',
    ],
    [
      'MCQ',
      'Does your child like climbing on things? (e.g., furniture, playground equipment, or stairs)',
      'yes',
      'no',
    ],
    [
      'MCQ',
      'Does your child make unusual finger movements near his or her eyes?',
      'yes',
      'no',
    ],
    [
      'MCQ',
      'Does your child point with one finger to ask for something or to get help?',
      'yes',
      'no',
    ],
    [
      'MCQ',
      'Does your child point with one finger to show you something interesting?',
      'yes',
      'no',
    ],
    [
      'MCQ',
      'Is your child interested in other children? (e.g., watching, smiling at, or approaching them)',
      'yes',
      'no',
    ],
    [
      'MCQ',
      'Does your child show you things to share them (not to get help)? (e.g., holding up a toy or flower)',
      'yes',
      'no',
    ],
    [
      'MCQ',
      'Does your child respond when you call his or her name? (e.g., looks up, babbles, or stops what they are doing)',
      'yes',
      'no',
    ],
    [
      'MCQ',
      'When you smile at your child, does he or she smile back at you?',
      'yes',
      'no',
    ],
    [
      'MCQ',
      'Does your child get upset by everyday noises? (e.g., cries at a vacuum cleaner or loud music)',
      'yes',
      'no',
    ],
    ['MCQ', 'Does your child walk?', 'yes', 'no'],
    [
      'MCQ',
      'Does your child look you in the eye when talking, playing, or during care?',
      'yes',
      'no',
    ],
    [
      'MCQ',
      'Does your child try to copy what you do? (e.g., wave bye-bye, clap, or mimic sounds)',
      'yes',
      'no',
    ],
    [
      'MCQ',
      'If you turn your head to look at something, does your child look to see what you\'re looking at?',
      'yes',
      'no',
    ],
    [
      'MCQ',
      'Does your child try to get you to watch him or her? (e.g., looks for praise or says "look" or "watch me")',
      'yes',
      'no',
    ],
    [
      'MCQ',
      'Does your child understand verbal instructions without gestures? (e.g., "put the book on the chair")',
      'yes',
      'no',
    ],
    [
      'MCQ',
      'If something new happens, does your child look at your face to see your reaction?',
      'yes',
      'no',
    ],
    [
      'MCQ',
      'Does your child enjoy movement activities? (e.g., swinging or being bounced on your knee)',
      'yes',
      'no',
    ],
  ];

  static List<String> getVideoInstructios() {
    return videoInstructions;
  }

  static List<List<String>> getIntakeForm() {
    return autismIntakeForm;
  }
  
  static List<List<String>> getMChatR() {
    return mChatRQuestions;
  }

  static List<String> getVideoNames() {
    return videoNames;
  }
}
//EOF instruction_and_questions.dart