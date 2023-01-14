package;

class Main {
    static function main(): Void {
        var tokens = Lexer.lex("++++++++[>++++[>++>+++>+++>+<<<<-]>+>+>->>+[<]<-]>>.>---.+++++++..+++.>>.<-.<.+++.------.--------.>>+.>++");
        var parseRes = Parser.parse(tokens);

        switch (parseRes) {
            case Right(_):
                Sys.println("Error: Imbalanced brackets");
                Sys.exit(1);
            case Left(instructions):
                Interpreter.interpret(instructions);
        }
    }
}