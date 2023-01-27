package;

import haxe.Exception;
using Lambda;
using StrUtils;

import haxe.iterators.ArrayKeyValueIterator;

class Table {
    
    private final rowSeparator = '-';
    private final colSeparator = '|';
    private final cellEdge = '+';
    private final buf:StringBuf = new StringBuf();

    private var rows:Array<Array<String>>;
    private var headers:Array<Cell>;
    private var widths:Array<Int>;
    
    public var suggestedWidths(default, default):Array<Int>;
    public var tableWidth(default, default):Int;
    public var separateRows(default, default):Bool;

    var columnsCount(get, null): Int;

    public function new() {
        this.tableWidth = 0;
        this.separateRows = true;
        this.widths = new Array();
        this.suggestedWidths = new Array();
        this.rows = new Array();
        this.headers = new Array();
    }

    public function get_columnsCount(): Int {
        return this.headers.length;
    }

    private function calculateWidths() {
        var colsWidths = new Array<Int>();

        if (this.suggestedWidths.length == 0) {
            for (header in this.headers) {
                colsWidths.push(header.length);
            }
        } else {
            colsWidths = this.suggestedWidths;
        }

        for (row in this.rows) {
            for (kv in new ArrayKeyValueIterator(row)) {
                var aCell = Cell.fromOther(this.headers[kv.key]);
                aCell.text = kv.value;

                if (aCell.length > colsWidths[kv.key]) {
                    colsWidths[kv.key] = aCell.length;
                }
            }
        }

        var sizeForCol = Std.int(this.tableWidth/ this.headers.length);
        var lenHeaders = 0;
        for (w in colsWidths) lenHeaders += w;

        if (this.tableWidth > lenHeaders) {
            if (this.suggestedWidths.length == 0) {
                for (kv in new ArrayKeyValueIterator(colsWidths)) {
                    colsWidths[kv.key] += sizeForCol - kv.value;
                }
            }
        }

        if (this.suggestedWidths.length != 0) {
            var sumSuggestedWidths = 0;
            for (s in this.suggestedWidths) {
                sumSuggestedWidths += s;
            }

            if (lenHeaders > sumSuggestedWidths) {
                throw new Exception("sum of {this.suggestedWidths} = {sumSuggestedWidths} and it's less than required length {lenHeaders}");
            }
        }

        this.widths = colsWidths;
    }

    private function oneLine() {
        this.buf.add(this.cellEdge);
        for (width in this.widths) {
            buf.add(this.rowSeparator.repeat(width) + this.cellEdge);
        }
        this.buf.add("\n");
    }

    public function setHeaders(headers:Array<String>) {
        this.headers = headers.map(function(s) return new Cell(s));
    }

    public function setRows(rows:Array<Array<String>>) {
        this.rows = rows;
    }

    public function addRow(row: Array<String>) {
        this.rows.push(row);
    }

    public function toString() {
        calculateWidths();

        oneLine();

        for (kv in new ArrayKeyValueIterator(this.headers)) {
            buf.add(this.colSeparator);
            buf.add(kv.value);
            buf.add(" ".repeat(this.widths[kv.key] - kv.value.length));
        }

        buf.add(this.colSeparator);
        buf.add("\n");

        oneLine();

        for (row in this.rows) {
            for (kv in new ArrayKeyValueIterator(row)) {
                var cell = new Cell(
                    kv.value, 
                    this.headers[kv.key].leftPad,
                    this.headers[kv.key].rightPad
                );

                buf.add(this.colSeparator);
                buf.add(cell.toString());
                buf.add(" ".repeat(this.widths[kv.key] - cell.length));
            }

            buf.add(this.colSeparator);
            buf.add("\n");

            if (this.separateRows) oneLine();
        }

        if (!this.separateRows) oneLine();

        return buf.toString();
    }
}
