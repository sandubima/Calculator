// IM_2021_017 Sanduni Pandipperuma - Calculator Application - Button Values

class Button {
  // Operator buttons
  static const String delete = "D";         // Delete button
  static const String clear = "AC";         // Clear all input
  static const String per = "%";            // Percentage operator
  static const String multiply = "*";       // Multiplication operator
  static const String divide = "/";         // Division operator
  static const String add = "+";            // Addition operator
  static const String substract = "-";      // Substraction operator
  static const String caret = "^";          // Caret operator
  static const String result= "=";          // Equals or result button
  static const String dot = ".";            // Decimal point button
  
  // Number buttons
  static const String n0 = "0";             // Number 0
  static const String n1 = "1";             // Number 1
  static const String n2 = "2";             // Number 2          
  static const String n3 = "3";             // Number 3
  static const String n4 = "4";             // Number 4
  static const String n5 = "5";             // Number 5
  static const String n6 = "6";             // Number 6
  static const String n7 = "7";             // Number 7
  static const String n8 = "8";             // Number 8
  static const String n9 = "9";             // Number 9

  // List of all button values in order of appearance
  static const List<String> buttonValues = [
    clear,                                   // Row 1: Clear button
    caret,                                   // Row 1: Caret button
    per,                                     // Row 1: Percentage button
    multiply,                                // Row 1: Multiply button

    n7,                                      // Row 2: Number 7
    n8,                                      // Row 2: Number 8
    n9,                                      // Row 2: Number 9
    divide,                                  // Row 2: Divide Operator

    n4,                                      // Row 3: Number 4
    n5,                                      // Row 3: Number 5
    n6,                                      // Row 3: Number 6
    substract,                               // Row 3: Substraction operator

    n1,                                      // Row 4: Number 1
    n2,                                      // Row 4: Number 2
    n3,                                      // Row 4: Number 3
    add,                                     // Row 4: Addition operator

    dot,                                     // Row 5: Decimal point
    n0,                                      // Row 5: Number 0 (spans double width in UI)
    delete,                                  // Row 5: Delete button
    result                                   // Row 5: Equals or result button
  ];
}
