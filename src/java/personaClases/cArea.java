/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package personaClases;

import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import tablas.Area;
import tablas.HibernateUtil;
import utilitarios.cOtros;

/**
 *
 * @author Henrri
 */
public class cArea {

    Session sesion = null;
    public String error;

    public String getError() {
        this.sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public List leer() {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Area where substring(registro,1,1)=1");
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List leer_areaOrdenado() {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Area a where substring(a.registro,1,1)=1 order by a.area");
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public int Crear(Area objArea) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        try {
            int cod = (Integer) sesion.save(objArea);
            sesion.getTransaction().commit();
            return cod;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            e.printStackTrace();
            setError(e.getMessage());
        }
        return 0;
    }

    public List leer_admin() {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Area");
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public Area leer_cod(int codArea) {
        sesion = HibernateUtil.getSessionFactory().openSession();
        return (Area) sesion.get(Area.class, codArea);
    }

    public boolean actualizar(Area objArea) {
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        try {
            sesion.update(objArea);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            e.printStackTrace();
        }
        return false;
    }

    public boolean verificarArea(String area) {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Area where substring(registro,1,1)=1 and area=:area")
                    .setParameter("area", area);
            Area objArea = (Area) q.list().iterator().next();
            if (objArea != null) {
                return true;
            }
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return false;
    }

    public boolean actualizar_registro(int codArea, String estado, String user) {
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        Area obj = (Area) sesion.get(Area.class, codArea);
        obj.setRegistro(new cOtros().registro(estado, user));
        try {
            sesion.update(obj);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            setError("Area_actualizar_est: " + e.getMessage());
        }
        return false;
    }
}
