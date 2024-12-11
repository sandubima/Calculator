// IM_2021_017 Sanduni Pandipperuma - Calculator Application - Calculator Screen

import 'package:flutter/material.dart';
import 'dart:math';

import 'button_values.dart';
import 'history_screen.dart';

// Main  widget representing the calculator screen
class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

// State for managing the calculator's functionality
class _CalculatorScreenState extends State<CalculatorScreen> {
  String number1 = "";                                             
  String operand = "";                                             
  String number2 = "";                                            
  final List<String> history = [];                                // Stores calculation history
  bool isResultDisplayed = false;                                 // New flag to track if result is displayed
  
  @override
  Widget build(BuildContext context) {
    // Fetch the screen size for responsive layout
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 18, 18, 18),
      appBar: AppBar(
        actions: [
          // History button in AppBar navigates to the history screen
          IconButton(
            icon: const Icon(Icons.history),  
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HistoryScreen(
                    history: history,
                    onClearHistory: clearHistory,
                    ),
                ),
              ); 
            },
          ),
        ],
      ),
      // Scaffold provides the basic structure of the screen
      body: SafeArea(
        bottom: false,
        child: Column(
        children: [
        // Output display section
        Expanded(
          child: SingleChildScrollView(
            reverse: true,                                             // Ensure new input appears at the bottom
            child: Container(
              alignment: Alignment.bottomRight,                        // Align output to the bottom-right
              padding: const EdgeInsets.all(16),                       // Adds padding around the text
              child: Text(
                "$number1$operand$number2".isEmpty ? "0" : "$number1$operand$number2",
                style: TextStyle(
                  // Dynamic font size
                  fontSize: getFontSize(context, "$number1$operand$number2"), 
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.end,
              ),
            ),
          ),
        ),
        
        // Buttons
        Wrap(
          // Wrap arranges buttons in a grid-like layout
          children: Button.buttonValues
          .map(
            (value) => SizedBox(
              width: screenSize.width/4,                                 // Quarter width for other buttons
              height: screenSize.width/5,                                // Uniform height for all buttons
              child: buildButton(value),                                 // Build button 
              ),
            )
            .toList(),
        )
        ],
        ),
      ),
    );
  }

  // Build individual button widgets
  Widget buildButton(value){
    return Padding(
      padding: const EdgeInsets.all(4.0),                              // Add padding around each button
      child: Material(
        color: getButtonColor(value),                                  // Assign button color 
        clipBehavior: Clip.hardEdge,                                   // Ensure button shape clips child elements
        shape: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFF232323),                                // Button border color
          ),
          borderRadius: BorderRadius.circular(100),                    // Rounded button corners
        ),
        child: InkWell(
          onTap: () => onButtonTap(value) ,                            // Placeholder for button tap functionality
          child: Center(
            child: Text(
              value,                                                    // Display the button label
              style: const TextStyle(
              fontWeight: FontWeight.bold,                              // Bold font for button label
              fontSize: 24,                                             // Font size for button label
              color: Colors.white,
              ),
            ),
            ),
        ),
      ),
    );
  }
  
  // Handle button actions
  void onButtonTap(String value){
    if(value == Button.delete){
      delete();                                                         // Delete last input
      return;
    }

    if(value == Button.clear){
      clearAll();                                                       // Clear all inputs
      return;
    }

    
    if(value == Button.per){
      percentageButton();                                              // Convert number1 to percentage
      return;
    }

    
    if(value == Button.result){
      calculateButton();                                               // Perform calculation
      return;
    }
     
    // Add input to the equation
    appendValue(value);
  }

  // Delete one from the end
  void delete(){
    if(number2.isNotEmpty){
      number2=number2.substring(0, number2.length - 1);
    }
    else if(operand.isNotEmpty){
      operand = "";
    }
    else if(number1.isNotEmpty){
      number1=number1.substring(0, number1.length - 1);
    }

    setState(() {});
  }

  // Clear all output
  void clearAll(){
    setState(() {
      number1 = "";
      operand = "";
      number2 = "";
    });
  }

  // Convert output to %
  void percentageButton(){
    if(number1.isNotEmpty && operand.isNotEmpty && number2.isNotEmpty){
      calculateButton();
    }

    if(operand.isNotEmpty){
      return;
    }

    // Convert the value from a string to a double
    final number = double.parse(number1);
    setState(() {
      number1 = "${(number / 100)}";
      operand = "";
      number2 = "";
      isResultDisplayed = true;
    });
  }

  // Calculate the Output
  void calculateButton(){
    if (number1.isEmpty) return;
    if (operand.isEmpty) return;
    if (number2.isEmpty) return;

    // Parse the value from a string to a double
    final num1 = double.parse(number1);
    final num2 = double.parse(number2);
    var result = 0.0;
    String errorMessage = "";

  // Validate for edge cases
  if (operand == Button.divide) {
    if (num2 == 0) {
      // Check for divide by zero
      errorMessage = num1 == 0 ? "Indeterminate" : "Undefined";
    }
  }

  if (errorMessage.isNotEmpty) {
    // Show error message and clear inputs
    setState(() {
      history.add("$number1 $operand $number2 = $errorMessage");
      number1 = errorMessage;
      operand = "";
      number2 = "";
      isResultDisplayed = true;                              // Set the flag to true after result
    });
    return;
  }

    switch (operand) {
      case Button.add:
        result = num1 + num2;
        break;
      case Button.substract:
        result = num1 - num2;
        break;
      case Button.multiply:
        result = num1 * num2;
        break;
      case Button.divide:
        result = num1 / num2;
        break;
      case Button.caret:
      result = pow(num1, num2).toDouble();
      break;
      default:
    }

    setState(() {
      // Format the result to 10 decimal places and remove trailing zeros
      final formattedResult = result.toStringAsFixed(10).replaceAll(
        RegExp(r'0+$'), '').replaceAll(
          RegExp(r'\.$'), '');
      // Add result to history
      history.add("$number1 $operand $number2 = $formattedResult");

      number1 = formattedResult;
      operand = "";
      number2 = "";
      isResultDisplayed = true;                                      // Set the flag to true after result
    });
  }

  // Append value to the end 
  void appendValue(String value){
    // Prevent further operations if the result is "Indeterminate" or "Undefined"
    if (number1 == "Indeterminate" || number1 == "Undefined") {
      clearAll(); // Clear all inputs to reset the calculator
      return;
    }
    
    if(isResultDisplayed) {
      if (int.tryParse(value) != null || value == Button.dot){
      // Clear the screen after showing the result
        number1 = value == Button.dot ? "0." : value;
        operand = "";
        number2 = "";
        isResultDisplayed = false;                                      // Reset the flag
        setState(() {});
        return;

      }else if (int.tryParse(value) == null){
        operand = value;
        number2 = "";
        isResultDisplayed = false;
        setState(() {});
        return;
      }
    }
    // Adjust the negative numbers
    if (value == Button.substract && number1.isEmpty && operand.isEmpty) {
      number1 = "-";
      setState(() {});
      return;
    }

    if(value!=Button.dot&&int.tryParse(value)==null){
      if(operand.isNotEmpty&&number2.isNotEmpty){
        //ToDo calculate the equation before assigning new operand
        calculateButton();
      }
      operand = value;
    }
    // Assign value to number1 variable
    else if(number1.isEmpty || operand.isEmpty){
      if(value==Button.dot && number1.contains(Button.dot)) return;
      if(value==Button.dot && number1.isEmpty || number1==Button.n0){
        value = "0.";
      }
      number1 += value;
    }
    // Assign value to number2 variable
    else if(number2.isEmpty || operand.isNotEmpty){
      if(value==Button.dot && number2.contains(Button.dot)) return;
      if(value==Button.dot && number2.isEmpty || number2==Button.n0){
        value = "0.";
      }
      number2 += value;
    }

    setState(() {});
  }

  double getFontSize(BuildContext context, String text) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (text.length > 10) {
      return screenWidth / 20; // Smaller font for longer text
    }
    return screenWidth / 10; // Default font size for short text
  }

  // Determine button color based on its type
  Color getButtonColor(value){
    return [Button.delete,Button.clear].contains(value)
        ?const Color.fromARGB(255, 183, 28, 28):                  // Red for delete and clear
        [
          Button.per,
          Button.multiply,
          Button.divide,
          Button.add,
          Button.substract,
          Button.caret,
          Button.result,
          ].contains(value)
          ?const Color.fromARGB(255, 255, 111, 0):               // Orange for operators and result
          const Color.fromARGB(255, 39, 38, 38);                 // Default color for other buttons
  }

// Clear the calculation history
void clearHistory() {
  setState(() {
    history.clear();
  });
}
  
}
