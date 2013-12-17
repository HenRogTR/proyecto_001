/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package otrasTablasServlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
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
@WebServlet(name = "sComprobantePago", urlPatterns = {"/sComprobantePago"})
public class sComprobantePago extends HttpServlet {

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
        String accion = request.getParameter("accionComprobantePago");
        Usuario objUsuario = (Usuario) session.getAttribute("usuario");

        cComprobantePago objcComprobantePago = new cComprobantePago();
        cOtros objcOtros = new cOtros();

        if (accion == null) {
        } else {
            if (accion.equals("generarPrimeraVez")) {
                int codEmpresaConvenioI = 0;
                try {
                    codEmpresaConvenioI = Integer.parseInt(request.getParameter("codEmpresaConvenio"));
                    EmpresaConvenio objEmpresaConvenio = new cEmpresaConvenio().leer_cod(codEmpresaConvenioI);
                    if (objEmpresaConvenio == null) {
                        out.print("Empresa no encontrada");
                        return;
                    }
                    List lComprobar = objcComprobantePago.leer_serieGenerada(objEmpresaConvenio.getCodCobranza());
                    if (lComprobar.size() > 0) {
                        out.print("Ya se ha generado, actualize su página");
                        return;
                    }
                    List comprobantePagoNuevoList = new ArrayList();
                    for (int i = 1; i <= 12; i++) {
                        ComprobantePago objComprobantePago = new ComprobantePago();
                        objComprobantePago.setTipo(objEmpresaConvenio.getCodCobranza());
                        objComprobantePago.setSerie(i < 10 ? ("00" + i) : (i < 100 ? "0" + i : String.valueOf(i)));
                        objComprobantePago.setRegistro(objcOtros.registro("1", objUsuario.getCodUsuario().toString()));
                        comprobantePagoNuevoList.add(objComprobantePago);
                    }
                    if (objcComprobantePago.generarSerieDocumento(comprobantePagoNuevoList)) {
                        session.removeAttribute("codEmpresaConvenioMantenimiento");
                        session.setAttribute("codEmpresaConvenioMantenimiento", objEmpresaConvenio.getCodEmpresaConvenio());
                        response.sendRedirect("persona/empresaConvenioMantenimiento.jsp");
                    } else {
                        out.print("Error en generación.");
                    }
                } catch (Exception e) {
                    out.print("Error en parametros");
                }
            }
        }
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
