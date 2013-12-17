/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package personaClases;

import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import otros.cUtilitarios;
import tablas.HibernateUtil;
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

    public Usuario ingresar(String usuario, String contrasenia) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from Usuario "
                    + "where substring(registro,1,1)=1 "
                    + "and usuario=:usuario "
                    + "and contrasenia=:contrasenia")
                    .setParameter("usuario", usuario)
                    .setParameter("contrasenia", new cOtros().md5(contrasenia));
            return (Usuario) q.list().get(0);
        } catch (Exception e) {
            System.out.println(e.getMessage());
            setError(e.getMessage());
        }
        return null;
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
        cUtilitarios objUtilitarios = new cUtilitarios();
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        Usuario obj = (Usuario) sesion.get(Usuario.class, codUsuario);
        obj.setRegistro(objUtilitarios.registro(estado, user));
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

    public boolean editarClientePermiso(int codUsuario, boolean p1, boolean p2,
            boolean p29) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        Usuario obj = (Usuario) sesion.get(Usuario.class, codUsuario);
        obj.setP1(p1);
        obj.setP2(p2);
        obj.setP29(p29);
        try {
            sesion.update(obj);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public boolean editarVentaPermiso(int codUsuario, boolean p18, boolean p23,
            boolean p31, boolean p33, boolean p34) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        Usuario obj = (Usuario) sesion.get(Usuario.class, codUsuario);
        obj.setP18(p18);
        obj.setP23(p23);
        obj.setP31(p31);
        obj.setP33(p33);
        obj.setP34(p34);
        try {
            sesion.update(obj);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public boolean editarCobranzaPermiso(int codUsuario, boolean p22,
            boolean p24, boolean p35, boolean p36, boolean p37, boolean p49) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        Usuario obj = (Usuario) sesion.get(Usuario.class, codUsuario);
        obj.setP22(p22);
        obj.setP24(p24);
        obj.setP35(p35);
        obj.setP36(p36);
        obj.setP37(p37);
        obj.setP49(p49);
        try {
            sesion.update(obj);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public boolean editarEmpresaConvenioPermiso(int codUsuario, boolean p12, boolean p41) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        Usuario obj = (Usuario) sesion.get(Usuario.class, codUsuario);
        obj.setP12(p12);
        obj.setP41(p41);
        try {
            sesion.update(obj);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public boolean editarAlmacenPermiso(int codUsuario, boolean p8, boolean p38) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        Usuario obj = (Usuario) sesion.get(Usuario.class, codUsuario);
        obj.setP8(p8);
        obj.setP38(p38);
        try {
            sesion.update(obj);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public boolean editarArticuloProductoPermiso(int codUsuario, boolean p4, boolean p6, boolean p7, boolean p15, boolean p21, boolean p27) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        Usuario obj = (Usuario) sesion.get(Usuario.class, codUsuario);
        obj.setP4(p4);
        obj.setP6(p6);
        obj.setP7(p7);
        obj.setP15(p15);
        obj.setP21(p21);
        obj.setP27(p27);
        try {
            sesion.update(obj);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public boolean editarGarantePermiso(int codUsuario, boolean p25, boolean p48) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        Usuario obj = (Usuario) sesion.get(Usuario.class, codUsuario);
        obj.setP25(p25);
        obj.setP48(p48);
        try {
            sesion.update(obj);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public boolean editarMarcaPermiso(int codUsuario, boolean p13, boolean p45) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        Usuario obj = (Usuario) sesion.get(Usuario.class, codUsuario);
        obj.setP13(p13);
        obj.setP45(p45);
        try {
            sesion.update(obj);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public boolean editarFamiliaPermiso(int codUsuario, boolean p14, boolean p43) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        Usuario obj = (Usuario) sesion.get(Usuario.class, codUsuario);
        obj.setP14(p14);
        obj.setP43(p43);
        try {
            sesion.update(obj);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public boolean editarZonaPermiso(int codUsuario, boolean p16, boolean p46) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        Usuario obj = (Usuario) sesion.get(Usuario.class, codUsuario);
        obj.setP16(p16);
        obj.setP46(p46);
        try {
            sesion.update(obj);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public boolean editarCompraPermiso(int codUsuario, boolean p3, boolean p39, boolean p40) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        Usuario obj = (Usuario) sesion.get(Usuario.class, codUsuario);
        obj.setP3(p3);
        obj.setP39(p39);
        obj.setP40(p40);
        try {
            sesion.update(obj);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public boolean editarProveedorPermiso(int codUsuario, boolean p5, boolean p17) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        Usuario obj = (Usuario) sesion.get(Usuario.class, codUsuario);
        obj.setP5(p5);
        obj.setP17(p17);
        try {
            sesion.update(obj);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public boolean editarPersonalPermiso(int codUsuario, boolean p9, boolean p30) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        Usuario obj = (Usuario) sesion.get(Usuario.class, codUsuario);
        obj.setP9(p9);
        obj.setP30(p30);
        try {
            sesion.update(obj);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public boolean editarReportePermiso(int codUsuario, boolean p19) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        Usuario obj = (Usuario) sesion.get(Usuario.class, codUsuario);
        obj.setP19(p19);
        try {
            sesion.update(obj);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public boolean editarPropietarioPermiso(int codUsuario, boolean p26, boolean p47) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        Usuario obj = (Usuario) sesion.get(Usuario.class, codUsuario);
        obj.setP26(p26);
        obj.setP47(p47);
        try {
            sesion.update(obj);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public boolean editarUsuarioPermiso(int codUsuario, boolean p20, boolean p44) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        Usuario obj = (Usuario) sesion.get(Usuario.class, codUsuario);
        obj.setP20(p20);
        obj.setP44(p44);
        try {
            sesion.update(obj);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public boolean editarCargoPermiso(int codUsuario, boolean p10, boolean p42) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        Usuario obj = (Usuario) sesion.get(Usuario.class, codUsuario);
        obj.setP10(p10);
        obj.setP42(p42);
        try {
            sesion.update(obj);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public boolean editarAreaPermiso(int codUsuario, boolean p11, boolean p32) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        Usuario obj = (Usuario) sesion.get(Usuario.class, codUsuario);
        obj.setP11(p11);
        obj.setP32(p32);
        try {
            sesion.update(obj);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}
