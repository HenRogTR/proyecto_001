/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ventaClases;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import utilitarios.cManejoFechas;

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
        List VCLList1 = new cVentaCreditoLetraReporte().letrasVencidas_todos_ordenNombresC_SC(new cManejoFechas().StringADate("15/06/2013"));
        List VCLList2 = new cVentaCreditoLetraReporte().letrasVencidas_todos_ordenDireccion_SC(new cManejoFechas().StringADate("15/06/2013"));
        
        Iterator i=VCLList1.iterator();
        while(i.hasNext()){
            i.next();
        }
        System.out.println(i.hasNext());
    }

}
