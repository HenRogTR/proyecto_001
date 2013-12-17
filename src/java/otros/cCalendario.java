/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package otros;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Vector;

/**
 *
 * @author Henrri
 */
public class cCalendario {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here

        cUtilitarios objcUtilitarios = new cUtilitarios();
        String inicio = "2012/01/01";
        int periodo = 24;
        System.out.println("Inicio periodo: " + inicio);
        System.out.println("Número de periodos: " + periodo);
        List a = objcUtilitarios.generarFechaLetrasMensuales(new Date(inicio), periodo);
        List semanales = objcUtilitarios.generarFechaLetrasSemanales(new Date(inicio), periodo);
        for (int i = 0; i < semanales.size(); i++) {
            System.out.println("Letra N°" + (i + 1) + ": " + semanales.get(i));
        }
    }
}
