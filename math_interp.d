import std.stdio;
import std.conv;

double evaluate(string expression)
{
    expression = expression.replace(" ", "");

    double value = parseOperand(expression);
    size_t index = 0;

    while (index < expression.length) {
        char op = expression[index];

        if (op != '+' && op != '-' && op != '*' && op != '/') {
            throw new Exception("Invalid operator: " ~ op.to!string);
        }

        index++;

        double rhs = parseOperand(expression[index..$]);
        index += expression[index..$].findAny("+-*/");

        if (op == '+') {
            value += rhs;
        } else if (op == '-') {
            value -= rhs;
        } else if (op == '*') {
            value *= rhs;
        } else if (op == '/') {
            value /= rhs;
        }
    }

    return value;
}

double parseOperand(string expression)
{
    size_t index = 0;

    while (index < expression.length && isDigit(expression[index])) {
        index++;
    }

    if (index == 0) {
        throw new Exception("Invalid operand: " ~ expression[0..1]);
    }

    return to!double(expression[0..index]);
}

void main()
{
    while (true) {
        write("> ");
        string input = readln().strip();

        if (input == "exit") {
            break;
        }

        try {
            auto result = evaluate(input);
            writeln(to!string(result));
        } catch (Exception ex) {
            writeln(ex.msg);
        }
    }
}
