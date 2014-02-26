/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package otros;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 *
 * @author Henrri
 */
public class cManejoFechas {

    // <editor-fold defaultstate="collapsed" desc="Haga clic en el signo + para mostrar descripción">
    /**
     * Convertir fecha en string de la forma <b>dd/mm/yyyy</b> a tipo date
     *
     * @param fecha <b>dd/mm/yyyy</b>
     * @return fecha en tipo date
     */
    // </editor-fold>
    public Date caracterADate(String fecha) {
        if (fecha == "") {
            return null;
        }
        return new Date(fecha.substring(3, 5) + "/" + fecha.substring(0, 3) + "/" + fecha.substring(5));
    }

    // <editor-fold defaultstate="collapsed" desc="Haga clic en el signo + para mostrar descripción">
    /**
     *
     * @param fecha fecha base en tipo Date
     * @param dias retorna la fecha con la cantidad de dias sumadas + ó -
     * @return dd/mm/yyyy
     */
    // </editor-fold>
    public String fechaSumarDias(Date fecha, int dias) {
        SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");  //tipo de formato de salida
        Calendar c = Calendar.getInstance();
        c.set(fecha.getYear() + 1900, fecha.getMonth(), fecha.getDate()); //seteamos la fecha de inicio
        c.add(Calendar.DATE, dias);
        return formato.format(c.getTime());
    }

    // <editor-fold defaultstate="collapsed" desc="Haga clic en el signo + para mostrar descripción">
    /**
     *
     * @param fecha fecha base en tipo Date
     * @param meses retorna la fecha con la cantidad de dias sumadas + ó -
     * @return dd/mm/yyyy
     */
    // </editor-fold>
    public String fechaSumarMes(Date fecha, int meses) {
        SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");  //tipo de formato de salida
        Calendar c = Calendar.getInstance();
        c.set(fecha.getYear() + 1900, fecha.getMonth(), fecha.getDate()); //seteamos la fecha de inicio
        c.add(Calendar.MONTH, meses);
        return formato.format(c.getTime());
    }

    // <editor-fold defaultstate="collapsed" desc="Haga clic en el signo + para mostrar descripción">
    /**
     * Retorna un string de la forma dd/mm/aaaa hh:mm:ss
     *
     * @param registro dato que se registra en la BD
     * @return dd/mm/aaaa hh:mm:ss
     */
    // </editor-fold>
    public String registroAFechaHora(String registro) {
        return registro.substring(7, 9) + "/" + registro.substring(5, 7) + "/"
                + registro.substring(1, 5) + " " + registro.substring(9, 11) + ":"
                + registro.substring(11, 13) + ":" + registro.substring(13, 15);
//        return fecha;
    }

    /**
     *
     * @param fecha
     * @return fecha con formato <b>dd/MM/yyyy</b>
     */
    public String fechaDateToString(Date fecha) {
        return new SimpleDateFormat("dd/MM/yyyy").format(fecha);
    }
    }
