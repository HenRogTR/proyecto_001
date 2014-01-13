/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package utilitarios;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 *
 * @author Henrri***
 */
public class cManejoFechas {

    public String meses[] = {"Enero", "Febrero", "Marzo", "Abril", "Mayo",
        "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre",
        "Diciembre"};

    public String mesesCorto[] = {"Ene", "Feb", "Mar", "Abr", "May",
        "Jun", "Jul", "Ago", "Sep", "Oct", "Nov",
        "Dic"};

    public String diaSemana[] = {"Domingo", "Lunes", "Martes", "Miércoles",
        "Jueves", "Viernes", "Sábado"};

    /**
     * Obtiene un String con la fecha actual del servidor.
     *
     * @return MARTES, 20 DE AGOSTO DE 2013
     */
    public String fechaCabecera() {
        SimpleDateFormat formato = new SimpleDateFormat("EEEE, dd 'de' MMMM 'de' yyyy");
        return formato.format(new Date()).toUpperCase();
    }

    /**
     * Convierte un tipo date a un string de la forma dd/MM/YYYY si en caso es
     * <b>null</b> devolvera vacio.
     *
     * @param fecha
     * @return
     */
    public String DateAString(Date fecha) {
        try {
            SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");
            return formato.format(fecha);
        } catch (Exception e) {
            return "";
        }
    }

    /**
     *
     * @param fecha
     * @return
     */
    public Date StringADate(String fecha) {
        try {
            return new Date(fecha.substring(3, 5) + "/" + fecha.substring(0, 3) + "/" + fecha.substring(5));
        } catch (Exception e) {
            return null;
        }
    }

    public String fechaHoraAString(Date fecha) {
        try {
            SimpleDateFormat formato = new SimpleDateFormat("dd/MM/YYYY HH:mm:ss");
            return formato.format(fecha);
        } catch (Exception e) {
            return "";
        }
    }

    public int diferenciaDias(Date fecha) {
        final long MILLSECS_PER_DAY = 24 * 60 * 60 * 1000; //Milisegundos al día
        return (int) ((new Date().getTime() - fecha.getTime()) / MILLSECS_PER_DAY);
    }

    public String fechaHoraFormatoDeRegistro(String fechaHora) {
        return fechaHora.substring(1, 5) + "/" + fechaHora.substring(5, 7) + "/"
                + fechaHora.substring(7, 9) + " " + fechaHora.substring(9, 11) + ":"
                + fechaHora.substring(11, 13) + ":" + fechaHora.substring(13, 15);
//        return fecha;
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

    public String mesNombreCorto(Date fecha) {
        return mesesCorto[fecha.getMonth()];
    }
}
