import 'dart:io';
class Student {
  final String id;
  final String name;
  final double score;
  final String grade;

  Student({
    required this.id,
    required this.name,
    required this.score,
    required this.grade,
  });

  @override
  String toString() {
    return 'ID: $id, Name: $name, Score: $score, Grade: $grade';
  }
}

void main() {
  List<Student> students = [];

  print("Welcome to Student Record Management System\n");

  while (true) {
    print('''
Choose  option:
1️⃣  Add Student
2️⃣  Show All Students (Sorted by Score)
3️⃣  Show Summary (Highest, Lowest, Total)
4️⃣  Exit
''');

    stdout.write(" Enter your choice: ");
    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        addStudent(students);
        break;
      case '2':
        displaySortedStudents(students);
        break;
      case '3':
        displaySummary(students);
        break;
      case '4':
        print(" Exiting the program. Goodbye!");
        return;
      default:
        print(" Invalid choice! Please try again.\n");
    }
  }
}

///----------- Prompt user for input and handles `stdin.readLineSync()` with a clear message. ----------/////////
String _promptForInput(String prompt) {
  stdout.write(prompt);
  return stdin.readLineSync() ?? '';
}

///--------------------- Add a new student to the list----------------------//
void addStudent(List<Student> students) {
  String id;
  while (true) {
    id = _promptForInput("Enter Student ID: ");
    if (id.isEmpty) {
      print(" Student ID cannot be empty.\n");
      continue;
    }
    bool exists = students.any((student) => student.id == id);
    if (exists) {
      print("ID '$id' already exists! Please enter a unique ID.\n");
      continue;
    }
    break; //----(Valid and unique ID);
  }

  String name;
  while(true){
    name =_promptForInput(
      "Enter Your name :"
    );
    if(name.isEmpty){
      print("Student Name cannot be empty.\n");
      continue;
    }
    break; ///----(valid name);
  }


  double score;
  while(true){
   String scoreInput =_promptForInput("Enter Student Score Under(1-100) : " );
   double? parsedScore =double.tryParse(scoreInput);

    if(parsedScore ==null){
      print("Envalid . Please Enter a  numeric Score.\n");
    }else if(parsedScore <0 || parsedScore >100){
      print("Invalid Score : Must be between 1 to 100.\n");

    }else{
      score =parsedScore;
      break; ///-----(valid Score);
    }
  }
  String grade = calculateGrade(score);

  students.add(Student(
    id: id,
    name: name,
    score: score,
    grade: grade,
  ));

  print("✅ Student added successfully!\n");
}

/////////------------ Calculate Grade Based On score --------------------/////////
  String calculateGrade(double score){
     if (score >= 90) return "A+";
     if (score >= 80) return "A";
     if (score >= 70) return "B";
     if (score >= 60) return "C";
     if (score >= 50) return "D";
     return "F";
  }


  /////////------------- Dsiplay All student Sorted by Score(desending) -------------------------///////
  
 void displaySortedStudents(List<Student> students) {
  if (students.isEmpty) {
    print("No students available.\n");
    return;
  }

List<Student> sortedStudents = List.from(students);


/////// --- Sorted by student is decending order ---------------////////////////
  sortedStudents.sort((x, y) => x.score.compareTo(y.score));
  print("\n Student List (sorted By score) : ");
  print("=========================================================");
  print("ID          Name             Score   Grade");
  print("=========================================================");


  for(var student in sortedStudents){
    //================ Adjust padding as needed based on expected max length of ID/Name ============////////
    print(
      "${student.id.padRight(10)} ${student.name.padRight(18)} ${student.score.toStringAsFixed(1).padRight(10)} ${student.grade}");
  }
  print("=========================================================");
 }


 //////====================== Displaysummury Shows (Higstes, Lowest , Total)==============//////////////

void displaySummary(List<Student> students) {
  if (students.isEmpty) {
    print("📭 No students to summarize.\n");
    return;
  }

////////// ----------- Dart collection (map) ------------------//////////
  double highest = students.map((s) => s.score).reduce((x, y) => x >  y? x : y);
  double lowest = students.map((s) => s.score).reduce((x, y) => x <  y? x : y);
  print("Summary Report");
  print("=========================================================");
  print("Total Student : ${students.length}");
  print("Higest Score : ${highest.toStringAsFixed(1)}");
  print("lowest Score : ${lowest.toStringAsFixed(1)}");
  print("=========================================================");

}

