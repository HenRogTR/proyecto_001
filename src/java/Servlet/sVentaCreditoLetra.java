/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import Ejb.EjbVentaCreditoLetra;
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
@WebServlet(name = "sVentaCreditoLetra", urlPatterns = {"/sVentaCreditoLetra"})
public class sVentaCreditoLetra extends HttpServlet {

    @EJB
    private EjbVentaCreditoLetra ejbVentaCreditoLetra;

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
        String accion = request.getParameter("accionVentaCreditoLetra");
        if (null == accion) {
            out.print("Acción no encontrada");
            return;
        }
        if ("imprimirVentaCreditoLetra".equals(accion)) {
            //asignar el código a una sessión
            try {
                session.removeAttribute("reporteVentaCreditoLetraCodCliente");
                session.setAttribute("reporteVentaCreditoLetraCodCliente", request.getParameter("codCliente").toString());
                String tipo = request.getParameter("tipo").toString();
                session.removeAttribute("reporteVentaCreditoLetraCodVenta");
                session.setAttribute("reporteVentaCreditoLetraCodVenta", "ventaActual".equals(tipo) ? request.getParameter("codVenta") : null);
            } catch (Exception e) {
                out.print("Error en parámetros.");
                return;
            }
            //redireccionamos
            response.sendRedirect("reporte/ventaCreditoLetraPorCodClienteYCodVenta.jsp");
            return;
        }
        //si en caso no se ejecuta la acción.
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
