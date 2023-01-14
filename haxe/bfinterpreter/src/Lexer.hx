package;

import Token;

class StrIterator {
    var s:String;
    var i:Int;
  
    public function new(s:String) {
      this.s = s;
      i = 0;
    }
  
    public function hasNext() {
      return i < s.length;
    }
  
    public function next() {
      return s.charAt(i++);
    }
}

class Lexer {

    public static function lex(src:String): List<Token> {
        var tokens = new List<Token>();

        for (ch in new StrIterator(src)) {
            var token = switch (ch) {
                case "+": Plus;
                case "-": Neg;
                case "<": ShiftLeft;
                case ">": ShiftRight;
                case "[": BracketLeft;
                case "]": BracketRight;
                case ",": Comma;
                case ".": Dot;
                case _: Unknown;
            }

            tokens.add(token);
        }

        return tokens.filter(function(tok) return !tok.match(Unknown));
    }
}
