/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ventaServlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import tablas.Usuario;
import utilitarios.cManejoFechas;
import utilitarios.cValidacion;
import ventaClases.cVentaCreditoLetra;

/**
 *
 * @author Henrri
 */
@WebServlet(name = "sVentaCreditoLetra", urlPatterns = {"/sVentaCreditoLetra"})
public class sVentaCreditoLetra extends HttpServlet {

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

        if (accion.equals("interesActualizar")) {
            String fechaString = "";
            Date fechaDate = null;
            int esperaDia = 0;
            try {
                fechaString = request.getParameter("fecha");
                esperaDia = Integer.parseInt(request.getParameter("esperaDia"));
                if (!new cValidacion().validarFecha(fechaString)) {
                    out.print("Fecha y/o formato de fecha incorrecta.");
                    return;
                }
                fechaDate = new cManejoFechas().StringADate(fechaString);
                fechaDate = new cManejoFechas().StringADate(new cManejoFechas().fechaSumarDias(fechaDate, -esperaDia));

                //actualizar todos los intereses a cero
                if (!new cVentaCreditoLetra().actualizar_interesCero(new cVentaCreditoLetra().leer_letraConDeuda())) {
                    out.print("Error en actualizacion.");
                    return;
                }
                //listar los que se venceran
                List VCLetraList = new cVentaCreditoLetra().letrasVencidas_todos_empresaAfectada_ordenNombresC_SC(fechaDate, true);

                out.print(new cVentaCreditoLetra().actualizar_interes(VCLetraList, fechaDate) ? "1" : "Error al actualizar");
            } catch (Exception e) {
                out.println("Error en parámetros.");
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
