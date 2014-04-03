/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package personaServlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import personaClases.cPersona;
import personaClases.cUsuario;
import tablas.Persona;
import tablas.Usuario;
import utilitarios.cOtros;

/**
 *
 * @author Henrri
 */
@WebServlet(name = "sUsuario", urlPatterns = {"/sUsuario"})
public class sUsuario extends HttpServlet {

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

        HttpSession session = request.getSession();

        String accion = request.getParameter("accionUsuario");
        //no declarar la clase dentro del sistema
        int codUsuario;
        String usuario, contrasenia;

        Usuario objUsuario = (Usuario) session.getAttribute("usuario");
        cOtros objcOtros = new cOtros();
        if (accion == null) {
            session.removeAttribute("codUsuarioMantenimiento");
            response.sendRedirect("persona/usuarioMantenimiento.jsp");
        } else {
            cUsuario objcUsuario = new cUsuario();
            //***********************************
            if (accion.equals("registrar")) {
                if (!objUsuario.getP44()) {
                    out.print("No tiene persmisos para realizar esta accion");
                    return;
                }
                try {
                    Usuario objUsuario1 = new Usuario();
                    objUsuario1.setUsuario(request.getParameter("usuarioNuevo").toString());
                    objUsuario1.setContrasenia(objcOtros.md5(request.getParameter("contraseniaNueva").toString()));
                    objUsuario1.setIp("ALL");
                    objUsuario1.setEstado(Boolean.parseBoolean(request.getParameter("estado").toString()));
                    Persona objPersona = new cPersona().leer_cod(Integer.parseInt(request.getParameter("codPersona")));
                    if (verificarPersona(objPersona)) {
                        out.print("El personal ya tiene un usuario asignado.");
                        return;
                    }
                    objUsuario1.setPersona(objPersona);
                    objUsuario1.setP1(Boolean.parseBoolean(request.getParameter("p1")));
                    objUsuario1.setP2(Boolean.parseBoolean(request.getParameter("p2")));
                    objUsuario1.setP3(Boolean.parseBoolean(request.getParameter("p3")));
                    objUsuario1.setP4(Boolean.parseBoolean(request.getParameter("p4")));
                    objUsuario1.setP5(Boolean.parseBoolean(request.getParameter("p5")));
                    objUsuario1.setP6(Boolean.parseBoolean(request.getParameter("p6")));
                    objUsuario1.setP7(Boolean.parseBoolean(request.getParameter("p7")));
                    objUsuario1.setP8(Boolean.parseBoolean(request.getParameter("p8")));
                    objUsuario1.setP9(Boolean.parseBoolean(request.getParameter("p9")));
                    objUsuario1.setP10(Boolean.parseBoolean(request.getParameter("p10")));
                    objUsuario1.setP11(Boolean.parseBoolean(request.getParameter("p11")));
                    objUsuario1.setP12(Boolean.parseBoolean(request.getParameter("p12")));
                    objUsuario1.setP13(Boolean.parseBoolean(request.getParameter("p13")));
                    objUsuario1.setP14(Boolean.parseBoolean(request.getParameter("p14")));
                    objUsuario1.setP15(Boolean.parseBoolean(request.getParameter("p15")));
                    objUsuario1.setP16(Boolean.parseBoolean(request.getParameter("p16")));
                    objUsuario1.setP17(Boolean.parseBoolean(request.getParameter("p17")));
                    objUsuario1.setP18(Boolean.parseBoolean(request.getParameter("p18")));
                    objUsuario1.setP19(Boolean.parseBoolean(request.getParameter("p19")));
                    objUsuario1.setP20(Boolean.parseBoolean(request.getParameter("p20")));
                    objUsuario1.setP21(Boolean.parseBoolean(request.getParameter("p21")));
                    objUsuario1.setP22(Boolean.parseBoolean(request.getParameter("p22")));
                    objUsuario1.setP23(Boolean.parseBoolean(request.getParameter("p23")));
                    objUsuario1.setP24(Boolean.parseBoolean(request.getParameter("p24")));
                    objUsuario1.setP25(Boolean.parseBoolean(request.getParameter("p25")));
                    objUsuario1.setP26(Boolean.parseBoolean(request.getParameter("p26")));
                    objUsuario1.setP27(Boolean.parseBoolean(request.getParameter("p27")));
                    objUsuario1.setP28(Boolean.parseBoolean(request.getParameter("p28")));
                    objUsuario1.setP29(Boolean.parseBoolean(request.getParameter("p29")));
                    objUsuario1.setP30(Boolean.parseBoolean(request.getParameter("p30")));
                    objUsuario1.setP31(Boolean.parseBoolean(request.getParameter("p31")));
                    objUsuario1.setP32(Boolean.parseBoolean(request.getParameter("p32")));
                    objUsuario1.setP33(Boolean.parseBoolean(request.getParameter("p33")));
                    objUsuario1.setP34(Boolean.parseBoolean(request.getParameter("p34")));
                    objUsuario1.setP35(Boolean.parseBoolean(request.getParameter("p35")));
                    objUsuario1.setP36(Boolean.parseBoolean(request.getParameter("p36")));
                    objUsuario1.setP37(Boolean.parseBoolean(request.getParameter("p37")));
                    objUsuario1.setP38(Boolean.parseBoolean(request.getParameter("p38")));
                    objUsuario1.setP39(Boolean.parseBoolean(request.getParameter("p39")));
                    objUsuario1.setP40(Boolean.parseBoolean(request.getParameter("p40")));
                    objUsuario1.setP41(Boolean.parseBoolean(request.getParameter("p41")));
                    objUsuario1.setP42(Boolean.parseBoolean(request.getParameter("p42")));
                    objUsuario1.setP43(Boolean.parseBoolean(request.getParameter("p43")));
                    objUsuario1.setP44(Boolean.parseBoolean(request.getParameter("p44")));
                    objUsuario1.setP45(Boolean.parseBoolean(request.getParameter("p45")));
                    objUsuario1.setP46(Boolean.parseBoolean(request.getParameter("p46")));
                    objUsuario1.setP47(Boolean.parseBoolean(request.getParameter("p47")));
                    objUsuario1.setP48(Boolean.parseBoolean(request.getParameter("p48")));
                    objUsuario1.setP49(Boolean.parseBoolean(request.getParameter("p49")));
                    objUsuario1.setP50(Boolean.parseBoolean(request.getParameter("p50")));
                    objUsuario1.setP51(Boolean.parseBoolean(request.getParameter("p51")));
                    objUsuario1.setP52(Boolean.parseBoolean(request.getParameter("p52")));
                    objUsuario1.setP53(Boolean.parseBoolean(request.getParameter("p53")));
                    objUsuario1.setP54(Boolean.parseBoolean(request.getParameter("p54")));
                    objUsuario1.setP55(Boolean.parseBoolean(request.getParameter("p55")));
                    objUsuario1.setP56(Boolean.parseBoolean(request.getParameter("p56")));
                    objUsuario1.setP57(Boolean.parseBoolean(request.getParameter("p57")));
                    objUsuario1.setP58(Boolean.parseBoolean(request.getParameter("p58")));
                    objUsuario1.setP59(Boolean.parseBoolean(request.getParameter("p59")));
                    objUsuario1.setP60(Boolean.parseBoolean(request.getParameter("p60")));
                    objUsuario1.setRegistro(objcOtros.registro("1", objUsuario.getCodUsuario().toString()));
                    objUsuario1.setCodUsuario(objcUsuario.Crear(objUsuario1));
                    out.print(objUsuario1.getCodUsuario() == 0 ? "Error en registro: " + objcUsuario.getError() : objUsuario1.getCodUsuario());
                } catch (Exception e) {
                    out.print("Error en parametros");
                }
            }
            if (accion.equals("sesionComprobar")) {
                if (objUsuario == null) {
                    out.print("error");
                } else {
                    out.print("1");
                }
            }
            if (accion.equals("ingresar")) {
                usuario = request.getParameter("usuario");
                contrasenia = request.getParameter("contrasenia");
                objUsuario = new cUsuario().ingresar(usuario, contrasenia);
                if (objUsuario == null) {
                    out.print("*Usuario o contraseña incorrectas.");
                } else {
                    session.removeAttribute("usuario");
                    session.setAttribute("usuario", objUsuario);
                    out.print("1");
                }
            }
            if (accion.equals("mantenimiento")) {
                session.removeAttribute("codUsuarioMantenimiento");
                try {
                    session.setAttribute("codUsuarioMantenimiento", Integer.parseInt("codUsuario"));
                } catch (Exception e) {
                }
                response.sendRedirect("persona/usuarioMantenimiento.jsp");
            }
            if (accion.equals("permisos")) {
                objUsuario = new cUsuario().leer_cod(objUsuario.getCodUsuario());
                session.setAttribute("usuario", objUsuario);
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
            }
            if (accion.equals("sesionCerrar")) {
                session.invalidate();
                out.print(true);
            }

            if (accion.equals("editarPrivilegio")) {
                try {
                    codUsuario = Integer.parseInt(request.getParameter("codUsuario"));
                    if (codUsuario == 1) {
                        out.print("Usuario bloqueado.");
                        return;
                    }
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

                    boolean editar = new cUsuario().editarPrivilegios(codUsuario, p1,
                            p2, p3, p4, p5, p6, p7, p8, p9, p10, p11,
                            p12, p13, p14, p15, p16, p17, p18, p19, p20,
                            p21, p22, p23, p24, p25, p26, p27, p28, p29,
                            p30, p31, p32, p33, p34, p35, p36, p37, p38,
                            p39, p40, p41, p42, p43, p44, p45, p46, p47,
                            p48, p49, p50, p51, p52, p53, p54, p55, p56,
                            p57, p58, p59, p60);
                    out.print(editar ? codUsuario : "Error en actualización.");
                } catch (Exception e) {
                    out.print("Error en parametros");
                }
            }

            if (accion.equals("contraseniaCambiar")) {
                String contraseniaAnterior;
                String contraseniaNueva;
                String contraseniaNuevaRepetir;
                try {
                    contraseniaAnterior = request.getParameter("contraseniaAnterior").toString();
                    contraseniaNueva = request.getParameter("contraseniaNueva").toString();
                    contraseniaNuevaRepetir = request.getParameter("contraseniaNuevaRepetir").toString();
                } catch (Exception e) {
                    out.print("Error en parametros");
                    return;
                }
                if (!objUsuario.getContrasenia().equals(contraseniaAnterior)) {
                    out.print("La contraseña no coincide.");
                    return;
                }
                if (!contraseniaNueva.equals(contraseniaNuevaRepetir)) {
                    out.print("La contraseñas nuevas no coinciden.");
                    return;
                }
                boolean estado = new cUsuario().editarContrasenia(objUsuario.getCodUsuario(), contraseniaNueva);
                session.invalidate();
                out.print(estado ? objUsuario.getCodUsuario() : "Error en actualización de contraseña.");
            }
            if (accion.equals("c")) {
                session.invalidate();
                response.sendRedirect("");
            }
        }
    }

    private boolean verificarPersona(Persona objPersona) {
        Boolean estado = false;
        if (objPersona != null) {
            for (Usuario objUsuario2 : objPersona.getUsuarios()) {
                if (objUsuario2.getRegistro().substring(0, 1).equals("1") || objUsuario2.getRegistro().substring(0, 1).equals("0")) {
                    estado = true;
                }
            }
        }
        return estado;
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
