/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package cobranzaClases;

import java.io.BufferedWriter;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import javax.print.Doc;
import javax.print.DocFlavor;
import javax.print.DocPrintJob;
import javax.print.PrintService;
import javax.print.PrintServiceLookup;
import javax.print.SimpleDoc;
import javax.print.attribute.HashPrintRequestAttributeSet;
import javax.print.attribute.PrintRequestAttributeSet;

/**
 *
 * @author Henrri
 */
public class cImpresoraMetodos {

    public static void main(String[] args) throws IOException {
        cImpresoraMetodos objImpresoraMetodos = new cImpresoraMetodos();
        FileWriter file = new FileWriter("c:/texto.txt");
        BufferedWriter buffer = new BufferedWriter(file);
        PrintWriter ps = new PrintWriter(buffer);
//        System.out.println(service.getName());

        objImpresoraMetodos.setFormato(1, ps);
        ps.println("mi razon rozial");
        ps.println("");
        ps.println("");
        ps.println("RUC :" + "");
        objImpresoraMetodos.Dibuja_Linea(ps);
        ps.println("Ticket    :" + "" + " - " + "");
        ps.println("S/N       :" + "");
        ps.println("Fecha     :" + "" + "  Hora : " + "");
        ps.println("Caj   : " + "" + " Ven : " + "" + " Int : " + "");
        objImpresoraMetodos.Dibuja_Linea(ps);
        ps.println("Sr(a)     :" + "");
        objImpresoraMetodos.Dibuja_Linea(ps);
        ps.println("Cant     " + "Descripcion" + "             " + "PVP");
        objImpresoraMetodos.Dibuja_Linea(ps);
        int lineas = 7;

        // aqui recorro mis productos y los imprimo
        objImpresoraMetodos.Dibuja_Linea(ps);
        ps.println("TOTAL         : S./ " + "");
        ps.println();
        String ultimo = "              " + "";
        ultimo += "                   " + "";
        ps.println(ultimo);
        ps.println("  NO SE ACEPTAN CAMBIOS NI DEVOLUCIONES");
        ps.println("        GRACIAS POR SU COMPRA          ");
        objImpresoraMetodos.correr(10, ps);
        objImpresoraMetodos.cortar(ps);
        ps.close();

        FileInputStream inputStream = null;
        try {
            inputStream = new FileInputStream("c:/texto.txt");
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        if (inputStream == null) {
            return;
        }

        DocFlavor docFormat = DocFlavor.INPUT_STREAM.AUTOSENSE;
        Doc document = new SimpleDoc(inputStream, docFormat, null);

        PrintRequestAttributeSet attributeSet = new HashPrintRequestAttributeSet();

        PrintService defaultPrintService = PrintServiceLookup.lookupDefaultPrintService();


        if (defaultPrintService != null) {
            DocPrintJob printJob = defaultPrintService.createPrintJob();
            try {
                printJob.print(document, attributeSet);

            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            System.err.println("No existen impresoras instaladas");
        }
        inputStream.close();

    }

    private void Dibuja_Linea(PrintWriter ps) {
        try {
            ps.println("----------------------------------------");
        } catch (Exception e) {
            System.out.print(e);
        }
    }
//para cortar el papel de mi ticketera

    private void cortar(PrintWriter ps) {
        try {
            char[] ESC_CUT_PAPER = new char[]{0x1B, 'm'};
            ps.write(ESC_CUT_PAPER);
        } catch (Exception e) {
            System.out.print(e);
        }
    }

    private void correr(int fin, PrintWriter pw) {
        try {
            int i = 0;
            for (i = 1; i <= fin; i++) {
                pw.println("");
            }
        } catch (Exception e) {
            System.out.print(e);
        }
    }

    private void setFormato(double formato, PrintWriter pw) {
        try {
            char[] ESC_CUT_PAPER = new char[]{0x1B, '!', (char) formato};
            pw.write(ESC_CUT_PAPER);
        } catch (Exception e) {
            System.out.print(e);
        }
    }
// para el color de mi ticketera

    private void setRojo(PrintWriter pw) {
        try {
            char[] ESC_CUT_PAPER = new char[]{0x1B, 'r', 1};
            pw.write(ESC_CUT_PAPER);
        } catch (Exception e) {
            System.out.print(e);
        }
    }

    private void setNegro(PrintWriter pw) {
        try {
            char[] ESC_CUT_PAPER = new char[]{0x1B, 'r', 0};
            pw.write(ESC_CUT_PAPER);
        } catch (Exception e) {
            System.out.print(e);
        }
    }
}
