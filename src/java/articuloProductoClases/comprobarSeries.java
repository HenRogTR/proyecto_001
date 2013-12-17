/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package articuloProductoClases;

import java.util.Iterator;
import java.util.List;
import tablas.ArticuloProducto;
import tablas.KardexArticuloProducto;

/**
 *
 * @author Henrri
 */
public class comprobarSeries {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here

        List lAP = new cArticuloProducto().leer_admin();
        for (Iterator it = lAP.iterator(); it.hasNext();) {
            ArticuloProducto objAP = (ArticuloProducto) it.next();
            int codKAP = 0;
            KardexArticuloProducto objActual = null;
            for (KardexArticuloProducto objKAP : objAP.getKardexArticuloProductos()) {
                if (objKAP.getCodKardexArticuloProducto() > codKAP) {
                    codKAP = objKAP.getCodKardexArticuloProducto();
                    objActual = objKAP;
                }
            }

            if (objActual != null) {
                if (objActual.getArticuloProducto().getUsarSerieNumero()) {
                    if (objActual.getStock() != objActual.getKardexSerieNumeros().size()) {
                        System.out.println("codAP=" + objActual.getArticuloProducto().getCodArticuloProducto() + " ::: codKAP=" + objActual.getCodKardexArticuloProducto() + " stock: " + objActual.getStock());
                    }
                }
            }
        }

//        int cont = 0;
//        List list = new cKardexArticuloProducto().leer_admin();
//        for (Iterator it = list.iterator(); it.hasNext();) {
//            KardexArticuloProducto objKAP = (KardexArticuloProducto) it.next();
//            if (objKAP.getArticuloProducto().getUsarSerieNumero()) {
//                cont++;
//                if (objKAP.getStock() != objKAP.getKardexSerieNumeros().size()) {
//                    System.out.println("codAP=" + objKAP.getArticuloProducto().getCodArticuloProducto() + " ::: codKAP=" + objKAP.getCodKardexArticuloProducto());
//                }
//            }
//        }
//        System.out.println(cont);
    }

}
