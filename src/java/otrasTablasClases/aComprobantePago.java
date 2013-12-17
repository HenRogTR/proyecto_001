/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package otrasTablasClases;

import cobranzaClases.cCobranza;
import compraClases.cCompra;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import tablas.Cobranza;
import tablas.ComprobantePago;
import tablas.ComprobantePagoDetalle;
import utilitarios.cOtros;

/**
 *
 * @author Henrri
 */
public class aComprobantePago {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        cComprobantePagoDetalle objcComprobantePagoDetalle = new cComprobantePagoDetalle();
        cComprobantePago objcComprobantePago = new cComprobantePago();


        ComprobantePagoDetalle objcCPDUltimo = objcComprobantePagoDetalle.leer_ultimo(2);
        System.out.println(objcComprobantePagoDetalle.getError());
        System.out.println(objcCPDUltimo);
        System.out.println(new cCompra().leer_docSerieNumero("ssdsds"));
//        System.out.println(objcCPDUltimo.getDocSerieNumero());
    }
}
