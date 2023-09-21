import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../firebase references/firebase_refs.dart';

Future<String?> signUpWithEmailAndPassword(
    String email, String password) async {
  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return userCredential.user!.uid;
  } catch (e) {
    debugPrint('Exception Found: $e');
    return null;
  }
}

Future<void> saveUserDetails(
    String? uid, String firstName, String lastName, String position) async {
  try {
    await userColRef.doc(uid).set({
      'firstName': firstName,
      'lastName': lastName,
      'position': position,
      'Future Self': '',
      'Hobbies': '',
      'Interesting Facts': '',
      'EXP': 0,
      'Level': 1,
      'MaxEXP': 150,
      'firstlog': true,
      'iconColor': '#ff6600',
      'introduced': false,
      'selectedIcon': 'person',
    });

    //Creating a General Checklist collection specific to the user to have it more specific to the user
    //Also making it easier for the user to add tasks specific to them and tracking completion easier.
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('General Checklist')
        .doc('List')
        .set({
      'Book onboarding checkpoint with Manager for Day 5': false,
      'Catch up with buddy': false,
      'Identify Buddy': false,
      'Machine setup': false,
      'Meet your Scrum Team': false,
      'Onboarding Checkpoint with Manager': false,
      'Provide feedback on onboarding process': false,
      'Request access to UVMS dashboard': false,
      'Request access to VersionOne (V1)': false,
      'Request to join Product Development Distribution Group': false,
      'Scrum Team Induction': false,
    });

    initialiseOrientationTasks(uid);
    initialiseCCTasks(uid);
    initialiseComplianceTasks(uid);
    initialiseHSTasks(uid);
  } catch (e) {
    debugPrint('Exception Found: $e');
  }
}

//Used to initialise Orientation-Related Tasks
Future<void> initialiseOrientationTasks(String? uid) async {
  try {
    //Creating Orientation-related Quiz Task field (Specific to user to make tracking progress easier to implement)
    //Default Q1
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Orientation')
        .collection('Quiz')
        .doc('quiz_task_1')
        .set({
      'description': 'Quiz on Harry Potter',
      'title': 'Harry Potter',
      'question_count': 5,
      'quiz_duration': 60,
      'image_url': 'Harry Potter',
      'exp': 20,
      'exp_gained': false,
    });
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Orientation')
        .collection('Quiz')
        .doc('quiz_task_1')
        .collection('questions')
        .doc('q1')
        .set({
      'question': "What happens when the Dursley's take Harry to the Zoo",
      'correct_answer': '2',
    });
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Orientation')
        .collection('Quiz')
        .doc('quiz_task_1')
        .collection('questions')
        .doc('q1')
        .collection('options')
        .doc('1')
        .set({
      'answer': "Nothing, Harry never went to the Zoo.",
      'identifier': '1',
    });
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Orientation')
        .collection('Quiz')
        .doc('quiz_task_1')
        .collection('questions')
        .doc('q1')
        .collection('options')
        .doc('2')
        .set({
      'answer': "Harry makes the glass in the snake enclosure vanish.",
      'identifier': '2',
    });
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Orientation')
        .collection('Quiz')
        .doc('quiz_task_1')
        .collection('questions')
        .doc('q1')
        .collection('options')
        .doc('2')
        .set({
      'answer': "Harry and Dudley get ice cream.",
      'identifier': '3',
    });
//Default Q2
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Orientation')
        .collection('Quiz')
        .doc('quiz_task_1')
        .collection('questions')
        .doc('q2')
        .set({
      'question':
          "What did Harry's paternal grandfather develop that quadrupled  the Potter family wealth",
      'correct_answer': '2',
    });
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Orientation')
        .collection('Quiz')
        .doc('quiz_task_1')
        .collection('questions')
        .doc('q2')
        .collection('options')
        .doc('1')
        .set({
      'answer': "Wizard's Sculpting Gel.",
      'identifier': '1',
    });
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Orientation')
        .collection('Quiz')
        .doc('quiz_task_1')
        .collection('questions')
        .doc('q2')
        .collection('options')
        .doc('2')
        .set({
      'answer': "Sleekeazy's Hair Potion.",
      'identifier': '2',
    });
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Orientation')
        .collection('Quiz')
        .doc('quiz_task_1')
        .collection('questions')
        .doc('q2')
        .collection('options')
        .doc('3')
        .set({
      'answer': "Polyjuice Potion.",
      'identifier': '3',
    });
    //Default Q3
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Orientation')
        .collection('Quiz')
        .doc('quiz_task_1')
        .collection('questions')
        .doc('q3')
        .set({
      'question': "Where did Harry's Mom, Lily Evans, grow up?",
      'correct_answer': '2',
    });
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Orientation')
        .collection('Quiz')
        .doc('quiz_task_1')
        .collection('questions')
        .doc('q3')
        .collection('options')
        .doc('1')
        .set({
      'answer': "Godric's Hollow.",
      'identifier': '1',
    });
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Orientation')
        .collection('Quiz')
        .doc('quiz_task_1')
        .collection('questions')
        .doc('q3')
        .collection('options')
        .doc('2')
        .set({
      'answer': "Cokesworth.",
      'identifier': '2',
    });
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Orientation')
        .collection('Quiz')
        .doc('quiz_task_1')
        .collection('questions')
        .doc('q3')
        .collection('options')
        .doc('3')
        .set({
      'answer': "Hogsmeade.",
      'identifier': '3',
    });
    //Default Q4
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Orientation')
        .collection('Quiz')
        .doc('quiz_task_1')
        .collection('questions')
        .doc('q4')
        .set({
      'question': "How many Unforgiveable Curses are there?",
      'correct_answer': '3',
    });
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Orientation')
        .collection('Quiz')
        .doc('quiz_task_1')
        .collection('questions')
        .doc('q4')
        .collection('options')
        .doc('1')
        .set({
      'answer': "1",
      'identifier': '1',
    });
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Orientation')
        .collection('Quiz')
        .doc('quiz_task_1')
        .collection('questions')
        .doc('q4')
        .collection('options')
        .doc('2')
        .set({
      'answer': "2",
      'identifier': '2',
    });
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Orientation')
        .collection('Quiz')
        .doc('quiz_task_1')
        .collection('questions')
        .doc('q4')
        .collection('options')
        .doc('3')
        .set({
      'answer': "3",
      'identifier': '3',
    });
    //Default Q5
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Orientation')
        .collection('Quiz')
        .doc('quiz_task_1')
        .collection('questions')
        .doc('q5')
        .set({
      'question':
          "What Wizarding School was founded by a descendant of Salazar Slytherin?",
      'correct_answer': '3',
    });
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Orientation')
        .collection('Quiz')
        .doc('quiz_task_1')
        .collection('questions')
        .doc('q5')
        .collection('options')
        .doc('1')
        .set({
      'answer': "Durmstrang Institute",
      'identifier': '1',
    });
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Orientation')
        .collection('Quiz')
        .doc('quiz_task_1')
        .collection('questions')
        .doc('q5')
        .collection('options')
        .doc('2')
        .set({
      'answer': "Castelobruxo",
      'identifier': '2',
    });
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Orientation')
        .collection('Quiz')
        .doc('quiz_task_1')
        .collection('questions')
        .doc('q5')
        .collection('options')
        .doc('3')
        .set({
      'answer': "Ilvermorny School of Witchcraft and Wizardry",
      'identifier': '3',
    });

    //Quiz_task_2
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Orientation')
        .collection('Quiz')
        .doc('quiz_task_2')
        .set({
      'description': 'Quiz on Programming',
      'title': 'Programming',
      'question_count': 2,
      'quiz_duration': 60,
      'image_url': 'Programming',
      'exp': 10,
      'exp_gained': false,
    });
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Orientation')
        .collection('Quiz')
        .doc('quiz_task_2')
        .collection('questions')
        .doc('q1')
        .set({
      'question': "Which of the following is NOT a programming language",
      'correct_answer': '2',
    });
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Orientation')
        .collection('Quiz')
        .doc('quiz_task_2')
        .collection('questions')
        .doc('q1')
        .collection('options')
        .doc('1')
        .set({
      'answer': "Java",
      'identifier': '1',
    });
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Orientation')
        .collection('Quiz')
        .doc('quiz_task_2')
        .collection('questions')
        .doc('q1')
        .collection('options')
        .doc('2')
        .set({
      'answer': "Lemon",
      'identifier': '2',
    });
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Orientation')
        .collection('Quiz')
        .doc('quiz_task_2')
        .collection('questions')
        .doc('q1')
        .collection('options')
        .doc('2')
        .set({
      'answer': "C++",
      'identifier': '3',
    });
//Default Q2
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Orientation')
        .collection('Quiz')
        .doc('quiz_task_2')
        .collection('questions')
        .doc('q2')
        .set({
      'question':
          "What programming language is most commonly used in Data Science",
      'correct_answer': '3',
    });
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Orientation')
        .collection('Quiz')
        .doc('quiz_task_2')
        .collection('questions')
        .doc('q2')
        .collection('options')
        .doc('1')
        .set({
      'answer': "HTML",
      'identifier': '1',
    });
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Orientation')
        .collection('Quiz')
        .doc('quiz_task_2')
        .collection('questions')
        .doc('q2')
        .collection('options')
        .doc('2')
        .set({
      'answer': "Flutter/Dart",
      'identifier': '2',
    });
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Orientation')
        .collection('Quiz')
        .doc('quiz_task_2')
        .collection('questions')
        .doc('q2')
        .collection('options')
        .doc('3')
        .set({
      'answer': "Python",
      'identifier': '3',
    });

    //Creating Orientation-related Read Task field (Specific to user to make tracking progress easier to implement)
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Orientation')
        .collection('Read')
        .doc('read_task_1')
        .set({
      'content':
          'Platypus, (Ornithorhynchus anatinus), also called duckbill, is a small amphibious Australian mammal noted for its odd combination of primitive features and special adaptations, especially the flat, almost comical bill that early observers thought was that of a duck sewn onto the body of a mammal. \n\n Adding to its distinctive appearance are conspicuous white patches of fur under the eyes. The fur on the rest of the body is dark to light brown above, with lighter fur on the underside.  The platypus is common in waterways of eastern Australia, where it generally feeds on bottom-dwelling invertebrates but also takes an occasional frog, fish, or insect at the water’s surface. \n\n  This shy creature forages most actively from dusk to dawn, sheltering during the day in burrows dug into stream banks. It is exquisitely adapted for its aquatic lifestyle, having a flattened torpedo-like body, dense waterproof fur, and strong front limbs used for swimming as well as digging. Even the head is streamlined, each ear is housed in a groove together with a small eye. The senses of sight, smell, and hearing are essentially shut down while the platypus is submerged to feed, but it possesses a unique electromechanical system of electroreceptors and touch receptors that allow it to navigate perfectly underwater. Similar electroreceptors are also present in echidnas, which, together with the platypus, make up the mammalian order Monotremata, a unique group with an exceptionally ancient history.',
      'title': 'Platypus',
    });
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Orientation')
        .collection('Read')
        .doc('read_task_2')
        .set({
      'content':
          'Wombat, (family Vombatidae), any of three large terrestrial species of Australian marsupials. Like woodchucks, wombats are heavily built and virtually tailless burrowers with small eyes and short ears. Wombats, however, are larger, measuring 80 to 120 cm (31 to 47 inches) long. Chiefly nocturnal and strictly herbivorous, they eat grasses and, in the case of the common wombat (Vombatus ursinus), the inner bark of tree and shrub roots. Wombats are considered pests by farmers because they dig in cultivated fields and pastures and because their burrows may harbour rabbits.',
      'title': 'Wombat',
    });
    //Creating Orientation-related Video Task field (Specific to user to make tracking progress easier to implement)
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Orientation')
        .collection('Watch')
        .doc('watch_task_1')
        .set({
      'isDone': false,
      'videoTitle': 'Welcome to Valorant',
      'videoDescription':
          'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?',
      'videoUrl': 'asset',
    });
  } catch (e) {
    debugPrint('Exception Found: $e');
  }
}

//Used to initialise Customs&Culture-Related Tasks
Future<void> initialiseCCTasks(String? uid) async {
  try {
    //Creating Customs&Culture-related Quiz Task field (Specific to user to make tracking progress easier to implement)
    //Need to edit later.
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Customs & Culture')
        .collection('Quiz')
        .doc('quiz_task_1')
        .set({
      'description': '',
      'title': '',
      'question_count': 1,
      'duration': 10,
    });
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Customs & Culture')
        .collection('Quiz')
        .doc('quiz_task_1')
        .collection('questions')
        .doc('q1')
        .set({
      'question': '',
      'options': [],
      'correct_option': '',
    });

    //Creating Customs&Culture-related Read Task field (Specific to user to make tracking progress easier to implement)
    //Need to edit later.
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Customs & Culture')
        .collection('Read')
        .doc('read_task_1')
        .set({
      'content': '',
      'title': '',
    });

    //Creating Customs&Culture-related Video Task field (Specific to user to make tracking progress easier to implement)
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Customs & Culture')
        .collection('Watch')
        .doc('watch_task_1')
        .set({
      'isDone': false,
      'videoTitle': 'Diver testing Air Supply',
      'videoDescription':
          'On the other hand, we denounce with righteous indignation and dislike men who are so beguiled and demoralized by the charms of pleasure of the moment, so blinded by desire, that they cannot foresee the pain and trouble that are bound to ensue; and equal blame belongs to those who fail in their duty through weakness of will, which is the same as saying through shrinking from toil and pain. These cases are perfectly simple and easy to distinguish. In a free hour, when our power of choice is untrammelled and when nothing prevents our being able to do what we like best, every pleasure is to be welcomed and every pain avoided. But in certain circumstances and owing to the claims of duty or the obligations of business it will frequently occur that pleasures have to be repudiated and annoyances accepted. The wise man therefore always holds in these matters to this principle of selection: he rejects pleasures to secure other greater pleasures, or else he endures pains to avoid worse pains.',
      'videoUrl':
          'https://static.videezy.com/system/resources/previews/000/006/461/original/diver_tests_air_supply.mp4',
    });
  } catch (e) {
    debugPrint('Exception Found: $e');
  }
}

//Used to initialise Compliance-Related Tasks
Future<void> initialiseComplianceTasks(String? uid) async {
  try {
    //Creating Compliance-related Quiz Task field (Specific to user to make tracking progress easier to implement)
    //Need to edit later.
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Compliance')
        .collection('Quiz')
        .doc('quiz_task_1')
        .set({
      'description': '',
      'title': '',
      'question_count': 1,
      'duration': 10,
    });
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Compliance')
        .collection('Quiz')
        .doc('quiz_task_1')
        .collection('questions')
        .doc('q1')
        .set({
      'question': '',
      'options': [],
      'correct_option': '',
    });

    //Creating Compliance-related Read Task field (Specific to user to make tracking progress easier to implement)
    //Need to edit later.
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Compliance')
        .collection('Read')
        .doc('read_task_1')
        .set({
      'content': '',
      'title': '',
    });

    //Creating Compliance-related Video Task field (Specific to user to make tracking progress easier to implement)
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Compliance')
        .collection('Watch')
        .doc('watch_task_1')
        .set({
      'isDone': false,
      'videoTitle': 'Science Equipment',
      'videoDescription':
          'At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat.',
      'videoUrl':
          'https://static.videezy.com/system/resources/previews/000/048/332/original/5.close-up_Hand_test_equipment_for_science_experiments_oil_pouring_scientist_with_test_tube_making_research_in_laboratory_.2.mp4',
    });
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Compliance')
        .collection('Watch')
        .doc('watch_task_2')
        .set({
      'isDone': false,
      'videoTitle': 'Another video',
      'videoDescription':
          'But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful. Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but because occasionally circumstances occur in which toil and pain can procure him some great pleasure. To take a trivial example, which of us ever undertakes laborious physical exercise, except to obtain some advantage from it? But who has any right to find fault with a man who chooses to enjoy a pleasure that has no annoying consequences, or one who avoids a pain that produces no resultant pleasure?',
      'videoUrl': 'asset',
    });
  } catch (e) {
    debugPrint('Exception Found: $e');
  }
}

//Used to initialise Health&Safety-Related Tasks
Future<void> initialiseHSTasks(String? uid) async {
  try {
    //Creating Health&Safety-related Quiz Task field (Specific to user to make tracking progress easier to implement)
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Health & Safety')
        .collection('Quiz')
        .doc('quiz_task_1')
        .set({
      'description': '',
      'title': '',
      'question_count': 1,
      'duration': 10,
    });
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Health & Safety')
        .collection('Quiz')
        .doc('quiz_task_1')
        .collection('questions')
        .doc('q1')
        .set({
      'question': '',
      'options': [],
      'correct_option': '',
    });

    //Creating Health&Safety-related Read Task field (Specific to user to make tracking progress easier to implement)
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Health & Safety')
        .collection('Read')
        .doc('read_task_1')
        .set({
      'content': '',
      'title': '',
    });

    //Creating Health&Safety-related Video Task field (Specific to user to make tracking progress easier to implement)
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Tasks')
        .doc('Health & Safety')
        .collection('Watch')
        .doc('watch_task_1')
        .set({
      'isDone': false,
      'videoTitle': 'Health & Safety',
      'videoDescription':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      'videoUrl':
          'https://static.videezy.com/system/resources/previews/000/006/852/original/Lab14.mp4',
    });
  } catch (e) {
    debugPrint('Exception Found: $e');
  }
}
