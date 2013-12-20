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
public class aaa {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        cMarca objcMarca = new cMarca();
        cOtros objcOtros = new cOtros();
        cArticuloProducto objcArticuloProducto = new cArticuloProducto();

        List KSNList = new cKardexSerieNumero().leer_por_codKardexArticuloProducto(1);
        System.out.println(KSNList);
    }
}
