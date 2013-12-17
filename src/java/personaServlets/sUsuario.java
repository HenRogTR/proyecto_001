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
     * Processes requests for both HTTP
     * <code>GET</code> and
     * <code>POST</code> methods.
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
            if (accion.equals("editarPermisoCliente")) {
                try {
                    codUsuario = Integer.parseInt(request.getParameter("codUsuario"));
                    if (codUsuario == 1) {
                        out.print("Usuario bloqueado.");
                        return;
                    }
                    boolean p1 = request.getParameter("p1") == null ? false : true;
                    boolean p2 = request.getParameter("p2") == null ? false : true;
                    boolean p29 = request.getParameter("p29") == null ? false : true;
                    out.print(objcUsuario.editarClientePermiso(codUsuario, p1, p2, p29) ? codUsuario : "Error en actualizar.");
                } catch (Exception e) {
                    out.print("Error en parametros");
                }
            }
            if (accion.equals("editarPermisoVenta")) {
                try {
                    codUsuario = Integer.parseInt(request.getParameter("codUsuario"));
                    if (codUsuario == 1) {
                        out.print("Usuario bloqueado.");
                        return;
                    }
                    boolean p18 = request.getParameter("p18") == null ? false : true;
                    boolean p23 = request.getParameter("p23") == null ? false : true;
                    boolean p31 = request.getParameter("p31") == null ? false : true;
                    boolean p33 = request.getParameter("p33") == null ? false : true;
                    boolean p34 = request.getParameter("p34") == null ? false : true;
                    out.print(objcUsuario.editarVentaPermiso(codUsuario, p18, p23, p31, p33, p34) ? codUsuario : "Error en actualizacion");
                } catch (Exception e) {
                    out.print("Error en parametros");
                }
            }
            if (accion.equals("editarPermisoCobranza")) {
                try {
                    codUsuario = Integer.parseInt(request.getParameter("codUsuario"));
                    if (codUsuario == 1) {
                        out.print("Usuario bloqueado.");
                        return;
                    }
                    boolean p22 = request.getParameter("p22") == null ? false : true;
                    boolean p24 = request.getParameter("p24") == null ? false : true;
                    boolean p35 = request.getParameter("p35") == null ? false : true;
                    boolean p36 = request.getParameter("p36") == null ? false : true;
                    boolean p37 = request.getParameter("p37") == null ? false : true;
                    boolean p49 = request.getParameter("p49") == null ? false : true;
                    out.print(objcUsuario.editarCobranzaPermiso(codUsuario, p22, p24, p35, p36, p37, p49) ? codUsuario : "Error en actualizacion");
                } catch (Exception e) {
                    out.print("Error en parametros");
                }
            }
            if (accion.equals("editarPermisoEmpresaConvenio")) {
                try {
                    codUsuario = Integer.parseInt(request.getParameter("codUsuario"));
                    if (codUsuario == 1) {
                        out.print("Usuario bloqueado.");
                        return;
                    }
                    boolean p12 = request.getParameter("p12") == null ? false : true;
                    boolean p41 = request.getParameter("p41") == null ? false : true;
                    out.print(objcUsuario.editarEmpresaConvenioPermiso(codUsuario, p12, p41) ? codUsuario : "Error en actualizacion");
                } catch (Exception e) {
                    out.print("Error en parámetros");
                }
            }
            if (accion.equals("editarPermisoAlmacen")) {
                try {
                    codUsuario = Integer.parseInt(request.getParameter("codUsuario"));
                    if (codUsuario == 1) {
                        out.print("Usuario bloqueado.");
                        return;
                    }
                    boolean p8 = request.getParameter("p8") == null ? false : true;
                    boolean p38 = request.getParameter("p38") == null ? false : true;
                    out.print(objcUsuario.editarAlmacenPermiso(codUsuario, p8, p38) ? codUsuario : "Error en actualizacion");
                } catch (Exception e) {
                    out.print("Error en parámetros");
                }
            }
            if (accion.equals("editarPermisoArticuloProducto")) {
                try {
                    codUsuario = Integer.parseInt(request.getParameter("codUsuario"));
                    if (codUsuario == 1) {
                        out.print("Usuario bloqueado.");
                        return;
                    }
                    boolean p4 = request.getParameter("p4") == null ? false : true;
                    boolean p6 = request.getParameter("p6") == null ? false : true;
                    boolean p7 = request.getParameter("p7") == null ? false : true;
                    boolean p15 = request.getParameter("p15") == null ? false : true;
                    boolean p21 = request.getParameter("p21") == null ? false : true;
                    boolean p27 = request.getParameter("p27") == null ? false : true;
                    out.print(objcUsuario.editarArticuloProductoPermiso(codUsuario, p4, p6, p7, p15, p21, p27) ? codUsuario : "Error en actualizacion");
                } catch (Exception e) {
                    out.print("Error en parámetros");
                }
            }
            if (accion.equals("editarPermisoGarante")) {
                try {
                    codUsuario = Integer.parseInt(request.getParameter("codUsuario"));
                    if (codUsuario == 1) {
                        out.print("Usuario bloqueado.");
                        return;
                    }
                    boolean p25 = request.getParameter("p25") == null ? false : true;
                    boolean p48 = request.getParameter("p48") == null ? false : true;
                    out.print(objcUsuario.editarGarantePermiso(codUsuario, p25, p48) ? codUsuario : "Error en actualizacion");
                } catch (Exception e) {
                    out.print("Error en parámetros");
                }
            }
            if (accion.equals("editarPermisoMarca")) {
                try {
                    codUsuario = Integer.parseInt(request.getParameter("codUsuario"));
                    if (codUsuario == 1) {
                        out.print("Usuario bloqueado.");
                        return;
                    }
                    boolean p13 = request.getParameter("p13") == null ? false : true;
                    boolean p45 = request.getParameter("p45") == null ? false : true;
                    out.print(objcUsuario.editarMarcaPermiso(codUsuario, p13, p45) ? codUsuario : "Error en actualizacion");
                } catch (Exception e) {
                    out.print("Error en parámetros");
                }
            }
            if (accion.equals("editarPermisoFamilia")) {
                try {
                    codUsuario = Integer.parseInt(request.getParameter("codUsuario"));
                    if (codUsuario == 1) {
                        out.print("Usuario bloqueado.");
                        return;
                    }
                    boolean p14 = request.getParameter("p14") == null ? false : true;
                    boolean p43 = request.getParameter("p43") == null ? false : true;
                    out.print(objcUsuario.editarFamiliaPermiso(codUsuario, p14, p43) ? codUsuario : "Error en actualizacion");
                } catch (Exception e) {
                    out.print("Error en parámetros");
                }
            }
            if (accion.equals("editarPermisoZona")) {
                try {
                    codUsuario = Integer.parseInt(request.getParameter("codUsuario"));
                    if (codUsuario == 1) {
                        out.print("Usuario bloqueado.");
                        return;
                    }
                    boolean p16 = request.getParameter("p16") == null ? false : true;
                    boolean p46 = request.getParameter("p46") == null ? false : true;
                    out.print(objcUsuario.editarZonaPermiso(codUsuario, p16, p46) ? codUsuario : "Error en actualizacion");
                } catch (Exception e) {
                    out.print("Error en parámetros");
                }
            }
            if (accion.equals("editarPermisoCompra")) {
                try {
                    codUsuario = Integer.parseInt(request.getParameter("codUsuario"));
                    if (codUsuario == 1) {
                        out.print("Usuario bloqueado.");
                        return;
                    }
                    boolean p3 = request.getParameter("p3") == null ? false : true;
                    boolean p39 = request.getParameter("p39") == null ? false : true;
                    boolean p40 = request.getParameter("p40") == null ? false : true;
                    out.print(objcUsuario.editarCompraPermiso(codUsuario, p3, p39, p40) ? codUsuario : "Error en actualizacion");
                } catch (Exception e) {
                    out.print("Error en parámetros");
                }
            }
            if (accion.equals("editarPermisoProveedor")) {
                try {
                    codUsuario = Integer.parseInt(request.getParameter("codUsuario"));
                    if (codUsuario == 1) {
                        out.print("Usuario bloqueado.");
                        return;
                    }
                    boolean p5 = request.getParameter("p5") == null ? false : true;
                    boolean p17 = request.getParameter("p17") == null ? false : true;
                    out.print(objcUsuario.editarProveedorPermiso(codUsuario, p5, p17) ? codUsuario : "Error en actualizacion");
                } catch (Exception e) {
                    out.print("Error en parámetros");
                }
            }
            if (accion.equals("editarPermisoPersonal")) {
                try {
                    codUsuario = Integer.parseInt(request.getParameter("codUsuario"));
                    if (codUsuario == 1) {
                        out.print("Usuario bloqueado.");
                        return;
                    }
                    boolean p9 = request.getParameter("p9") == null ? false : true;
                    boolean p30 = request.getParameter("p30") == null ? false : true;
                    out.print(objcUsuario.editarPersonalPermiso(codUsuario, p9, p30) ? codUsuario : "Error en actualizacion");
                } catch (Exception e) {
                    out.print("Error en parámetros");
                }
            }
            if (accion.equals("editarPermisoReporte")) {
                try {
                    codUsuario = Integer.parseInt(request.getParameter("codUsuario"));
                    if (codUsuario == 1) {
                        out.print("Usuario bloqueado.");
                        return;
                    }
                    boolean p19 = request.getParameter("p19") == null ? false : true;
                    out.print(objcUsuario.editarReportePermiso(codUsuario, p19) ? codUsuario : "Error en actualizacion");
                } catch (Exception e) {
                    out.print("Error en parámetros");
                }
            }
            if (accion.equals("editarPermisoPropietario")) {
                try {
                    codUsuario = Integer.parseInt(request.getParameter("codUsuario"));
                    if (codUsuario == 1) {
                        out.print("Usuario bloqueado.");
                        return;
                    }
                    boolean p26 = request.getParameter("p26") == null ? false : true;
                    boolean p47 = request.getParameter("p47") == null ? false : true;
                    out.print(objcUsuario.editarPropietarioPermiso(codUsuario, p26, p47) ? codUsuario : "Error en actualizacion");
                } catch (Exception e) {
                    out.print("Error en parámetros");
                }
            }
            if (accion.equals("editarPermisoUsuario")) {
                try {
                    codUsuario = Integer.parseInt(request.getParameter("codUsuario"));
                    if (codUsuario == 1) {
                        out.print("Usuario bloqueado.");
                        return;
                    }
                    boolean p20 = request.getParameter("p20") == null ? false : true;
                    boolean p44 = request.getParameter("p44") == null ? false : true;
                    out.print(objcUsuario.editarUsuarioPermiso(codUsuario, p20, p44) ? codUsuario : "Error en actualizacion");
                } catch (Exception e) {
                    out.print("Error en parámetros");
                }
            }
            if (accion.equals("editarPermisoCargo")) {
                try {
                    codUsuario = Integer.parseInt(request.getParameter("codUsuario"));
                    if (codUsuario == 1) {
                        out.print("Usuario bloqueado.");
                        return;
                    }
                    boolean p10 = request.getParameter("p10") == null ? false : true;
                    boolean p42 = request.getParameter("p42") == null ? false : true;
                    out.print(objcUsuario.editarCargoPermiso(codUsuario, p10, p42) ? codUsuario : "Error en actualizacion");
                } catch (Exception e) {
                    out.print("Error en parámetros");
                }
            }
            if (accion.equals("editarPermisoArea")) {
                try {
                    codUsuario = Integer.parseInt(request.getParameter("codUsuario"));
                    if (codUsuario == 1) {
                        out.print("Usuario bloqueado.");
                        return;
                    }
                    boolean p11 = request.getParameter("p11") == null ? false : true;
                    boolean p32 = request.getParameter("p32") == null ? false : true;
                    out.print(objcUsuario.editarAreaPermiso(codUsuario, p11, p32) ? codUsuario : "Error en actualizacion");
                } catch (Exception e) {
                    out.print("Error en parámetros");
                }
            }
            //*************************************
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
     * Handles the HTTP
     * <code>GET</code> method.
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
     * Handles the HTTP
     * <code>POST</code> method.
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
