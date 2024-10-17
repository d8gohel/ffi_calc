// native/eval.c
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

// Function to evaluate a simple arithmetic expression (e.g., "3 + 5 * 2")
double eval(const char* expr) {
    char* end;
    double result = strtod(expr, &end); // Parse the first number

    // Iterate through the expression
    while (*end) {
        // Skip spaces
        while (isspace(*end)) end++;

        char op = *end++;  // Get the operator (+, -, *, /)
        double nextValue = strtod(end, &end);  // Parse the next number

        switch (op) {
            case '+': result += nextValue; break;
            case '-': result -= nextValue; break;
            case '*': result *= nextValue; break;
            case '/': 
                if (nextValue != 0) result /= nextValue;
                else {
                    fprintf(stderr, "Error: Division by zero\n");
                    return 0;
                }
                break;
            default:
                fprintf(stderr, "Error: Invalid operator '%c'\n", op);
                return 0;
        }
    }
    return result;
}
