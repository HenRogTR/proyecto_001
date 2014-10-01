/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package personaServlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import otrasTablasClases.cComprobantePago;
import personaClases.cEmpresaConvenio;
import tablas.ComprobantePago;
import tablas.EmpresaConvenio;
import tablas.Usuario;
import utilitarios.cOtros;

/**
 *
 * @author Henrri
 */
@WebServlet(name = "sEmpresaConvenio", urlPatterns = {"/sEmpresaConvenio"})
public class sEmpresaConvenio extends HttpServlet {

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
        String accion = request.getParameter("accion");

        cEmpresaConvenio objcEmpresaConvenio = new cEmpresaConvenio();
        cOtros objcOtros = new cOtros();
        cComprobantePago objcComprobantePago = new cComprobantePago();

        if (accion == null) {
            session.removeAttribute("codEmpresaConvenioMantenimiento");
            response.sendRedirect("persona/empresaConvenioMantenimiento.jsp");
        } else {
            if (accion.equals("registrar")) {
                try {
                    EmpresaConvenio objEmpresaConvenio = new EmpresaConvenio();
                    objEmpresaConvenio.setNombre(request.getParameter("nombre").trim());
                    objEmpresaConvenio.setAbreviatura(request.getParameter("abreviatura").equals("") ? "" : request.getParameter("abreviatura").trim().toUpperCase());
                    String codCobranza = request.getParameter("codCobranza");
                    objEmpresaConvenio.setCodCobranza(objcEmpresaConvenio.generarCodCobranza(codCobranza));
                    objEmpresaConvenio.setRegistro(objcOtros.registro("1", objUsuario.getCodUsuario().toString()));
                    int codEmpresaConvenio = objcEmpresaConvenio.Crear(objEmpresaConvenio);
                    if (codEmpresaConvenio != 0) {
                        List comprobantePagoNuevoList = new ArrayList();
                        for (int i = 1; i <= 12; i++) {
                            ComprobantePago objComprobantePago = new ComprobantePago();
                            objComprobantePago.setTipo(objEmpresaConvenio.getCodCobranza());
                            objComprobantePago.setSerie(i < 10 ? ("00" + i) : (i < 100 ? "0" + i : String.valueOf(i)));
                            objComprobantePago.setRegistro(objcOtros.registro("1", objUsuario.getCodUsuario().toString()));
                            comprobantePagoNuevoList.add(objComprobantePago);
                        }
                        Boolean estado = objcComprobantePago.generarSerieDocumento(comprobantePagoNuevoList);
                        if (estado) {
                            out.print(codEmpresaConvenio);
                        } else {
                            out.print("Error en registro");
                        }
                    } else {
                        out.print("Error en registro: " + objcEmpresaConvenio.getError());
                    }
                } catch (Exception e) {
                    out.print("Error en parametros");
                }
            }//fin registrar
            if (accion.equals("mantenimiento")) {
                session.removeAttribute("codEmpresaConvenioMantenimiento");
                try {
                    session.setAttribute("codEmpresaConvenioMantenimiento", Integer.parseInt(request.getParameter("codEmpresaConvenio")));
                } catch (Exception e) {
                }
                response.sendRedirect("persona/empresaConvenioMantenimiento.jsp");
            }
            if (accion.equals("editar")) {
                try {
                    int codEmpresaConvenio = Integer.parseInt(request.getParameter("codEmpresaConvenio"));
                    EmpresaConvenio objEmpresaConvenio = objcEmpresaConvenio.leer_cod(codEmpresaConvenio);
                    EmpresaConvenio objECNuevo = new EmpresaConvenio();
                    objECNuevo.setCodEmpresaConvenio(objEmpresaConvenio.getCodEmpresaConvenio());
                    objECNuevo.setNombre(request.getParameter("nombre").trim());
                    objECNuevo.setAbreviatura(request.getParameter("abreviatura").equals("") ? "" : request.getParameter("abreviatura").trim().toUpperCase());
                    objECNuevo.setCodCobranza(objEmpresaConvenio.getCodCobranza());
                    objECNuevo.setRegistro(objcOtros.registro("1", objUsuario.getCodUsuario().toString()));
                    if (objcEmpresaConvenio.actualizar(objECNuevo)) {
                        out.print(objECNuevo.getCodEmpresaConvenio());
                    } else {
                        out.print("Error en registro: " + objcEmpresaConvenio.getError());
                    }
                } catch (Exception e) {
                    out.print("Error en parametros");
                }
            }
            if (accion.equals("interesAsigando")) {
                try {
                    int codEmpresaConvenio = Integer.parseInt(request.getParameter("codEmpresaConvenio"));
                    boolean interesAsigando = Boolean.parseBoolean(request.getParameter("interesAsigando"));
                    out.print((new cEmpresaConvenio().actualizar_interesAsigando(codEmpresaConvenio, interesAsigando)) ? codEmpresaConvenio : "Error al actualziar.");
                } catch (Exception e) {
                    out.print("Error en parámetros.");
                }
            }
            if (accion.equals("interesAutomatico")) {
                try {
                    int codEmpresaConvenio = Integer.parseInt(request.getParameter("codEmpresaConvenio"));
                    boolean interesAutomatico = Boolean.parseBoolean(request.getParameter("interesAutomatico"));
                    out.print((new cEmpresaConvenio().actualizar_interesAutomatico(codEmpresaConvenio, interesAutomatico)) ? codEmpresaConvenio : "Error al actualziar.");
                } catch (Exception e) {
                    out.print("Error en parámetros.");
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
