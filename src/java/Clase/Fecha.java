/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Clase;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 *
 * @author Henrri
 */
public class Fecha {

    /**
     *
     * @param fechaBase
     * @param fechaCalcular
     * @return
     */
    public int diasDiferencia(Date fechaBase, Date fechaCalcular) {
        //quitando horas
        fechaBase = fechaHoraAFecha(fechaBase);
        fechaCalcular = fechaHoraAFecha(fechaCalcular);
        //Milisegundos por día
        final long MILLSECS_PER_DAY = 24 * 60 * 60 * 1000;
        return (int) ((fechaBase.getTime() - fechaCalcular.getTime()) / MILLSECS_PER_DAY);
    }

    /**
     *
     * @param fecha
     * @param numeroDias
     * @return
     */
    public Date sumarDias(Date fecha, int numeroDias) {
        Calendar c = Calendar.getInstance();
        c.set(fecha.getYear() + 1900, fecha.getMonth(), fecha.getDate()); //seteamos la fecha de inicio
        c.add(Calendar.DATE, numeroDias);
        fecha = c.getTime();
        return fecha;
    }

    /**
     *
     * @param fecha
     * @param numeroMeses
     * @return
     */
    public Date sumarMes(Date fecha, int numeroMeses) {
        Calendar c = Calendar.getInstance();
        c.set(fecha.getYear() + 1900, fecha.getMonth(), fecha.getDate()); //seteamos la fecha de inicio
        c.add(Calendar.MONTH, numeroMeses);
        fecha = c.getTime();
        return fecha;
    }

    /**
     *
     * @param fecha
     * @return
     */
    public Date stringADate(String fecha) {
        SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");
        Date fechaDate = null;
        try {
            fechaDate = formato.parse(fecha);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return fechaDate;
    }

    public String dateAString(Date fecha) {
        String fechaString = "";
        //tipo de formato de salida
        if (fecha != null) {
            SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");
            fechaString = formato.format(fecha);
        }
        return fechaString;
    }

    /**
     * Quitamos la hora, minuto y segundos
     *
     * @param fecha
     * @return
     */
    public Date fechaHoraAFecha(Date fecha) {
        //tipo de formato de salida
        SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");
        String fechaString = formato.format(fecha);
        try {
            fecha = formato.parse(fechaString);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return fecha;
    }

    public String mesNombreCorto(Date fecha) {
        String mesCorto = "";
        try {
            SimpleDateFormat formato = new SimpleDateFormat("MMM");  //tipo de formato de salida
            mesCorto = formato.format(fecha);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return mesCorto;
    }

    public String anioCorto(Date fecha) {
        String anio = "";
        try {
            SimpleDateFormat formato = new SimpleDateFormat("yy");  //tipo de formato de salida
            anio = formato.format(fecha);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return anio;
    }

    /**
     * miércoles, 18 de junio de 2014, 08:04:16
     *
     * @param date
     * @return
     */
    public String fechaHora(Date date) {
        String fechaString = "";
        try {
            SimpleDateFormat formato = new SimpleDateFormat("EEEE, dd 'de' MMMM 'de' yyyy, HH:mm:ss");  //tipo de formato de salida
            fechaString = formato.format(date);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return fechaString;
    }

    /**
     * Obtiene un String con la fecha actual del servidor.
     *
     * @param fecha
     * @return MARTES, 20 DE AGOSTO DE 2013
     */
    public String fechaCabecera(Date fecha) {
        SimpleDateFormat formato = new SimpleDateFormat("EEEE, dd 'de' MMMM 'de' yyyy");
        return formato.format(fecha).toUpperCase();
    }

    public int diferenciaMinuto(Date fecha1, Date fecha2) {
        int cantidad;
        Calendar cal1 = Calendar.getInstance();
        Calendar cal2 = Calendar.getInstance();
        cal1.setTime(fecha1);
        cal2.setTime(fecha2);
        long milis1 = cal1.getTimeInMillis();
        long milis2 = cal2.getTimeInMillis();
        //diferencia en milisegundos
        long diff = milis2 - milis1;
        cantidad = (int) (diff / (60 * 1000));
        return cantidad;
    }

}
