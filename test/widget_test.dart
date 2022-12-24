import 'package:flutter_test/flutter_test.dart';

import 'test_lesson_1_task_1.dart';
import 'test_lesson_1_task_2.dart';
import 'test_lesson_1_task_3.dart';
import 'test_lesson_1_task_4.dart';
import 'test_lesson_1_task_5.dart';

void main() {
  group("l05h01", () => runTestLesson1Task1());
  group("l05h02", () => runTestLesson1Task2());
  group("l05h03", () => runTestLesson1Task3());
  group("l05h04", () => runTestLesson1Task4());
  group("l05h05", () => runTestLesson1Task5());
}
