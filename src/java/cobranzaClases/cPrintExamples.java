/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package cobranzaClases;

/**
 *
 * @author Henrri
 */
import javax.print.PrintService;
import javax.print.PrintServiceLookup;
import javax.print.attribute.Attribute;
import javax.print.attribute.AttributeSet;
import javax.print.attribute.HashAttributeSet;
import javax.print.attribute.PrintServiceAttributeSet;
import javax.print.attribute.standard.ColorSupported;
import javax.print.attribute.standard.Destination;
import javax.print.attribute.standard.PrinterInfo;
import javax.print.attribute.standard.PrinterIsAcceptingJobs;
import javax.print.attribute.standard.PrinterLocation;
import javax.print.attribute.standard.PrinterMakeAndModel;
import javax.print.attribute.standard.PrinterName;
import javax.print.attribute.standard.PrinterState;

/**
 * Ejemplos para ver tus impresoras
 *
 * @author Peiretti
 */
public class cPrintExamples {

    /**
     * @param args
     */
    public static void main(String[] args) {

        printAvailable();
        printDefault();
        printByName("\\\\CAJA-PC\\EPSON TM-U220 Receipt");
    }

    public static void printAvailable() {

        // busca los servicios de impresion...
        PrintService[] services = PrintServiceLookup.lookupPrintServices(null, null);

        // -- ver los atributos de las impresoras...
        for (PrintService printService : services) {
            System.out.println("service:" + printService);
            System.out.println(" ---- IMPRESORA: " + printService.getName());

            PrintServiceAttributeSet printServiceAttributeSet = printService.getAttributes();

            System.out.println("--- atributos");

            // todos los atributos de la impresora
            Attribute[] a = printServiceAttributeSet.toArray();
            for (Attribute unAtribute : a) {
                System.out.println("atributo: " + unAtribute.getName());
            }

            System.out.println("--- viendo valores especificos de los atributos ");

            // valor especifico de un determinado atributo de la impresora
            System.out.println("PrinterLocation: " + printServiceAttributeSet.get(PrinterLocation.class));
            System.out.println("PrinterInfo: " + printServiceAttributeSet.get(PrinterInfo.class));
            System.out.println("PrinterState: " + printServiceAttributeSet.get(PrinterState.class));
            System.out.println("Destination: " + printServiceAttributeSet.get(Destination.class));
            System.out.println("PrinterMakeAndModel: " + printServiceAttributeSet.get(PrinterMakeAndModel.class));
            System.out.println("PrinterIsAcceptingJobs: " + printServiceAttributeSet.get(PrinterIsAcceptingJobs.class));

        }

    }

    public static void printDefault() {

        // tu impresora por default
        PrintService service = PrintServiceLookup.lookupDefaultPrintService();
        System.out.println("Tu impresora por default es: " + service.getName());

    }

    public static void printByName(String printName) {

        PrintService[] services = PrintServiceLookup.lookupPrintServices(null, null);

        // buscar por el nombre de la impresora (nombre que le diste en tu S.O.)
        // en "aset" puedes agregar mas atributos de busqueda
        AttributeSet aset = new HashAttributeSet();
        aset.add(new PrinterName(printName, null));
        aset.add(ColorSupported.SUPPORTED); // si quisieras buscar ademas las que soporten color

        services = PrintServiceLookup.lookupPrintServices(null, aset);
        if (services.length == 0) {
            System.out.println("No se encontro impresora con nombre " + printName);
        }
        for (PrintService printService : services) {
            System.out.println("******************************"+printService.getName());
        }
    }
}
