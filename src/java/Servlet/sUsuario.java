/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import Clase.Fecha;
import Ejb.EjbUsuario;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import tablas.Usuario;

/**
 *
 * @author Henrri
 */
@WebServlet(name = "sUsuario", urlPatterns = {"/sUsuario"})
public class sUsuario extends HttpServlet {

    @EJB
    private EjbUsuario ejbUsuario;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        //obtenemos la sesión
        HttpSession session = request.getSession();
        //tomamos la acción a recibir
        String accion = request.getParameter("accionUsuario");
        //si en caso no hay sesión especificada
        if (accion == null) {
            session.removeAttribute("codUsuarioMantenimiento");
            response.sendRedirect("persona/usuarioMantenimiento.jsp");
            return;
        }
        if ("ingresar".equals(accion)) {
            String usuario = request.getParameter("usuario");
            String contrasenia = request.getParameter("contrasenia");
            //inicializamos
            ejbUsuario = new EjbUsuario();
            //consultamos
            ejbUsuario.iniciarSession(usuario, contrasenia);
            //si hay usuario
            if (ejbUsuario.getUsuario() != null) {
                //creamos las session
                session.setAttribute("usuario", ejbUsuario.getUsuario());
                out.print("1");
                //si no hay error
            } else if (ejbUsuario.getError() == null) {
                out.print("Usuario o contraseña incorrecta");
            } else {
                out.print(ejbUsuario.getError());
            }

            return;
        }
        if (accion.equals("sesionCerrar")) {
            session.invalidate();
            out.print(true);
        }
        if (accion.equals("permisos")) {
            Usuario objUsuario = (Usuario) session.getAttribute("usuario");
            out.print("[{");
            out.print("\"usuario\":\"" + objUsuario.getUsuario() + "\"");
            out.print(",\"permiso1\" :" + objUsuario.getP1());
            out.print(", \"permiso2\" :" + objUsuario.getP2());
            out.print(", \"permiso3\" :" + objUsuario.getP3());
            out.print(", \"permiso4\" :" + objUsuario.getP4());
            out.print(", \"permiso5\" :" + objUsuario.getP5());
            out.print(", \"permiso6\" :" + objUsuario.getP6());
            out.print(", \"permiso7\" :" + objUsuario.getP7());
            out.print(", \"permiso8\" :" + objUsuario.getP8());
            out.print(", \"permiso9\" :" + objUsuario.getP9());
            out.print(", \"permiso10\" :" + objUsuario.getP10());
            out.print(", \"permiso11\" :" + objUsuario.getP11());
            out.print(", \"permiso12\" :" + objUsuario.getP12());
            out.print(", \"permiso13\" :" + objUsuario.getP13());
            out.print(", \"permiso14\" :" + objUsuario.getP14());
            out.print(", \"permiso15\" :" + objUsuario.getP15());
            out.print(", \"permiso16\" :" + objUsuario.getP16());
            out.print(", \"permiso17\" :" + objUsuario.getP17());
            out.print(", \"permiso18\" :" + objUsuario.getP18());
            out.print(", \"permiso19\" :" + objUsuario.getP19());
            out.print(", \"permiso20\" :" + objUsuario.getP20());
            out.print(", \"permiso21\" :" + objUsuario.getP21());
            out.print(", \"permiso22\" :" + objUsuario.getP22());
            out.print(", \"permiso23\" :" + objUsuario.getP23());
            out.print(", \"permiso24\" :" + objUsuario.getP24());
            out.print(", \"permiso25\" :" + objUsuario.getP25());
            out.print(", \"permiso26\" :" + objUsuario.getP26());
            out.print(", \"permiso27\" :" + objUsuario.getP27());
            out.print(", \"permiso28\" :" + objUsuario.getP28());
            out.print(", \"permiso29\" :" + objUsuario.getP29());
            out.print(", \"permiso30\" :" + objUsuario.getP30());
            out.print(", \"permiso31\" :" + objUsuario.getP31());
            out.print(", \"permiso32\" :" + objUsuario.getP32());
            out.print(", \"permiso33\" :" + objUsuario.getP33());
            out.print(", \"permiso34\" :" + objUsuario.getP34());
            out.print(", \"permiso35\" :" + objUsuario.getP35());
            out.print(", \"permiso36\" :" + objUsuario.getP36());
            out.print(", \"permiso37\" :" + objUsuario.getP37());
            out.print(", \"permiso38\" :" + objUsuario.getP38());
            out.print(", \"permiso39\" :" + objUsuario.getP39());
            out.print(", \"permiso40\" :" + objUsuario.getP40());
            out.print(", \"permiso41\" :" + objUsuario.getP41());
            out.print(", \"permiso42\" :" + objUsuario.getP42());
            out.print(", \"permiso43\" :" + objUsuario.getP43());
            out.print(", \"permiso44\" :" + objUsuario.getP44());
            out.print(", \"permiso45\" :" + objUsuario.getP45());
            out.print(", \"permiso46\" :" + objUsuario.getP46());
            out.print(", \"permiso47\" :" + objUsuario.getP47());
            out.print(", \"permiso48\" :" + objUsuario.getP48());
            out.print(", \"permiso49\" :" + objUsuario.getP49());
            out.print(", \"permiso50\" :" + objUsuario.getP50());
            out.print(", \"permiso51\" :" + objUsuario.getP51());
            out.print(", \"permiso52\" :" + objUsuario.getP52());
            out.print(", \"permiso53\" :" + objUsuario.getP53());
            out.print(", \"permiso54\" :" + objUsuario.getP54());
            out.print(", \"permiso55\" :" + objUsuario.getP55());
            out.print(", \"permiso56\" :" + objUsuario.getP56());
            out.print(", \"permiso57\" :" + objUsuario.getP57());
            out.print(", \"permiso58\" :" + objUsuario.getP58());
            out.print(", \"permiso59\" :" + objUsuario.getP59());
            out.print(", \"permiso60\" :" + objUsuario.getP60());
            out.print("}]");
            return;
        }
        if ("sesionComprobar".equals(accion)) {
            String tipo = request.getParameter("tipo");
            //en caso de se cargue por primera vez una pagina
            if ("cargaPagina".equals(tipo)) {
                //seteamos la fecha actual
                session.setAttribute("fechaAcceso", new Date());
                Usuario objUsuario = (Usuario) session.getAttribute("usuario");
                if (objUsuario == null) {
                    out.print("No ha iniciado sesión.");
                } else {
                    out.print("1");
                }
            } else {
                Usuario objUsuario = (Usuario) session.getAttribute("usuario");
                if (objUsuario == null) {
                    out.print("No ha iniciado sesión.");
                    return;
                }
                Date ultimoUso = (Date) session.getAttribute("fechaAcceso");
                if (ultimoUso == null) {
                    ultimoUso = new Date();
                    session.setAttribute("fechaAcceso", ultimoUso);
                }
                //si es mayor en x minutos
                int tiempo = 60;//
                if (new Fecha().diferenciaMinuto(ultimoUso, new Date()) > tiempo) {
                    session.invalidate();
                    out.print("Se ha cerrado la sesión por sobrepasar el tiempo de inactividad.");
                } else {
                    out.print("1");
                }
            }
            return;
        }
        if ("registrar".equals(accion)) {
            Usuario objUsuario = (Usuario) session.getAttribute("usuario");
            if (!objUsuario.getP44()) {
                out.print("No tiene persmisos para realizar esta accion.");
                return;
            }
            try {
                ejbUsuario = new EjbUsuario();
                ejbUsuario.getUsuario().setUsuario(request.getParameter("usuarioNuevo").toString());
                ejbUsuario.getUsuario().setContrasenia(request.getParameter("contraseniaNueva").toString());
                ejbUsuario.setRepetirContraseniaNueva(request.getParameter("repetirContraseniaNueva").toString());
                ejbUsuario.getUsuario().setEstado(Boolean.parseBoolean(request.getParameter("estado").toString()));
                ejbUsuario.setCodPersona(Integer.parseInt(request.getParameter("codPersona")));
                ejbUsuario.getUsuario().setP1(request.getParameter("p1") != null);
                ejbUsuario.getUsuario().setP2(request.getParameter("p2") != null);
                ejbUsuario.getUsuario().setP3(request.getParameter("p3") != null);
                ejbUsuario.getUsuario().setP4(request.getParameter("p4") != null);
                ejbUsuario.getUsuario().setP5(request.getParameter("p5") != null);
                ejbUsuario.getUsuario().setP6(request.getParameter("p6") != null);
                ejbUsuario.getUsuario().setP7(request.getParameter("p7") != null);
                ejbUsuario.getUsuario().setP8(request.getParameter("p8") != null);
                ejbUsuario.getUsuario().setP9(request.getParameter("p9") != null);
                ejbUsuario.getUsuario().setP10(request.getParameter("p10") != null);
                ejbUsuario.getUsuario().setP11(request.getParameter("p11") != null);
                ejbUsuario.getUsuario().setP12(request.getParameter("p12") != null);
                ejbUsuario.getUsuario().setP13(request.getParameter("p13") != null);
                ejbUsuario.getUsuario().setP14(request.getParameter("p14") != null);
                ejbUsuario.getUsuario().setP15(request.getParameter("p15") != null);
                ejbUsuario.getUsuario().setP16(request.getParameter("p16") != null);
                ejbUsuario.getUsuario().setP17(request.getParameter("p17") != null);
                ejbUsuario.getUsuario().setP18(request.getParameter("p18") != null);
                ejbUsuario.getUsuario().setP19(request.getParameter("p19") != null);
                ejbUsuario.getUsuario().setP20(request.getParameter("p20") != null);
                ejbUsuario.getUsuario().setP21(request.getParameter("p21") != null);
                ejbUsuario.getUsuario().setP22(request.getParameter("p22") != null);
                ejbUsuario.getUsuario().setP23(request.getParameter("p23") != null);
                ejbUsuario.getUsuario().setP24(request.getParameter("p24") != null);
                ejbUsuario.getUsuario().setP25(request.getParameter("p25") != null);
                ejbUsuario.getUsuario().setP26(request.getParameter("p26") != null);
                ejbUsuario.getUsuario().setP27(request.getParameter("p27") != null);
                ejbUsuario.getUsuario().setP28(request.getParameter("p28") != null);
                ejbUsuario.getUsuario().setP29(request.getParameter("p29") != null);
                ejbUsuario.getUsuario().setP30(request.getParameter("p30") != null);
                ejbUsuario.getUsuario().setP31(request.getParameter("p31") != null);
                ejbUsuario.getUsuario().setP32(request.getParameter("p32") != null);
                ejbUsuario.getUsuario().setP33(request.getParameter("p33") != null);
                ejbUsuario.getUsuario().setP34(request.getParameter("p34") != null);
                ejbUsuario.getUsuario().setP35(request.getParameter("p35") != null);
                ejbUsuario.getUsuario().setP36(request.getParameter("p36") != null);
                ejbUsuario.getUsuario().setP37(request.getParameter("p37") != null);
                ejbUsuario.getUsuario().setP38(request.getParameter("p38") != null);
                ejbUsuario.getUsuario().setP39(request.getParameter("p39") != null);
                ejbUsuario.getUsuario().setP40(request.getParameter("p40") != null);
                ejbUsuario.getUsuario().setP41(request.getParameter("p41") != null);
                ejbUsuario.getUsuario().setP42(request.getParameter("p42") != null);
                ejbUsuario.getUsuario().setP43(request.getParameter("p43") != null);
                ejbUsuario.getUsuario().setP44(request.getParameter("p44") != null);
                ejbUsuario.getUsuario().setP45(request.getParameter("p45") != null);
                ejbUsuario.getUsuario().setP46(request.getParameter("p46") != null);
                ejbUsuario.getUsuario().setP47(request.getParameter("p47") != null);
                ejbUsuario.getUsuario().setP48(request.getParameter("p48") != null);
                ejbUsuario.getUsuario().setP49(request.getParameter("p49") != null);
                ejbUsuario.getUsuario().setP50(request.getParameter("p50") != null);
                ejbUsuario.getUsuario().setP51(request.getParameter("p51") != null);
                ejbUsuario.getUsuario().setP52(request.getParameter("p52") != null);
                ejbUsuario.getUsuario().setP53(request.getParameter("p53") != null);
                ejbUsuario.getUsuario().setP54(request.getParameter("p54") != null);
                ejbUsuario.getUsuario().setP55(request.getParameter("p55") != null);
                ejbUsuario.getUsuario().setP56(request.getParameter("p56") != null);
                ejbUsuario.getUsuario().setP57(request.getParameter("p57") != null);
                ejbUsuario.getUsuario().setP58(request.getParameter("p58") != null);
                ejbUsuario.getUsuario().setP59(request.getParameter("p59") != null);
                ejbUsuario.getUsuario().setP60(request.getParameter("p60") != null);
                ejbUsuario.setCodUsuarioSession(objUsuario.getCodUsuario());
                String respuesta = ejbUsuario.crear()
                        ? ejbUsuario.getUsuario().getCodUsuario() + ""
                        : ("Error al registrar: " + ejbUsuario.getError());
                out.print(respuesta);
            } catch (Exception e) {
                out.print("Error en parametros");
            }
            return;
        }
        if ("editarPrivilegio".equals(accion)) {
            Usuario objUsuario = (Usuario) session.getAttribute("usuario");
            try {
                int codUsuario = Integer.parseInt(request.getParameter("codUsuario"));
                if (codUsuario == 1) {
                    out.print("Usuario bloqueado.");
                    return;
                }
                ejbUsuario = new EjbUsuario();
                boolean p1 = request.getParameter("p1") != null;
                boolean p2 = request.getParameter("p2") != null;
                boolean p3 = request.getParameter("p3") != null;
                boolean p4 = request.getParameter("p4") != null;
                boolean p5 = request.getParameter("p5") != null;
                boolean p6 = request.getParameter("p6") != null;
                boolean p7 = request.getParameter("p7") != null;
                boolean p8 = request.getParameter("p8") != null;
                boolean p9 = request.getParameter("p9") != null;
                boolean p10 = request.getParameter("p10") != null;
                boolean p11 = request.getParameter("p11") != null;
                boolean p12 = request.getParameter("p12") != null;
                boolean p13 = request.getParameter("p13") != null;
                boolean p14 = request.getParameter("p14") != null;
                boolean p15 = request.getParameter("p15") != null;
                boolean p16 = request.getParameter("p16") != null;
                boolean p17 = request.getParameter("p17") != null;
                boolean p18 = request.getParameter("p18") != null;
                boolean p19 = request.getParameter("p19") != null;
                boolean p20 = request.getParameter("p20") != null;
                boolean p21 = request.getParameter("p21") != null;
                boolean p22 = request.getParameter("p22") != null;
                boolean p23 = request.getParameter("p23") != null;
                boolean p24 = request.getParameter("p24") != null;
                boolean p25 = request.getParameter("p25") != null;
                boolean p26 = request.getParameter("p26") != null;
                boolean p27 = request.getParameter("p27") != null;
                boolean p28 = request.getParameter("p28") != null;
                boolean p29 = request.getParameter("p29") != null;
                boolean p30 = request.getParameter("p30") != null;
                boolean p31 = request.getParameter("p31") != null;
                boolean p32 = request.getParameter("p32") != null;
                boolean p33 = request.getParameter("p33") != null;
                boolean p34 = request.getParameter("p34") != null;
                boolean p35 = request.getParameter("p35") != null;
                boolean p36 = request.getParameter("p36") != null;
                boolean p37 = request.getParameter("p37") != null;
                boolean p38 = request.getParameter("p38") != null;
                boolean p39 = request.getParameter("p39") != null;
                boolean p40 = request.getParameter("p40") != null;
                boolean p41 = request.getParameter("p41") != null;
                boolean p42 = request.getParameter("p42") != null;
                boolean p43 = request.getParameter("p43") != null;
                boolean p44 = request.getParameter("p44") != null;
                boolean p45 = request.getParameter("p45") != null;
                boolean p46 = request.getParameter("p46") != null;
                boolean p47 = request.getParameter("p47") != null;
                boolean p48 = request.getParameter("p48") != null;
                boolean p49 = request.getParameter("p49") != null;
                boolean p50 = request.getParameter("p50") != null;
                boolean p51 = request.getParameter("p51") != null;
                boolean p52 = request.getParameter("p52") != null;
                boolean p53 = request.getParameter("p53") != null;
                boolean p54 = request.getParameter("p54") != null;
                boolean p55 = request.getParameter("p55") != null;
                boolean p56 = request.getParameter("p56") != null;
                boolean p57 = request.getParameter("p57") != null;
                boolean p58 = request.getParameter("p58") != null;
                boolean p59 = request.getParameter("p59") != null;
                boolean p60 = request.getParameter("p60") != null;
                ejbUsuario.setCodUsuarioSession(objUsuario.getCodUsuario());
                String respuesta
                        = ejbUsuario.actualizarPrivilegio(
                                codUsuario, p1, p2, p3, p4, p5, p6, p7, p8, p9,
                                p10, p11, p12, p13, p14, p15, p16, p17, p18,
                                p19, p20, p21, p22, p23, p24, p25, p26, p27,
                                p28, p29, p30, p31, p32, p33, p34, p35, p36,
                                p37, p38, p39, p40, p41, p42, p43, p44, p45,
                                p46, p47, p48, p49, p50, p51, p52, p53, p54,
                                p55, p56, p57, p58, p59, p60)
                        ? ejbUsuario.getUsuario().getCodUsuario() + ""
                        : ("Error al actualizar: " + ejbUsuario.getError());
                out.print(respuesta);
            } catch (Exception e) {
                out.print("Error en parametros");
            }
            return;
        }
        if ("contraseniaCambiar".equals(accion)) {
            Usuario objUsuario = (Usuario) session.getAttribute("usuario");
            String contraseniaAnterior;
            String contraseniaNueva;
            ejbUsuario = new EjbUsuario();
            try {
                contraseniaAnterior = request.getParameter("contraseniaAnterior").toString();
                contraseniaNueva = request.getParameter("contraseniaNueva").toString();
                ejbUsuario.setRepetirContraseniaNueva(request.getParameter("contraseniaNuevaRepetir"));
                ejbUsuario.setCodUsuarioSession(objUsuario.getCodUsuario());
            } catch (Exception e) {
                out.print("Error en parametros.");
                return;
            }
            String respuesta
                    = ejbUsuario.actualizarContrasenia(contraseniaAnterior, contraseniaNueva)
                    ? (ejbUsuario.getUsuario().getCodUsuario()) + ""
                    : ejbUsuario.getError();
            out.print(respuesta);
            return;
        }
        if (accion.equals("mantenimiento")) {
            session.removeAttribute("codUsuarioMantenimiento");
            try {
                session.setAttribute("codUsuarioMantenimiento", Integer.parseInt("codUsuario"));
            } catch (Exception e) {
            }
            response.sendRedirect("persona/usuarioMantenimiento.jsp");
        }
        out.print("Acción <" + accion + "> no implementada.");
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
