/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Clase;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 * @author Henrri
 */
public class Utilitarios {

    // <editor-fold defaultstate="collapsed" desc="Haga clic en el signo + para mostrar descripción">
    /**
     * Sea mi número <b>123</b> y quiero un numero de extension <b>8</b> es
     * decir los <b>5</b> restantes seran tantos <b>0's</b> obteniendo
     * <b>00000123</b>
     *
     * @param numero tipo int
     * @param cantidad tipo int
     * @return String
     */
    // </editor-fold>
    public static String agregarCerosIzquierda(int numero, int cantidad) {
        String ceros = "";
        for (int i = 0; i < cantidad - String.valueOf(numero).length(); i++) {
            ceros += "0";
        }
        return ceros + numero;
    }

    public static String reemplazarCaracteresEspeciales(String cadena) {
        if (cadena == null) {
            return "";
        }
        return cadena.replace("\\", "\\\\").replace("\"", "\\\"").replace("'", "\\\"").replace("\r", " ").replace("\n", "<br>");
    }

    /**
     * Permite redondear y dar formato de los decimales correspondiente s a un
     * numero a la expresion equivalente en decimales. Tener en cuenta que es de
     * uso comercial con un maximo de 3 decimales, para datos mas precisos no
     * funciona.
     *
     * @param numero
     * @param decimales
     * @return
     */
    public static String decimalFormato(Double numero, int decimales) {
        if (numero == null) {
            numero = 0.00;
        }
        BigDecimal bd = new BigDecimal(numero);
        bd = bd.setScale(decimales, BigDecimal.ROUND_HALF_UP);//redondea

        String num = String.valueOf(bd);

        int posPuntoDecimal = num.indexOf(".");
        int cerosFaltantes = decimales - num.substring(posPuntoDecimal + 1, num.length()).length();
        for (int i = 0; i < cerosFaltantes; i++) {
            num += "0";
        }
        return num;
    }

    /**
     * Cadena con la informacion del registro del dato.
     *
     * @param est String que <b>0<b> si se eliminará ó <1> si se registrara.
     * @param user String código de usuario, usuario de la sesíon iniciada.
     * @return un Strin de la fomra 1201304011818301 = e yyyy mm dd hh mm ss u.
     */
    public static String registro(String est, int user) {
        SimpleDateFormat formato = new SimpleDateFormat("yyyyMMddHHmmss");
        Date fecha = new Date();
        return est + formato.format(fecha) + user;
    }
}
