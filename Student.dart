import 'dart:io';

/// Represents a student with an ID, name, score, and calculated grade.
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

  print(" Welcome to Student Record Management System\n");

  while (true) {
    print("""
Choose an option:
1️⃣  Add Student
2️⃣  Show All Students (Sorted by Score)
3️⃣  Show Summary (Highest, Lowest, Total)
4️⃣  Exit
""");

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
        print("Invalid choice! Please try again.\n");
    }
  }
}

/// Prompts user for input and handles `stdin.readLineSync()` with a clear message.
String _promptForInput(String prompt) {
  stdout.write(prompt);
  return stdin.readLineSync() ?? '';
}

/// Adds a new student to the list, with robust input validation.
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
      print(" ID '$id' already exists! Please enter a unique ID.\n");
      continue;
    }
    break; // Valid and unique ID
  }

  String name;
  while (true) {
    name = _promptForInput("Enter Student Name: ");
    if (name.isEmpty) {
      print(" Student Name cannot be empty.\n");
      continue;
    }
    break; // Valid name
  }

  double score;
  while (true) {
    String scoreInput = _promptForInput("Enter Student Score (0 - 100): ");
    double? parsedScore = double.tryParse(scoreInput);

    if (parsedScore == null) {
      print(" Invalid input! Please enter a numeric score.\n");
    } else if (parsedScore < 0 || parsedScore > 100) {
      print(" Invalid score! Must be between 0 and 100.\n");
    } else {
      score = parsedScore;
      break; // Valid score
    }
  }

  String grade = calculateGrade(score);

  students.add(Student(
    id: id,
    name: name,
    score: score,
    grade: grade,
  ));

  print(" Student added successfully!\n");
}

/// Calculates grade based on score
String calculateGrade(double score) {
  if (score >= 90) return "A+";
  if (score >= 80) return "A";
  if (score >= 70) return "B";
  if (score >= 60) return "C";
  if (score >= 50) return "D";
  return "F";
}

/// Displays all students sorted by score (descending)
void displaySortedStudents(List<Student> students) {
  if (students.isEmpty) {
    print(" No students available.\n");
    return;
  }

  // Create a copy to sort, so the original list order isn't changed if not desired elsewhere.
  // Although in this CLI, the original list's order change is harmless.
  List<Student> sortedStudents = List.from(students);

  // Sort by score descending
  sortedStudents.sort((a, b) => b.score.compareTo(a.score));

  print("Student List (Sorted by Score):");

  // Using fixed-width columns for better formatting.
  // Adjust padding as needed based on expected max length of ID/Name.
  print("ID          Name                Score   Grade");
  for (var student in sortedStudents) {
    print(
        "${student.id.padRight(10)} ${student.name.padRight(18)} ${student.score.toStringAsFixed(1).padRight(6)} ${student.grade}");
  }
}

/// Displays summary: total, highest, lowest scores
void displaySummary(List<Student> students) {
  if (students.isEmpty) {
    print(" No students to summarize.\n");
    return;
  }

  // Using Dart's collection methods to find max/min scores
  // The list is guaranteed not to be empty at this point due to the check above.
  double highest = students.map((s) => s.score).reduce((a, b) => a > b ? a : b);
  double lowest = students.map((s) => s.score).reduce((a, b) => a < b ? a : b);

  print(" Summary Report:");
  print("Total Students: ${students.length}");
  print("Highest Score: ${highest.toStringAsFixed(1)}");
  print("Lowest Score: ${lowest.toStringAsFixed(1)}");
}
