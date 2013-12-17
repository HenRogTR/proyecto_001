/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package articuloProductoServlets;

import articuloProductoClases.cMarca;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import otros.cUtilitarios;
import tablas.Marca;
import tablas.Usuario;

/**
 *
 * @author Henrri
 */
@WebServlet(name = "sMarca", urlPatterns = {"/sMarca"})
public class sMarca extends HttpServlet {

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
        String accion = request.getParameter("accion");

        int codMarca;
        String descripcion;
        boolean est;
        Date reg;
        int user;


        Usuario objUsuario = (Usuario) session.getAttribute("usuario");

        cMarca objcMarca = new cMarca();
        cUtilitarios objcUtilitarios = new cUtilitarios();

        if (accion != null) {
            if (accion.equals("r")) {
                session.removeAttribute("accionMarca");
                session.setAttribute("accionMarca", "r");
                response.sendRedirect("articuloProducto/marcaFrm.jsp");
            }
        } else {
            accion = (String) session.getAttribute("accionMarca");
            if (accion.equals("r")) {
                Marca objMarca = new Marca();
                objMarca.setDescripcion(request.getParameter("descripcion"));
                objMarca.setRegistro(objcUtilitarios.registro("1", objUsuario.getCodUsuario().toString()));
                if (objcMarca.Crear(objMarca) != 0) {
                    session.removeAttribute("accionMarca");
                    out.print(true);
                } else {
                    out.print(false);
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
