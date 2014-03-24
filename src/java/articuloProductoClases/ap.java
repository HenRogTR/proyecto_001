/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package articuloProductoClases;

import java.util.Iterator;
import java.util.List;
import tablas.ArticuloProducto;
import utilitarios.cOtros;

/**
 *
 * @author Henrri
 */
public class ap {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        List l = new cArticuloProducto().leer_inventario_SC();

        for (Iterator it = l.iterator(); it.hasNext();) {
            Object dato[] = (Object[]) it.next();
            System.out.println(dato[0] + " / " + dato[1] + " / " + dato[2] + " / " + dato[3] + " / " + dato[4] + " / " + dato[5] + " / " + dato[6]);
        }
    }
}
