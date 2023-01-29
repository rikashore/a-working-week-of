package;

import haxe.iterators.StringIterator;

class Rot {
    public static function rot13(s:String) {
        var buf = new StringBuf();
        for (ch in new StringIterator(s)) {
            switch ch {
                case c if (c >= 'a'.code && c <= 'm'.code):
                    buf.addChar(c + 13);
                case c if (c >= 'A'.code && c <= 'M'.code):
                    buf.addChar(c + 13);
                case c if (c >= 'n'.code && c <= 'z'.code):
                    buf.addChar(c - 13);
                case c if (c >= 'N'.code && c <= 'Z'.code):
                    buf.addChar(c - 13);
            }
        }

        return buf.toString();
    }
}
