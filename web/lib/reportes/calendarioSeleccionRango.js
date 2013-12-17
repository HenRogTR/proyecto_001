/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

var SELECTED_RANGE = null;
function getSelectionHandler() {
    var startDate = null;
    var ignoreEvent = false;
    return function(cal) {
        var selectionObject = cal.selection;

        // avoid recursion, since selectRange triggers onSelect
        if (ignoreEvent)
            return;

        var selectedDate = selectionObject.get();
        if (startDate == null) {
            startDate = selectedDate;
            document.getElementById("comprasFechaInicio").value = Calendar.printDate(Calendar.intToDate(selectedDate), "%d/%m/%Y");
            SELECTED_RANGE = null;
            document.getElementById("info").innerHTML = "Clic para seleccionar fecha de fin.";

            // comment out the following two lines and the ones marked (*) in the else branch
            // if you wish to allow selection of an older date (will still select range)
            cal.args.min = Calendar.intToDate(selectedDate);
            cal.refresh();
        } else {
            ignoreEvent = true;
            selectionObject.selectRange(startDate, selectedDate);
            document.getElementById("comprasFechaFin").value = Calendar.printDate(Calendar.intToDate(selectedDate), "%d/%m/%Y");
            ignoreEvent = false;
            SELECTED_RANGE = selectionObject.sel[0];

            // alert(SELECTED_RANGE.toSource());
            //
            // here SELECTED_RANGE contains two integer numbers: start date and end date.
            // you can get JS Date objects from them using Calendar.intToDate(number)

            startDate = null;
            document.getElementById("info").innerHTML = selectionObject.print("%Y-%m-%d") +
                    "<br/>Clic otra vez para seleccionar nuevas fechas.";

            // (*)
            cal.args.min = null;
            cal.refresh();
        }
    };
}
;

Calendar.setup({
    cont: "cont",
    fdow: 1,
    selectionType: Calendar.SEL_SINGLE,
    onSelect: getSelectionHandler()
});
