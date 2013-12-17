/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package utilitarios;

import java.util.Date;

/**
 *
 * @author Henrri
 */
public class aOtros {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        cOtros objcOtros=new cOtros();
        
        String ab="******GRUPO YUCRA******";
        String a=objcOtros.centrar(ab, 40);
        System.out.println(ab.length());
        System.out.println(a);
        System.out.println(a.length());
        
        Date aa=new Date("12/30/2013");
        System.out.println(aa.toLocaleString());
        
        System.out.println(new cManejoFechas().DateAString(aa));
    }
    
}
