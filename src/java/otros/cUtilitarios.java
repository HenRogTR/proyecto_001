/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package otros;

import java.math.BigDecimal;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 *
 * @author Henrri
 */
public class cUtilitarios {

    private static final char[] CONSTS_HEX = {
        '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd',
        'e', 'f'
    };
    
    public String meses[] = {"Enero", "Febrero", "Marzo", "Abril", "Mayo",
        "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre",
        "Diciembre"};
    
    public String mesesCorto[] = {"Ene", "Feb", "Mar", "Abr", "May",
        "Jun", "Jul", "Ago", "Sep", "Oct", "Nov",
        "Dic"};
    
    public String diaSemana[] = {"Domingo", "Lunes", "Martes", "Miércoles",
        "Jueves", "Viernes", "Sábado"};

    public cUtilitarios() {
    }

    public String accion2(String accion) {
        if (accion.equals("r")) {
            return "Registrar";
        }
        if (accion.equals("a")) {
            return "EDITAR";
        }
        if (accion.equals("l")) {
            return "LEER";
        }
        if (accion.equals("i")) {
            return "INICIAR";
        }
        if (accion.equals("d")) {
            return "ELIMINAR";
        }
        if (accion.equals("u")) {
            return "Relacionar";
        }
        return null;
    }

    public String md5(String cadena) {
        try {
            MessageDigest msgd = MessageDigest.getInstance("MD5");
//            System.out.println("msgd: " + msgd);
            byte[] bytes = msgd.digest(cadena.getBytes());
//            System.out.println("bytes: "+bytes+" :::");
            StringBuilder strbCadenaMD5 = new StringBuilder(2 * bytes.length);
//            System.out.println("strbCadenaMD5: " + strbCadenaMD5+" :::");
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

    public String fechaFormato(String fecha) {
        return fecha.substring(1, 5) + "/" + fecha.substring(5, 7) + "/"
                + fecha.substring(7, 9) + " " + fecha.substring(9, 11) + ":"
                + fecha.substring(11, 13) + ":" + fecha.substring(13, 15);
//        return fecha;
    }

    public String fechaFormato2(Date fecha) {
        String a = fecha.toString();
        return a.substring(0, 4) + "/" + a.substring(5, 7) + "/" + a.substring(8, 10)
                + " " + a.substring(11, 19);
    }

    /**
     *
     * @param fecha
     * @return
     */
    public String fechaDateToString(Date fecha) {
        if (fecha == null) {
            return "";
        }
        if (fecha.equals("")) {
            return "";
        } else {
        }
        SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");
        return formato.format(fecha);
    }

    /**
     * Obtener la fecha actual del sistema
     *
     * @return Miercoles, 20 de Enero de 2012
     */
    public String fechaActual() {
        Date actual = new Date();
        String dia = actual.getDate() < 9 ? "0" + actual.getDate() : String.valueOf(actual.getDate());
        return diaSemana[actual.getDay()] + ", " + dia + " de " + meses[actual.getMonth()] + " de " + (actual.getYear() + 1900);

    }

    public String fechaInicioPagos(Date fecha) {
        Date actual = fecha;
        String dia = actual.getDate() < 9 ? "0" + actual.getDate() : String.valueOf(actual.getDate());
        return meses[actual.getMonth()] + " " + (actual.getYear() + 1900);

    }

    public String dia(Date fecha) {
        return fecha.getDate() < 9 ? "0" + fecha.getDate() : String.valueOf(fecha.getDate());
    }

    public String mesNombre(Date fecha) {
        return meses[fecha.getMonth()];
    }
    
    public String mesNombreCorto(Date fecha){
        return mesesCorto[fecha.getMonth()];
    }

    public int anio(Date fecha) {
        return fecha.getYear() + 1900;
    }

    /**
     *
     * @return
     */
    public String fechaHoraActual() {
        Date actual = new Date();
        String dia = actual.getDate() < 10 ? "0" + actual.getDate() : String.valueOf(actual.getDate());
        String hora = actual.getHours() < 10 ? "0" + actual.getHours() : String.valueOf(actual.getHours());
        String minuto = actual.getMinutes() < 10 ? "0" + actual.getMinutes() : String.valueOf(actual.getMinutes());
        String segundo = actual.getSeconds() < 10 ? "0" + actual.getSeconds() : String.valueOf(actual.getSeconds());
        return diaSemana[actual.getDay()] + ", " + dia + " de " + meses[actual.getMonth()] + " de " + (actual.getYear() + 1900) + ", " + hora + ":" + minuto + ":" + segundo;
    }

    public String fechaHoraActualNumerosLineal() {
        Date actual = new Date();
        String dia = actual.getDate() < 10 ? "0" + actual.getDate() : String.valueOf(actual.getDate());
        String mes = (actual.getMonth() + 1) < 10 ? "0" + (actual.getMonth() + 1) : String.valueOf(actual.getMonth() + 1);
        String hora = actual.getHours() < 10 ? "0" + actual.getHours() : String.valueOf(actual.getHours());
        String minuto = actual.getMinutes() < 10 ? "0" + actual.getMinutes() : String.valueOf(actual.getMinutes());
        String segundo = actual.getSeconds() < 10 ? "0" + actual.getSeconds() : String.valueOf(actual.getSeconds());
        return (actual.getYear() + 1900) + mes + dia + hora + minuto + segundo;
    }

    public String son(String numero) {
        return "No implementado";
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

    public int diferenciaDias(Date fecha) {
        final long MILLSECS_PER_DAY = 24 * 60 * 60 * 1000; //Milisegundos al día
        return (int) ((new Date().getTime() - fecha.getTime()) / MILLSECS_PER_DAY);
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
//        System.out.println("posPuntoDecimal: " + posPuntoDecimal);
        int cerosFaltantes = decimales - num.substring(posPuntoDecimal + 1, num.length()).length();
//        System.out.println("parteDecimal: " + num.substring(posPuntoDecimal, num.length()));
//        System.out.println("cerosFaltantes: " + cerosFaltantes);
        for (int i = 0; i < cerosFaltantes; i++) {
            num += "0";
        }
        return num;
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
        return cadena.replace("\\", "\\\\").replace("\"", "\\\"").replace("'", "\\\"").replace("\r", "\\r").replace("\n", "<br>");
    }

    public String replace_caracteres_especiales(String cadena) {
        if (cadena == null) {
            return "";
        }
        return cadena.replace("\\", "\\\\").replace("\"", "\\\"").replace("'", "\\\"").replace("\n", "<br>");
    }

    // <editor-fold defaultstate="collapsed" desc="Haga clic en el signo + para mostrar descripción">
    /**
     * Devuelve una cadena con las barras invertidas de escape quitadas.
     *
     * @param cadena \\ \'En lugar de la mancha\' \"a\"
     * @return \ 'En lugar de la mancha' "a"
     */
    // </editor-fold>
    public String quitar_barrasInvertidasTexto(String cadena) {

        return cadena.replace("\\\\", "\\").replace("\\\"", "\"").replace("\\'", "'");
    }

    // <editor-fold defaultstate="collapsed" desc="Haga clic en el signo + para mostrar descripción">
    /**
     * Genera las fechas de letras
     *
     * @param fechaInicio
     * @param numeroLetras
     * @return array con las fechas programdas para el pago
     */
    // </editor-fold>
    public List generarFechaLetrasMensuales(Date fechaInicio, int numeroLetras) {
        List fechaLetras = new ArrayList<Object>();
        SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");  //tipo de formato de salida
        Calendar c = Calendar.getInstance();
        for (int i = 0; i < numeroLetras; i++) {
            c.set(fechaInicio.getYear() + 1900, fechaInicio.getMonth(), fechaInicio.getDate()); //seteamos la fecha de inicio
            c.add(Calendar.MONTH, i);
            fechaLetras.add(formato.format(c.getTime()));
        }
        return fechaLetras;
    }

    // <editor-fold defaultstate="collapsed" desc="Haga clic en el signo + para mostrar descripción">
    /**
     * Genera las fechas de letras
     *
     * @param fechaInicio
     * @param numeroLetras
     * @return array con las fechas programdas para el pago
     */
    // </editor-fold>
    public List generarFechaLetrasQuincenales(Date fechaInicio, int numeroLetras) {
        List fechaLetras = new ArrayList<Object>();
        SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");  //tipo de formato de salida
        Calendar c = Calendar.getInstance();
        for (int i = 0; i < numeroLetras; i++) {
            c.set(fechaInicio.getYear() + 1900, fechaInicio.getMonth(), fechaInicio.getDate()); //seteamos la fecha de inicio
            c.add(Calendar.DATE, i * 15);
            fechaLetras.add(formato.format(c.getTime()));
        }
        return fechaLetras;
    }

    // <editor-fold defaultstate="collapsed" desc="Haga clic en el signo + para mostrar descripción">
    /**
     * Genera las fechas de letras
     *
     * @param fechaInicio
     * @param numeroLetras
     * @return array con las fechas programdas para el pago
     */
    // </editor-fold>
    public List generarFechaLetrasSemanales(Date fechaInicio, int numeroLetras) {
        List fechaLetras = new ArrayList<Object>();
        SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");  //tipo de formato de salida
        Calendar c = Calendar.getInstance();
        for (int i = 0; i < numeroLetras; i++) {
            c.set(fechaInicio.getYear() + 1900, fechaInicio.getMonth(), fechaInicio.getDate()); //seteamos la fecha de inicio
            c.add(Calendar.DATE, i * 7);
            fechaLetras.add(formato.format(c.getTime()));
        }
        return fechaLetras;
    }

    /**
     * Método para obtener la versión y usar como parámetro en los enlaces
     *
     * @return versión
     */
    public String version() {
        return "?13.09.13";
    }

    /**
     * Retorno cuando se hace una operacion y el usuario no ha iniciado sesion.
     * Respuesta del servidor Ajax.
     *
     * @return
     */
    public String iniciarSesion() {
        return "Estimado usuario, es necesario que se loguee.<a href=\"#\" id=\"aIniciarSesion\"> Clic aqui.</a>";
    }
}
