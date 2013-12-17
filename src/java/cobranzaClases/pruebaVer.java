/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cobranzaClases;

import java.util.Iterator;
import java.util.List;
import tablas.Cobranza;
import tablas.CobranzaDetalle;

/**
 *
 * @author Henrri
 */
public class pruebaVer {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here

        List l = new cCobranza().leer_prueba();
        for (Iterator it = l.iterator(); it.hasNext();) {
            Cobranza objCobranza = (Cobranza) it.next();
            System.out.print(objCobranza.getObservacion());
            for (CobranzaDetalle objCobranzaDetalle : objCobranza.getCobranzaDetalles()) {
                System.out.print("--- "+objCobranzaDetalle.getObservacion());
            }
            System.out.println("**************");
        }
    }

}
