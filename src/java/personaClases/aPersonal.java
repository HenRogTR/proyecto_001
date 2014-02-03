/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package personaClases;

import java.util.Iterator;
import java.util.List;
import tablas.DatosCliente;
import tablas.Personal;

/**
 *
 * @author Henrri
 */
public class aPersonal {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here

        List personalList = new cPersonal().leer_cobradorVendedor_SC("tramo");
        for (Iterator it = personalList.iterator(); it.hasNext();) {
            Object[] personalObjects=(Object[])it.next();
            System.out.println(personalObjects[0]);
        }
    }

}
