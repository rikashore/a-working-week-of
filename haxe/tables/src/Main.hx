// Code is a haxe translation of
// https://xmonader.github.io/nimdays/day16_asciitables.html

package;

class Main {
    static function main() {
        var table = new Table();

        table.tableWidth = 100;
        table.separateRows = false;

        table.setHeaders(["ID", "Name", "Fav animal", "Date", "OK"]);
        table.addRow(["1", "xmonader", "Cat, Dog", "2018-10-2", "yes"]);
        table.addRow(["2", "ahmed", "Shark", "2018-10-2", "yes"]);
        table.addRow(["3", "dr who", "Humans", "1018-5-2", "no"]);

        Sys.println(table.toString());
    }
}
