/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package articuloProductoServlets;

import articuloProductoClases.cFamilia;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import otros.cUtilitarios;
import tablas.Familia;
import tablas.Usuario;

/**
 *
 * @author Henrri
 */
@WebServlet(name = "sFamilia", urlPatterns = {"/sFamilia"})
public class sFamilia extends HttpServlet {

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
        String accion = request.getParameter("accion");
        Usuario objUsuario = (Usuario) session.getAttribute("usuario");

        cFamilia objcFamilia = new cFamilia();
        cUtilitarios objcUtilitarios = new cUtilitarios();
        if (accion == null) {
            session.removeAttribute("codFamiliaMantenimiento");
            response.sendRedirect("articuloProducto/familiaMantenimiento.jsp");
        } else {
            if (accion.equals("registrar")) {
                try {
                    Familia objFamilia = new Familia();
                    objFamilia.setFamilia(request.getParameter("familia"));
                    objFamilia.setObservacion(request.getParameter("observacion"));
                    objFamilia.setRegistro(objcUtilitarios.registro("1", objUsuario.getCodUsuario().toString()));
                    int codFamilia = objcFamilia.Crear(objFamilia);
                    if (codFamilia != 0) {
                        out.print(codFamilia);
                    } else {
                        out.print("Error: " + objcFamilia.getError());
                    }
                } catch (Exception e) {
                    out.print("Error en parámetros.");
                }
            }
            if (accion.equals("mantenimiento")) {
                session.removeAttribute("codFamiliaMantenimiento");
                session.setAttribute("codFamiliaMantenimiento", Integer.parseInt(request.getParameter("codFamilia")));
                response.sendRedirect("articuloProducto/familiaMantenimiento.jsp");
            }
            if (accion.equals("editar")) {
                try {
                    Familia objFamilia = new Familia();
                    objFamilia.setCodFamilia(Integer.parseInt(request.getParameter("codFamilia")));
                    objFamilia.setFamilia(request.getParameter("familia"));
                    objFamilia.setObservacion(request.getParameter("observacion"));
                    objFamilia.setRegistro(objcUtilitarios.registro("1", objUsuario.getCodUsuario().toString()));
                    if (objcFamilia.actualizar(objFamilia)) {
                        out.print(objFamilia.getCodFamilia());
                    } else {
                        out.print("Error: " + objcFamilia.getError());
                    }
                } catch (NumberFormatException e) {
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
