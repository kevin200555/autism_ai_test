//class to store the instructions and questions given to the user
//change as needed
class InstructionAndQuestions {
  //Edit this list to display different instructions to the user, these are used in the video_recording_section
  static final List<String> videoNames = [
    'Toy Interaction',
    'Snack Time',
    'Free Play',
  ];
  //These are the instructions for the video_recording_scection, The user reads these and then records.
  static final List<String> videoInstructions = [
// Task 1: ToyInteraction
    '''
1. Set up
\tChoose a toy your child likes that can be used for pretend feeding (e.g., a stuffed animal or doll).
\tPlace the toy on the floor—either between you and your child, or near your child—depending on the moment.
\tStand or sit about 5-10 feet away and, in a cheerful tone, call your child's name (e.g., “Hey Billy!”).
\t\t• If your child looks at you or makes eye contact, smile and continue.
\t\t• If they don't respond, wait 5 seconds and try again. Do not call more than twice.

2. Ask: “What's that?”
\tPoint to the toy and ask, “What's that?” (say it exactly once).
\tKeep pointing and looking at the toy, but make sure the camera stays on the child.
\tIf they respond, interact naturally. Record for at least 30 seconds.

3. Ask: “Bring me the toy”
\tNext, ask “Bring me the toy” (say it exactly once).
\tIf the child brings it to you, interact normally. If not, it's okay—just keep recording.

4. Pretend feeding
\tHold a spoon and say, “The toy is hungry, what should we do?”
\t\t• If your child responds, follow their lead and keep recording for at least 30 seconds.
\t\t• If no response after 5 seconds, ask: “Should we feed the toy?”
\t\t• If still no response, pretend to feed the toy with the spoon, then offer the spoon to your child. If they don't feed the toy, that's totally fine.
''',
// Task 2: Snack time
    '''
1. Set up
\tPrepare two snacks your child likes and place them out of the child's reach.
\tStand or sit about 5-10 feet away. In a cheerful tone, call your child[s name (e.g., “Hey Billy!”).
\t\t• If your child looks at you or makes eye contact, smile and continue.
\t\t• If they don't respond, wait 5 seconds and try calling once more. Don't call more than twice.

2. Offer the snacks
\tHold up both snacks where your child can see them and ask once: “Which would you like to eat?”
\t\t• If your child responds (by pointing, talking, reaching, etc.), you can interact naturally and give them the snack.
\t\t• If they don't respond, that's totally fine—just keep recording.
''',
//Task 3: Free Play
    '''
1. Free play
\tLet your child play freely with their favorite toys for at least 3 minutes.
\tYou don't need to talk or interact—just record them playing naturally.
\tYou can hold the phone or place it somewhere stable. Since your child may move around, try to keep their full body and face in the video as much as possible.

2. Natural prompt
\tWhen your child is holding or playing with something, stand about 5-10 feet away and cheerfully call their name (e.g., “Hey Billy!”).
\t\t• If they look at you or make eye contact, move to the next step.
\t\t• If they don't respond, wait 5 seconds and try calling once more. Don't call more than twice.
\tThen ask once: “What do you have?”
\tIt's okay if your child doesn't respond—just keep recording.
''',
  ];

  // This 2D List contains the SAQ and MCQ for the "Intake Form for Autism Video Project"
  // There are (3) different types of questions
  // So I decided to organize them in this way:
  // each question is a 2D List, the first item specifices what type of question it is: MCQ, SAQ, etc
  // the next items in the list are relevant to the question itself, like question name and answer choices.
  // The List items are then passed into the ListView builder and based on the first element in a list, the correct widget
  // can be assigned to build the question
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
  // This 2D List contains the SAQ and MCQ for the mChat-R form
  // or the Modified Checklist for autism in toddlers (Revised)
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
  // This 2D List contains the SAQ and MCQ for the "Autism_Video_Informed_Consent" document 
  static final List<List<String>> iCQuestions = [
    ['MCQ', 'Do you agree to allow us to send your health information via email?', 'yes', 'no'],
    ['MCQ', 'Do you agree to allow us to send your health information via text?', 'yes', 'no'],
    ['SAQ', 'Child\'s name - printed'],
    ['SAQ', 'Date (MM/DD/YYYY)'],
    ['SQ', 'Signiture of Parent/Guardian'],
    ['SAQ', 'Name of Parent/Guardian - printed'],
    ['SAQ', 'Relationship to paticipant - printed'],
    ['SQ', 'Signiture of Person who Obtained Consetn'],
    ['SAQ', 'Name of Person who Obtained Consent - printed']
  ];
  
  //accessors (not strictly nesscessary, but I have them)
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

  static List<List<String>> getIC() {
    return iCQuestions;
  }
} //EOF instruction_and_questions.dart