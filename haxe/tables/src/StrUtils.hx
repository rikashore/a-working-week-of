package;

class StrUtils {
    
    public static function repeat(s:String, count:Int):String {
        var buf = new StringBuf();
        for (_ in 0...count) buf.add(s);
        return buf.toString();
      }
}
