/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package ventaClases;

import tablas.Ventas;

/**
 *
 * @author Henrri
 */
public class aVenta {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        Ventas objVenta=new cVenta().leer_docSerieNumeroGuia("E-334-354454");
        System.out.println(objVenta);
    }
    
}
