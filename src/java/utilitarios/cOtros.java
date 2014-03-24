/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package utilitarios;

import java.math.BigDecimal;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 * @author Henrri
 */
public class cOtros {

    private static final char[] CONSTS_HEX = {
        '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd',
        'e', 'f'
    };

    /**
     * Encriptacion a MD5 a partir de una cadena.
     *
     * @param cadena
     * @return
     */
    public String md5(String cadena) {
        try {
            MessageDigest msgd = MessageDigest.getInstance("MD5");
            byte[] bytes = msgd.digest(cadena.getBytes());
            StringBuilder strbCadenaMD5 = new StringBuilder(2 * bytes.length);
            for (int i = 0; i < bytes.length; i++) {
                int bajo = (int) (bytes[i] & 0x0f);
                int alto = (int) ((bytes[i] & 0xf0) >> 4);
                strbCadenaMD5.append(CONSTS_HEX[alto]);
                strbCadenaMD5.append(CONSTS_HEX[bajo]);
            }
            return strbCadenaMD5.toString();
        } catch (NoSuchAlgorithmException e) {
            return null;
        }
    }

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
    public String agregarCeros_int(int numero, int cantidad) {
        String ceros = "";
        for (int i = 0; i < cantidad - String.valueOf(numero).length(); i++) {
            ceros += "0";
        }
        return ceros + numero;
    }

    public String centrar(String texto, int anchoTotal) {
        String tex = texto;
        if (texto.length() >= anchoTotal - 2) {
            tex = texto;
        } else {
            for (int i = 0; i < (anchoTotal - texto.length()) / 2; i++) {
                tex = " " + tex;
            }
        }
        return tex;
    }

    // <editor-fold defaultstate="collapsed" desc="Haga clic en el signo + para mostrar descripción">
    /**
     * Devuelve una cadena con barras invertidas delante de los carácteres que
     * necesitan escaparse en situaciones como consultas de bases de datos, etc.
     * Los carácteres que se escapan son la comilla simple (<b>'</b>), comilla
     * doble (<b>"</b>), barra invertida (<b>\</b>). String= "' \ En lugar de la
     * mancha\ " '"
     *
     * @param cadena \ 'En lugar de la mancha' "a"
     * @return \\ \'En lugar de la mancha\' \"a\"
     */
    // </editor-fold>
    public String replace_comillas_comillasD_barraInvertida(String cadena) {
        if (cadena == null) {
            return "";
        }
        return cadena.replace("\\", "\\\\").replace("\"", "\\\"").replace("'", "\\\"").replace("\r", " ").replace("\n", "<br>");
    }

    // <editor-fold defaultstate="collapsed" desc="Haga clic en el signo + para mostrar descripción">
    /**
     * Permite redondear un numero a la expresion equivalente en decimales Tener
     * en cuenta que es de uso comercial con un maximo de 3 decimales, para
     * datos mas precisos no funciona.
     *
     * @param numero
     * @param decimales
     * @return
     */
    // </editor-fold>
    public double redondearDecimales(double numero, int decimales) {
        if (numero < 0.009) {
            return 0;
        }
        BigDecimal bd = new BigDecimal(numero);
        bd = bd.setScale(decimales, BigDecimal.ROUND_HALF_UP);
        return bd.doubleValue();
    }

    // <editor-fold defaultstate="collapsed" desc="Haga clic en el signo + para mostrar descripción">
    /**
     * Funcion que me permite retornar un String de la siguiente forma (123.321,
     * 4) donde 123.321 es double y 4 int sea un numero 123.312 y quiero obtener
     * un numero de 4 decimales entonces me retornara 123.3120 solo en caso de
     * que el numero decimales a obtener sea mayor o igual al actual
     *
     * @param numero 123.321
     * @param decimales 4
     * @return 123.3210
     */
    // </editor-fold>
    public String agregarCerosNumeroFormato(double numero, int decimales) {

        String num = String.valueOf(numero);

        int posPuntoDecimal = num.indexOf(".");
        int cerosFaltantes = decimales - num.substring(posPuntoDecimal + 1, num.length()).length();
        for (int i = 0; i < cerosFaltantes; i++) {
            num += "0";
        }
        return num;
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
    public String decimalFormato(Double numero, int decimales) {
        if (numero == null) {
            numero = 0.00;
        }
//        if (numero < 0.009) {
//            return numero.toString();
//        }
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
    public String registro(String est, String user) {
        SimpleDateFormat formato = new SimpleDateFormat("yyyyMMddHHmmss");
        Date fecha = new Date();
        return est + formato.format(fecha) + user;
    }
}
