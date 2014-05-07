/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package articuloProductoServlets;

import articuloProductoClases.cKardexSerieNumero;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import tablas.KardexArticuloProducto;
import tablas.KardexSerieNumero;
import tablas.Usuario;
import utilitarios.cOtros;

/**
 *
 * @author Henrri
 */
@WebServlet(name = "sKardexSerieNumero", urlPatterns = {"/sKardexSerieNumero"})
public class sKardexSerieNumero extends HttpServlet {

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
        Usuario objUsuario = (Usuario) session.getAttribute("usuario");

        String accion = request.getParameter("accionKardexSerieNumero") == null ? "" : request.getParameter("accionKardexSerieNumero");
        if (accion.equals("editar")) {
            int codArticuloProducto = Integer.parseInt(request.getParameter("codArticuloProducto"));

            KardexArticuloProducto objKardexArticuloProducto = new KardexArticuloProducto();
            objKardexArticuloProducto.setCodKardexArticuloProducto(Integer.parseInt(request.getParameter("codKardexArticuloProducto")));

            KardexSerieNumero objKardexSerieNumero = new KardexSerieNumero();
            objKardexSerieNumero.setCodKardexSerieNumero(Integer.parseInt(request.getParameter("codKardexSerieNumero")));
            objKardexSerieNumero.setKardexArticuloProducto(objKardexArticuloProducto);
            objKardexSerieNumero.setSerieNumero(request.getParameter("serieNumero"));
            objKardexSerieNumero.setObservacion(request.getParameter("observacion"));
            objKardexSerieNumero.setRegistro(new cOtros().registro("1", objUsuario.getCodUsuario().toString()));

            if (new cKardexSerieNumero().actualizar(objKardexSerieNumero)) {
                response.sendRedirect("articuloProducto/articuloProductoStock.jsp?codArticuloProducto=" + codArticuloProducto);
            } else {
                out.print("error");
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
