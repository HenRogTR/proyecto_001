/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package otros;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 * @author Henrri
 */
public class aUtilitarios {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        cUtilitarios objcUtilitarios = new cUtilitarios();
        System.out.println(objcUtilitarios.agregarCerosNumeroFormato(1234.56, 2));
        String a = "'\\ En lugar de la mancha\\ \" '' ";
        String conBarra = objcUtilitarios.replace_comillas_comillasD_barraInvertida(a);
        System.out.println("original: " + a);
        System.out.println("con formato: " + conBarra);
        System.out.println("retornado: " + objcUtilitarios.quitar_barrasInvertidasTexto(conBarra));
        System.out.println(objcUtilitarios.replace_comillas_comillasD_barraInvertida("TV DAEWOO 21\" MOD DTH-21S9"));
        
        System.out.println(objcUtilitarios.redondearDecimales(0.009, 4));
        
        System.out.println(objcUtilitarios.md5("1234"));
        
        
    }
    
}
