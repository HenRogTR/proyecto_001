/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package compraClases;

/**
 *
 * @author Henrri
 */
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import otros.cUtilitarios;
import tablas.DetalleDescripcion;
import tablas.HibernateUtil;

public class cDetalleDescripcion {

    Session sesion = null;
    public String error;

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public cDetalleDescripcion() {
        this.sesion = HibernateUtil.getSessionFactory().getCurrentSession();
    }

    public int Crear(DetalleDescripcion objDetalleDescripcion) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        try {
            int codPersona = (Integer) sesion.save(objDetalleDescripcion);
            sesion.getTransaction().commit();
            return codPersona;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            e.printStackTrace();
            setError(e.getMessage());
        }
        return 0;
    }

    public List leer() {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from DetalleDescripcion substring(registro,1,1)=1");
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List leer_admin() {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from DetalleDescripcion");
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public boolean actualizar_est(int codDetalleDescripcion, String estado, String user) {
        cUtilitarios objUtilitarios = new cUtilitarios();
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        DetalleDescripcion objDetalleDescripcion = (DetalleDescripcion) sesion.get(DetalleDescripcion.class, codDetalleDescripcion);
        objDetalleDescripcion.setRegistro(objUtilitarios.registro(estado, user));
        try {
            sesion.update(objDetalleDescripcion);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            setError("DetalleDescripcion_actualizar_est: " + e.getMessage());
        }
        return false;
    }
}
