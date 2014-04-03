/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package personaServlets;

import personaClases.cUsuario;
import tablas.Usuario;

/**
 *
 * @author Henrri
 */
public class aPrueba {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        Usuario objUsuario = new cUsuario().ingresar2("admin", "1234");

        String a = null;
        Boolean f = a != null;
        System.out.println(f);
    }
}
