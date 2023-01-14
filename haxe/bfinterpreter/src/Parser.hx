package;

import haxe.ds.Either;
import haxe.ds.List;

import Token;
import Instruction.Ast;
import Instruction;

enum ParseError {
    ImbalancedBrackets;
}

class Parser {

    public static function parse(tokens:List<Token>): Either<Ast, ParseError> {
        var asts = new List<Ast>();
        asts.add(new Ast());

        for (token in tokens) {
            var sym = switch(token) {
                case Plus: Left(Increment(1));
                case Neg: Left(Increment(-1));
                case ShiftLeft: Left(Shift(-1));
                case ShiftRight: Left(Shift(1));
                case Dot: Left(Output);
                case Comma: Left(Input);
                case BracketLeft: 
                    asts.add(new Ast());
                    Right(null);
                case BracketRight:
                    var last = asts.last();
                    asts.remove(last);
                    Left(Loop(last));
                case Unknown:
                    Right(null);
            }

            switch (sym) {
                case Left(s):
                    var lastAst = asts.last();
                    if (lastAst != null) {
                        lastAst.add(s);
                    }
                    else {
                        return Right(ImbalancedBrackets);
                    }
                case Right(v):

            }
        }

        switch (asts.length) {
            case 1:
                var ast = asts.last();
                asts.remove(ast);
                return Left(ast);
            case _:
                Right(ImbalancedBrackets);
        }

        return Left(new Ast());
    }
}
