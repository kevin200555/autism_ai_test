
class InstructionAndQuestions {
   //Edit this list to display different instructions to the user, these are used in the video_recording_section
    static final videoInstructions = [
      'I just want to see about how long I could make this one instruction until it starts to look a little werid'
          'I think that it should be fine since there\'s no way one instruction could possibly be too long but I think'
          'it is good to know the limits of this.  More text, More text, More text, More text, More text,More text, More text, More text,More text,'
          'More text, More text, More text, More text, More text, More text,More text, More text,',
      '1. Read this line of instruction out loud\n 2. Jump up and down\n3. Wave to the camera\n4. Clap your hands together',
      'Smile :)',
    ];

    //Edit this list to change the questions for the short answers
    static final shortAnswerQuestions = [
      'What is your favorite color?',
      'How are you doing today?',
      'Really Really Really Really Really Really Really Really Really Really'
          'Really Really Really Really Really Really Really Really Really Really'
          'Really Really Really Really Really Really Really Really Really Really'
          'Really Really Really Really Really Really Really Really Really Really'
          'Really Really Really Really Really Really Really Really long question?',
    ];
    //Edit this list to change the questions and answers for the multipleChoice
    //question is the first list item, answers are the rest of the items
    static final multipleChoice = [
      ['How are you?', 'good', 'ok', 'bad'],
      ['Chicken or Beef?', 'chicken', 'beef'],
      [
        'What is your favorite color',
        'Red',
        'Orange',
        'Yellow',
        'Green',
        'Blue',
        'Purple',
        'Black',
        'White',
        'Brown',
        'Grey',
      ],
    ];
    
    static List<String> getVideoInstructios(){
      return videoInstructions;
    }
    static List<String> getShortAnswerQuestions(){
      return shortAnswerQuestions;
    }
    static List<List<String>> getMultipleChoice(){
      return multipleChoice;
    }
}