/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package amio;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import otros.cUtilitarios;
import personaClases.cPersona;
import tablas.*;

/**
 *
 * @author Henrri
 */
public class ayudas {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        Persona objPersona = new Persona();
        System.out.println(objPersona);
        for (Personal objPersonal : objPersona.getPersonals()) {
            System.out.println("hola");
        }

        String a = "0008858011";
        try {
            System.out.println(Integer.parseInt(a, 10));
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

    }
}
