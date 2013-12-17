/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package personaClases;

import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import tablas.HibernateUtil;
//import tablas.Telefono;

/**
 *
 * @author Henrri
 */
public class cTelefono {

    Session sesion = null;
    public String error;

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    
    public List leer() {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Telefono where substring(registro,1,1)=1");
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }
//    public int Crear(Telefono objTelefono) {
//        setError(null);
//        sesion = HibernateUtil.getSessionFactory().openSession();
//        sesion.getTransaction().begin();
//        try {
//            int codTelefono = (Integer) sesion.save(objTelefono);
//            sesion.getTransaction().commit();
//            return codTelefono;
//        } catch (Exception e) {
//            sesion.getTransaction().rollback();
//            e.printStackTrace();
//            setError(e.getMessage());
//        }
//        return 0;
//    }
}
