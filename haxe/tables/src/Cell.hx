package;

using StringTools;
using StrUtils;

class Cell {

    public final leftPad:Int;
    public final rightPad:Int;
    public final pad:Int;

    public var text(default, default):String;
    public var length(default, null):Int;

    public function new(text:String, leftPad:Int = 1, rightPad:Int = 1, pad:Int = 0) {
        this.text = text;
        this.pad = pad;
        
        if (pad != 0) {
            this.leftPad = pad;
            this.rightPad = pad;
        } else {
            this.leftPad = leftPad;
            this.rightPad = rightPad;
        }

        this.length = this.leftPad + this.text.length + this.rightPad;
    }

    public static function fromOther(other:Cell): Cell {
        return new Cell(
            other.text, 
            other.leftPad, 
            other.rightPad, 
            other.pad
        );
    }

    public function toString() {
        return 
        " ".repeat(this.leftPad) + 
        this.text +
        " ".repeat(this.rightPad);
    }
}
