/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ventaClases;

/**
 *
 * @author Henrri
 */
public class aVentaCreditoLetra {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        Object[] RDCObjects = new cVentaCreditoLetraReporte().leer_resumenDeudaCliente(1);        
            System.out.println(RDCObjects[0]);
    }

}
