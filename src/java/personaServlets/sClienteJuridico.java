/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package personaServlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import otrasTablasClases.cDatosExtras;
import personaClases.cDatosCliente;
import personaClases.cPersona;
import tablas.DatosCliente;
import tablas.DatosExtras;
import tablas.EmpresaConvenio;
import tablas.Persona;
import tablas.Usuario;
import tablas.Zona;
import utilitarios.cOtros;

/**
 *
 * @author Henrri
 */
@WebServlet(name = "sClienteJuridico", urlPatterns = {"/sClienteJuridico"})
public class sClienteJuridico extends HttpServlet {

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
        // ============================ sesión =================================
        //verficar inicio de sesión        
        Usuario objUsuario = (Usuario) session.getAttribute("usuario");
        if (objUsuario == null) {
            out.print("La sesión se ha cerrado.");
            return;
        }
        //actualizamos ultimo ingreso
        session.setAttribute("fechaAcceso", new Date());
        // ============================ sesión =================================
        String accion = request.getParameter("accionDatoCliente");

        utilitarios.cManejoFechas objcManejoFechas = new utilitarios.cManejoFechas();
        cPersona objcPersona = new cPersona();
        cDatosCliente objcDatosCliente = new cDatosCliente();
        cOtros objcOtros = new cOtros();

        int codDatoCliente = 0;

        if (accion == null) {
            session.removeAttribute("codDatoClienteMantenimiento");
            response.sendRedirect("persona/clienteMantenimiento.jsp");
        } else {
            if (accion.equals("registrar")) {
                if (!objUsuario.getP29()) {
                    out.print("No tiene permisos para esre acción.");
                    return;
                }
                try {
                    DatosExtras objDatosExtras = new cDatosExtras().cobradorDefecto();
                    if (objDatosExtras == null) {
                        out.print("No se ha definido el cobrador por defecto, informe al administardor del sistema. -> NULL");
                        return;
                    }
                    if (objDatosExtras.getEntero() == 0) {
                        out.print("No se ha definido el cobrador por defecto, informe al administardor del sistema. 0");
                        return;
                    }
                    //datos t_persona
                    Persona objPersona = new Persona();
                    objPersona.setNombres(request.getParameter("nombres").toString());
                    objPersona.setNombresC(request.getParameter("nombres").toString());
                    objPersona.setDireccion(request.getParameter("direccion").toString());
                    objPersona.setDniPasaporte("");
                    objPersona.setTelefono1(request.getParameter("telefono1P").toString());
                    objPersona.setTelefono2(request.getParameter("telefono2P").toString());
                    objPersona.setRuc(request.getParameter("ruc").toString());
                    objPersona.setEmail(request.getParameter("email").toString());
                    objPersona.setFoto(request.getParameter("foto"));
                    objPersona.setEstado(true);
                    objPersona.setFechaNacimiento(objcManejoFechas.StringADate(request.getParameter("fechaNacimiento")));
                    objPersona.setObservaciones("");
                    objPersona.setRegistro(objcOtros.registro("1", objUsuario.getCodUsuario().toString()));
                    Zona objZona = new Zona();
                    objZona.setCodZona(Integer.parseInt(request.getParameter("codZona")));
                    objPersona.setZona(objZona);

                    //datos cliente
                    DatosCliente objCliente = new DatosCliente();
                    objCliente.setTipoCliente(2);
                    EmpresaConvenio objEmpresaConvenio = new EmpresaConvenio();
                    objEmpresaConvenio.setCodEmpresaConvenio(1);
                    objCliente.setEmpresaConvenio(objEmpresaConvenio);
                    objCliente.setCodCobrador(objDatosExtras.getEntero());
                    objCliente.setCentroTrabajo("");
                    objCliente.setTipo(4);
                    objCliente.setCondicion(3);
                    objCliente.setCreditoMax(Double.parseDouble(request.getParameter("saldoMax")));
                    objCliente.setSaldoFavor(0.00);
                    objCliente.setInteresEvitarPermanente(false);
                    objCliente.setObservaciones(request.getParameter("observacionCliente").toString());
                    objCliente.setTelefono("");
                    objCliente.setRegistro(objcOtros.registro("1", objUsuario.getCodUsuario().toString()));

                    try {//para ver si solo se actualizara
                        objPersona.setCodPersona(Integer.parseInt(request.getParameter("codPersona")));
                        objcPersona.actualizarObjeto(objPersona);
                    } catch (Exception e) {
                        objPersona.setCodPersona(objcPersona.crear(objPersona));
                    }
                    objCliente.setPersona(objPersona);
                    codDatoCliente = objcDatosCliente.Crear(objCliente);
                    out.print(codDatoCliente);
                } catch (Exception e) {
                    out.print("Error en parámetros");
                }
            }
            if (accion.equals("editar")) {
                if (!objUsuario.getP29()) {
                    out.print("No tiene permisos para esre acción.");
                    return;
                }
                try {
                    //datos t_persona
                    Persona objPersona = new Persona();
                    objPersona.setCodPersona(Integer.parseInt(request.getParameter("codPersona")));
                    objPersona.setNombres(request.getParameter("nombres").toString());
                    objPersona.setNombresC(request.getParameter("nombres").toString());
                    objPersona.setDireccion(request.getParameter("direccion").toString());
                    objPersona.setDniPasaporte("");
                    objPersona.setTelefono1(request.getParameter("telefono1P").toString());
                    objPersona.setTelefono2(request.getParameter("telefono2P").toString());
                    objPersona.setRuc(request.getParameter("ruc").toString());
                    objPersona.setEmail(request.getParameter("email").toString());
                    objPersona.setFoto(request.getParameter("foto"));
                    objPersona.setEstado(true);
                    objPersona.setFechaNacimiento(objcManejoFechas.StringADate(request.getParameter("fechaNacimiento")));
                    objPersona.setObservaciones(request.getParameter("observacionPersona"));
                    objPersona.setRegistro(objcOtros.registro("1", objUsuario.getCodUsuario().toString()));
                    Zona objZona = new Zona();
                    objZona.setCodZona(Integer.parseInt(request.getParameter("codZona")));
                    objPersona.setZona(objZona);

//                    datos cliente
                    DatosCliente objCliente = new DatosCliente();
                    objCliente.setCodDatosCliente(Integer.parseInt(request.getParameter("codDatoCliente")));
                    objCliente.setTipoCliente(2);
                    EmpresaConvenio objEmpresaConvenio = new EmpresaConvenio();
                    objEmpresaConvenio.setCodEmpresaConvenio(1);
                    objCliente.setEmpresaConvenio(objEmpresaConvenio);
                    objCliente.setCodCobrador(new cDatosCliente().leer_cod(objCliente.getCodDatosCliente()).getCodCobrador());
                    objCliente.setCentroTrabajo("");
                    objCliente.setTipo(4);
                    objCliente.setCondicion(3);
                    objCliente.setCreditoMax(Double.parseDouble(request.getParameter("saldoMax")));
                    objCliente.setSaldoFavor(Double.parseDouble(request.getParameter("saldoFavor")));
                    objCliente.setInteresEvitarPermanente(false);
                    objCliente.setObservaciones("");
                    objCliente.setTelefono("");
                    objCliente.setRegistro(objcOtros.registro("1", objUsuario.getCodUsuario().toString()));
                    objCliente.setPersona(objPersona);

                    objcPersona.actualizarObjeto(objPersona);
                    objcDatosCliente.actualizar(objCliente);

                    out.print(objCliente.getCodDatosCliente());

                } catch (Exception e) {
                    out.print("Error en parámetros");
                }
            }
        }

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
