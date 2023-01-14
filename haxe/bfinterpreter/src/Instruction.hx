package;

enum Instruction {
    Increment(i:Int);
    Shift(i:Int);
    Input;
    Output;
    Loop(instructions:Ast);
}

typedef Ast = List<Instruction>;
