/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Ejb;

import Clase.MD5;
import Clase.Utilitarios;
import Dao.DaoPersona;
import Dao.DaoUsuario;
import HiberanteUtil.HibernateUtil;
import java.util.List;
import javax.ejb.Stateless;
import org.hibernate.Session;
import org.hibernate.Transaction;
import tablas.Usuario;

/**
 *
 * @author Henrri
 */
@Stateless
public class EjbUsuario {

    private Usuario usuario;
    private List<Usuario> usuarioList;

    private String error;
    private Session session;
    private Transaction transaction;

    private int codUsuarioSession;
    private String repetirContraseniaNueva;
    private int codPersona;

    public EjbUsuario() {
        this.usuario = new Usuario();
        this.usuarioList = null;
        this.usuario.setIp("ALL");
        this.usuario.setEstado(true);
    }

    public boolean crear() {
        boolean est = false;
        this.session = null;
        this.transaction = null;
        this.error = null;
        try {
            this.session = HibernateUtil.getSessionFactory().openSession();
            this.transaction = session.beginTransaction();
            DaoUsuario daoUsuario = new DaoUsuario();
            DaoPersona daoPersona = new DaoPersona();
            //verificar que no se repita el usuario
            if (daoUsuario.leerPorUsuario(this.session, this.usuario.getUsuario()) != null) {
                this.error = "El usuario ya se encuentra registrado.";
                //terminamos ejecución del programa
                return false;
            }
            //verificar que las contraseñas coincidan
            if (!this.usuario.getContrasenia().equals(this.repetirContraseniaNueva)) {
                this.error = "Las contraseñas no coinciden.";
                return false;
            }
            //verificar que la persona no tenga asigando un usuario
            if (daoUsuario.leerPorCodigoPersona(this.session, this.codPersona) != null) {
                this.error = "La persona ya cuenta con un usuario.";
                return false;
            }
            //asignamos la persona
            this.usuario.setPersona(daoPersona.leerPorCodigo(this.session, this.codPersona));
            //fecha de registro
            this.usuario.setRegistro(Utilitarios.registro("1", this.codUsuarioSession));
            //obtenemos el código autogenerado en la base de datos
            int codUsuario = daoUsuario.registrar(this.session, this.usuario);
            //actualizamos el código generado
            this.usuario.setCodUsuario(codUsuario);
            this.transaction.commit();
            est = true;
        } catch (Exception e) {
            if (this.transaction != null) {
                this.transaction.rollback();
            }
            this.error = "Contacte al administrador << " + e.getMessage() + " >>";
            e.printStackTrace();
        } finally {
            if (this.session != null) {
                this.session.close();
            }
        }
        return est;
    }

    public Usuario iniciarSession(String usuario, String contrasenia) {
        this.session = null;
        this.transaction = null;
        this.error = null;
        try {
            this.session = HibernateUtil.getSessionFactory().openSession();
            this.transaction = session.beginTransaction();
            DaoUsuario daoUsuario = new DaoUsuario();
            this.usuario = null;
            this.usuario = daoUsuario.leerPorUsuario(this.session, usuario);
            //si en caso hay un ususario
            if (this.usuario != null) {
                //si la contraseña ingresada no coicide con la del servidor
                if (!this.usuario.getContrasenia().equals(MD5.md5(contrasenia))) {
                    this.usuario = null;
                }
            }
            this.transaction.commit();
        } catch (Exception e) {
            if (this.transaction != null) {
                this.transaction.rollback();
            }
            //en caso de error poner a NULL el usuario
            this.usuario = null;
            this.error = "Contacte al administrador << " + e.getMessage() + " >>";
            e.printStackTrace();
        } finally {
            if (this.session != null) {
                this.session.close();
            }
        }
        return this.usuario;
    }

    public boolean actualizarPrivilegio(int codUsuario, boolean p1, boolean p2,
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
        boolean est = false;
        this.session = null;
        this.transaction = null;
        this.error = null;
        try {
            this.session = HibernateUtil.getSessionFactory().openSession();
            this.transaction = session.beginTransaction();
            DaoUsuario daoUsuario = new DaoUsuario();
            //recuperar el usuario
            this.usuario = daoUsuario.leerPorCodigoUsuario(this.session, codUsuario);
            //actualizamos parámetros
            this.usuario.setP1(p1);
            this.usuario.setP2(p2);
            this.usuario.setP3(p3);
            this.usuario.setP4(p4);
            this.usuario.setP5(p5);
            this.usuario.setP6(p6);
            this.usuario.setP7(p7);
            this.usuario.setP8(p8);
            this.usuario.setP9(p9);
            this.usuario.setP10(p10);
            this.usuario.setP11(p11);
            this.usuario.setP12(p12);
            this.usuario.setP13(p13);
            this.usuario.setP14(p14);
            this.usuario.setP15(p15);
            this.usuario.setP16(p16);
            this.usuario.setP17(p17);
            this.usuario.setP18(p18);
            this.usuario.setP19(p19);
            this.usuario.setP20(p20);
            this.usuario.setP21(p21);
            this.usuario.setP22(p22);
            this.usuario.setP23(p23);
            this.usuario.setP24(p24);
            this.usuario.setP25(p25);
            this.usuario.setP26(p26);
            this.usuario.setP27(p27);
            this.usuario.setP28(p28);
            this.usuario.setP29(p29);
            this.usuario.setP30(p30);
            this.usuario.setP31(p31);
            this.usuario.setP32(p32);
            this.usuario.setP33(p33);
            this.usuario.setP34(p34);
            this.usuario.setP35(p35);
            this.usuario.setP36(p36);
            this.usuario.setP37(p37);
            this.usuario.setP38(p38);
            this.usuario.setP39(p39);
            this.usuario.setP40(p40);
            this.usuario.setP41(p41);
            this.usuario.setP42(p42);
            this.usuario.setP43(p43);
            this.usuario.setP44(p44);
            this.usuario.setP45(p45);
            this.usuario.setP46(p46);
            this.usuario.setP47(p47);
            this.usuario.setP48(p48);
            this.usuario.setP49(p49);
            this.usuario.setP50(p50);
            this.usuario.setP51(p51);
            this.usuario.setP52(p52);
            this.usuario.setP53(p53);
            this.usuario.setP54(p54);
            this.usuario.setP55(p55);
            this.usuario.setP56(p56);
            this.usuario.setP57(p57);
            this.usuario.setP58(p58);
            this.usuario.setP59(p59);
            this.usuario.setP60(p60);
            this.usuario.setRegistro(Utilitarios.registro("1", this.codUsuarioSession) + ":" + this.usuario.getRegistro());
            //actualizamos
            daoUsuario.actualizar(this.session, this.usuario);
            this.transaction.commit();
            est = true;
        } catch (Exception e) {
            if (this.transaction != null) {
                this.transaction.rollback();
            }
            this.error = "Contacte al administrador << " + e.getMessage() + " >>";
            e.printStackTrace();
        } finally {
            if (this.session != null) {
                this.session.close();
            }
        }
        return est;
    }

    public boolean actualizarContrasenia(String contraseniaAnterior, String contraseniaNueva) {
        boolean est = false;
        this.session = null;
        this.transaction = null;
        this.error = null;
        try {
            this.session = HibernateUtil.getSessionFactory().openSession();
            this.transaction = session.beginTransaction();
            DaoUsuario daoUsuario = new DaoUsuario();
            //recuperar el usuario
            this.usuario = daoUsuario.leerPorCodigoUsuario(this.session, this.codUsuarioSession);
            //comparar si la contraseña es igual
            if (!MD5.md5(contraseniaAnterior).equals(this.usuario.getContrasenia())) {
                this.error = "La contreña anterior no coincide.";
                return false;
            }
            //verificar que las contraseñas nuevas sean iguales
            if (!contraseniaNueva.equals(this.repetirContraseniaNueva)) {
                this.error = "Las contraseñas no coinciden.";
                return false;
            }
            this.usuario.setRegistro(Utilitarios.registro("1", this.codUsuarioSession) + ":" + this.usuario.getRegistro());
            //actualizamos parámetros
            this.usuario.setContrasenia(MD5.md5(contraseniaNueva));
            this.usuario.setRegistro(Utilitarios.registro("1", this.codUsuarioSession) + ":" + this.usuario.getRegistro());
            //actualizamos
            daoUsuario.actualizar(this.session, this.usuario);
            this.transaction.commit();
            //cerramos sesion
            est = true;
        } catch (Exception e) {
            if (this.transaction != null) {
                this.transaction.rollback();
            }
            this.error = "Contacte al administrador << " + e.getMessage() + " >>";
            e.printStackTrace();
        } finally {
            if (this.session != null) {
                this.session.close();
            }
        }
        return est;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public List<Usuario> getUsuarioList() {
        return usuarioList;
    }

    public void setUsuarioList(List<Usuario> usuarioList) {
        this.usuarioList = usuarioList;
    }

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public String getRepetirContraseniaNueva() {
        return repetirContraseniaNueva;
    }

    public void setRepetirContraseniaNueva(String repetirContraseniaNueva) {
        this.repetirContraseniaNueva = repetirContraseniaNueva;
    }

    public int getCodPersona() {
        return codPersona;
    }

    public void setCodPersona(int codPersona) {
        this.codPersona = codPersona;
    }

    public int getCodUsuarioSession() {
        return codUsuarioSession;
    }

    public void setCodUsuarioSession(int codUsuarioSession) {
        this.codUsuarioSession = codUsuarioSession;
    }

}
