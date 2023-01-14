package;

import haxe.ds.List;
import haxe.ds.Vector;

import Instruction;

class Interpreter {

    static var memory = new Vector<Int>(300000);
    static var idx:Int = 0;

    public static function interpret(instructions:List<Instruction>) {

        for (instruction in instructions) {
            switch (instruction) {
                case Increment(i):
                    memory[idx] += i;
                case Shift(i):
                    idx += i;
                case Output:
                    var ch = String.fromCharCode(memory[idx]);
                    Sys.println(ch);
                case Input:
                    var s = Sys.getChar(false);
                    memory[idx] = s;
                case Loop(instructions):
                    while (memory[idx] != 0) {
                        interpret(instructions);
                    }
            }
        }
    }
}
