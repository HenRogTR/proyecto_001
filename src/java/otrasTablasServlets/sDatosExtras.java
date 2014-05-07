/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package otrasTablasServlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import otrasTablasClases.cDatosExtras;
import personaClases.cDatosCliente;
import tablas.DatosExtras;
import tablas.Usuario;

/**
 *
 * @author Henrri
 */
@WebServlet(name = "sDatosExtras", urlPatterns = {"/sDatosExtras"})
public class sDatosExtras extends HttpServlet {

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
        if (objUsuario == null) {
            out.print("Sesión de usuario no iniciada.");
            return;
        }
        String accion = request.getParameter("accion");
        if (accion == null) {
            out.print("Acción no encontrada.");
            return;
        }
        if (accion.equals("interesFactorActualizar")) {
            try {
                Double interesFactor = Double.parseDouble(request.getParameter("interesNuevo"));
                DatosExtras objDatosExtras=new cDatosExtras().leer_interesFactor();
                out.print((new cDatosExtras().actualizar_interesFactor(objDatosExtras.getCodDatosExtras(),interesFactor)) ? interesFactor : "Error en actualización");
            } catch (Exception e) {
                out.print("Error de parámetros (" + e.getMessage() + ")");
            }
            return;
        }
        out.print("La acción (" + accion + ") no ha sido implementada.");
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
