/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package otros;

/**
 *
 * @author Henrri
 */
public class aNumeroLetra {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here

        cNumeroLetra objcNumeroLetra = new cNumeroLetra();
        cUtilitarios objcUtilitarios = new cUtilitarios();
        System.out.println(objcNumeroLetra.importeNumeroALetra("1236.48", true));
        double a = 999999999.8999999999999;
//        System.out.println(objcUtilitarios.redondearNumeroALetra(a, 2));
    }
}
