/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package otros;

import java.util.Date;

/**
 *
 * @author Henrri
 */
public class aManejoFechas {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        
        cManejoFechas objcManejoFechas=new cManejoFechas();
        System.out.println(objcManejoFechas.caracterADate("15/12/2012").toLocaleString());
        
        System.out.println(objcManejoFechas.regsitroAFechaHora("1201304121110371"));
        Integer a=0;
        int b=0;
        if(a.equals(b)){
            System.out.println("siiiiii");
        }
        
        System.out.println(objcManejoFechas.fechaSumarDias(new Date(), 10));
        System.out.println(new Date("20/12/2013"));
    }
}
