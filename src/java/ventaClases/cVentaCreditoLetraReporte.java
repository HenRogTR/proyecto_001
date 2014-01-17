/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ventaClases;

import java.util.Date;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Transaction;
import org.hibernate.classic.Session;
import tablas.HibernateUtil;

/**
 *
 * @author Henrri
 */
public class cVentaCreditoLetraReporte {

    Session sesion = null;
    public String error;

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public cVentaCreditoLetraReporte() {
        this.sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        this.error = null;
    }

    public Object[] leer_resumenDeudaCliente(int codPersona) {
        Object tem[] = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select sum(vcl.monto),sum(vcl.totalPago),(sum(vcl.monto)-sum(vcl.totalPago)) "
                    + "from VentaCreditoLetra vcl where substring(vcl.registro,1,1)=1 "
                    + "and vcl.ventaCredito.ventas.persona.codPersona=:codPersona")
                    .setParameter("codPersona", codPersona);
            tem = (Object[]) q.list().get(0);
            if (tem[0] == null & tem[1] == null & tem[2] == null) {
                tem[0] = 0.00;
                tem[1] = 0.00;
                tem[2] = 0.00;
            }
        } catch (RuntimeException e) {
            e.printStackTrace();
            System.out.println("resumenn deuda de cliente");
        } finally {
            sesion.flush();
            sesion.close();
        }
        return tem;
    }

}
