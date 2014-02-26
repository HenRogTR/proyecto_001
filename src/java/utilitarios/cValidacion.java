/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utilitarios;

import java.util.Date;
import java.util.regex.Pattern;

/**
 *
 * @author Henrri
 */
public class cValidacion {

    public Boolean validarFecha(String fecha) {
        Boolean est = false;
        if (fecha != null) {
            if (Pattern.matches("\\d{2}/\\d{2}/\\d{4}", fecha)) {
                String dato[] = fecha.split("/");
                Integer dia = Integer.parseInt(dato[0]);
                Integer mes = Integer.parseInt(dato[1]) - 1;
                Integer anio = Integer.parseInt(dato[2]) - 1900;
                Date fechaDate = new Date(anio, mes, dia);
                if (dia == fechaDate.getDate() & mes == fechaDate.getMonth() & anio == fechaDate.getYear()) {
                    est = true;
                }
            }
        }
        return est;
    }

}
