/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
$.validator.setDefaults({
    submitHandler: function() {
        $("#cancelar").attr("disabled", "disabled").addClass("disabled");
        $("#restaurar").attr("disabled", "disabled").addClass("disabled");
        $("#accion").attr("disabled", "disabled").addClass("disabled");
        $("#lCodArea").text($("#codArea").val());
        $("#lArea").text($("#area").val());
        $("#lDetalle").text($("#detalle").val());
        $("#registroConfirmar").dialog("open");
    },
    showErrors: function(map, list) {
        var focussed = document.activeElement;
        if (focussed && $(focussed).is("input, textarea")) {
            $(this.currentForm).tooltip("close", {currentTarget: focussed}, true);
        }
        this.currentElements.removeAttr("title").removeClass("ui-state-highlight");
        $.each(list, function(index, error) {
            $(error.element).attr("title", error.message).addClass("ui-state-highlight");
        });
        if (focussed && $(focussed).is("input, textarea")) {
            $(this.currentForm).tooltip("open", {target: focussed});
        }
    }
});
(function() {
    $("#areaFrm").tooltip({
        show: false,
        hide: false
    });
    $("#areaFrm").validate({
        rules: {
            area: {
                required: true,
                minlength: 5
            },
            detalle: {
                minlength: 10
            }
        },
        messages: {
        }
    });
})();