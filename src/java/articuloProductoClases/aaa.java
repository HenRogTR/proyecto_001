/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package articuloProductoClases;

import java.util.Iterator;
import tablas.ArticuloProducto;
import utilitarios.cOtros;

/**
 *
 * @author Henrri
 */
public class aaa {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        cMarca objcMarca = new cMarca();
        cOtros objcOtros = new cOtros();
        cArticuloProducto objcArticuloProducto = new cArticuloProducto();

        int cant = 0;
        for (Iterator it = objcArticuloProducto.leer_admin().iterator(); it.hasNext();) {
            ArticuloProducto obj = (ArticuloProducto) it.next();
            if (obj.getDescripcion().length() > cant) {
                System.out.println(obj.getCodArticuloProducto() + " (" + obj.getDescripcion().length() + ") " + obj.getDescripcion());
                cant = obj.getDescripcion().length();
            }
        }
    }

    public Boolean est() {
        Boolean esta = false;
        return esta;
    }

}
