/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package personaClases;

import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import HiberanteUtil.HibernateUtil;
import tablas.Usuario;
import utilitarios.cOtros;

/**
 *
 * @author Henrri****
 */
public class cUsuario {

    Session sesion = null;
    public String error;

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public cUsuario() {
        this.error = null;
    }

    public Usuario ingresar(String usuario, String contrasenia) {
        Usuario objUsuario = null;
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from Usuario "
                    + "where substring(registro,1,1)=1 "
                    + "and usuario=:usuario "
                    + "and contrasenia=:contrasenia")
                    .setParameter("usuario", usuario)
                    .setParameter("contrasenia", new cOtros().md5(contrasenia));
            objUsuario = (Usuario) q.list().get(0);
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
            setError(e.getMessage());
        } finally {
//            sesion.close();
        }
        return objUsuario;
    }

    public Usuario ingresar2(String usuario, String contrasenia) {
        Usuario objUsuario = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("from Usuario "
                    + "where substring(registro,1,1)=1 "
                    + "and usuario=:usuario "
                    + "and contrasenia=:contrasenia")
                    .setParameter("usuario", usuario)
                    .setParameter("contrasenia", new cOtros().md5(contrasenia));
            objUsuario = (Usuario) q.uniqueResult();
        } catch (RuntimeException e) {
            e.printStackTrace();
        } finally {
            sesion.flush();
//            session.close();
        }
        return objUsuario;
    }

    public int Crear(Usuario objUsuario) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        try {
            int cod = (Integer) sesion.save(objUsuario);
            sesion.getTransaction().commit();
            return cod;
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
            Query q = sesion.createQuery("from Usuario where substring(registro,1,1)=1");
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public Usuario leer_usuario(String usuario) {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Usuario u where substring(u.registro,1,1)=1 "
                    + "and u.usuario=:usuario")
                    .setParameter("usuario", usuario);
            return (Usuario) q.list().iterator().next();
        } catch (Exception e) {
            setError(e.getMessage());
            return null;
        }
    }

    //<editor-fold defaultstate="collapsed" desc="Haga clic en el signo + para mostrar descripción">
    /**
     * Verifica la existencia de usuarios válidos en la BD de al menos un usario
     * válido.
     *
     * @return <b>0</b> ó <b>!= 0</b>.
     */
    //</editor-fold>
    public List leer_admin() {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Usuario");
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public Usuario leer_cod(int codUsuario) {
        sesion = HibernateUtil.getSessionFactory().openSession();
        return (Usuario) sesion.get(Usuario.class, codUsuario);
    }

    public Usuario leer_primero() {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from Usuario u where substring(u.registro,1,1)=1 "
                    + "order by u.codUsuario asc")
                    .setMaxResults(1);
            return (Usuario) q.list().iterator().next();
        } catch (Exception e) {
            setError("Leer primero: " + e.getMessage());
        }
        return null;
    }

    public Usuario leer_ultimo() {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from Usuario u where substring(u.registro,1,1)=1 "
                    + "order by u.codUsuario desc")
                    .setMaxResults(1);
            return (Usuario) q.list().iterator().next();
        } catch (Exception e) {
            setError("Leer ultimo: " + e.getMessage());
        }
        return null;
    }

    public boolean actualizar_registro(int codUsuario, String estado, String user) {
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        Usuario obj = (Usuario) sesion.get(Usuario.class, codUsuario);
        obj.setRegistro(new cOtros().registro(estado, user));
        try {
            sesion.update(obj);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            setError("Usuario_actualizar_registro: " + e.getMessage());
        }
        return false;
    }

    /**
     *
     * @param codUsuario
     * @param p1
     * @param p2
     * @param p3
     * @param p4
     * @param p5
     * @param p6
     * @param p7
     * @param p8
     * @param p9
     * @param p10
     * @param p11
     * @param p12
     * @param p13
     * @param p14
     * @param p15
     * @param p16
     * @param p17
     * @param p18
     * @param p19
     * @param p20
     * @param p21
     * @param p22
     * @param p23
     * @param p24
     * @param p25
     * @param p26
     * @param p27
     * @param p28
     * @param p29
     * @param p30
     * @param p31
     * @param p32
     * @param p33
     * @param p34
     * @param p35
     * @param p36
     * @param p37
     * @param p38
     * @param p39
     * @param p40
     * @param p41
     * @param p42
     * @param p43
     * @param p44
     * @param p45
     * @param p46
     * @param p47
     * @param p48
     * @param p49
     * @param p50
     * @param p51
     * @param p52
     * @param p53
     * @param p54
     * @param p55
     * @param p56
     * @param p57
     * @param p58
     * @param p59
     * @param p60
     * @return
     */
    public Boolean editarPrivilegios(int codUsuario, boolean p1, boolean p2,
            boolean p3, boolean p4, boolean p5, boolean p6, boolean p7,
            boolean p8, boolean p9, boolean p10, boolean p11, boolean p12,
            boolean p13, boolean p14, boolean p15, boolean p16, boolean p17,
            boolean p18, boolean p19, boolean p20, boolean p21, boolean p22,
            boolean p23, boolean p24, boolean p25, boolean p26, boolean p27,
            boolean p28, boolean p29, boolean p30, boolean p31, boolean p32,
            boolean p33, boolean p34, boolean p35, boolean p36, boolean p37,
            boolean p38, boolean p39, boolean p40, boolean p41, boolean p42,
            boolean p43, boolean p44, boolean p45, boolean p46, boolean p47,
            boolean p48, boolean p49, boolean p50, boolean p51, boolean p52,
            boolean p53, boolean p54, boolean p55, boolean p56, boolean p57,
            boolean p58, boolean p59, boolean p60) {

        Transaction trns = null;
        boolean estado = false;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Usuario objUsuario = (Usuario) sesion.get(Usuario.class, codUsuario);
            objUsuario.setP1(p1);
            objUsuario.setP2(p2);
            objUsuario.setP3(p3);
            objUsuario.setP4(p4);
            objUsuario.setP5(p5);
            objUsuario.setP6(p6);
            objUsuario.setP7(p7);
            objUsuario.setP8(p8);
            objUsuario.setP9(p9);
            objUsuario.setP10(p10);
            objUsuario.setP11(p11);
            objUsuario.setP12(p12);
            objUsuario.setP13(p13);
            objUsuario.setP14(p14);
            objUsuario.setP15(p15);
            objUsuario.setP16(p16);
            objUsuario.setP17(p17);
            objUsuario.setP18(p18);
            objUsuario.setP19(p19);
            objUsuario.setP20(p20);
            objUsuario.setP21(p21);
            objUsuario.setP22(p22);
            objUsuario.setP23(p23);
            objUsuario.setP24(p24);
            objUsuario.setP25(p25);
            objUsuario.setP26(p26);
            objUsuario.setP27(p27);
            objUsuario.setP28(p28);
            objUsuario.setP29(p29);
            objUsuario.setP30(p30);
            objUsuario.setP31(p31);
            objUsuario.setP32(p32);
            objUsuario.setP33(p33);
            objUsuario.setP34(p34);
            objUsuario.setP35(p35);
            objUsuario.setP36(p36);
            objUsuario.setP37(p37);
            objUsuario.setP38(p38);
            objUsuario.setP39(p39);
            objUsuario.setP40(p40);
            objUsuario.setP41(p41);
            objUsuario.setP42(p42);
            objUsuario.setP43(p43);
            objUsuario.setP44(p44);
            objUsuario.setP45(p45);
            objUsuario.setP46(p46);
            objUsuario.setP47(p47);
            objUsuario.setP48(p48);
            objUsuario.setP49(p49);
            objUsuario.setP50(p50);
            objUsuario.setP51(p51);
            objUsuario.setP52(p52);
            objUsuario.setP53(p53);
            objUsuario.setP54(p54);
            objUsuario.setP55(p55);
            objUsuario.setP56(p56);
            objUsuario.setP57(p57);
            objUsuario.setP58(p58);
            objUsuario.setP59(p59);
            objUsuario.setP60(p60);
            sesion.update(objUsuario);
            sesion.getTransaction().commit();
            estado = true;
        } catch (Exception e) {
            if (trns != null) {
                trns.rollback();
            }
            e.printStackTrace();
        } finally {
            sesion.flush();
            sesion.close();
        }
        return estado;
    }

    public Boolean editarContrasenia(int codUsuario, String contrasenia) {
        Transaction trns = null;
        boolean estado = false;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Usuario objUsuario = (Usuario) sesion.get(Usuario.class, codUsuario);
            objUsuario.setContrasenia(contrasenia);
            sesion.update(objUsuario);
            sesion.getTransaction().commit();
            estado = true;
        } catch (Exception e) {
            if (trns != null) {
                trns.rollback();
            }
            e.printStackTrace();
        } finally {
            sesion.flush();
            sesion.close();
        }
        return estado;
    }
}
