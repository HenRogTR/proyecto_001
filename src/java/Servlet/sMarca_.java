/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import Ejb.EjbMarca;
import java.io.IOException;
import java.io.PrintWriter;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import tablas.Usuario;
import utilitarios.cOtros;

/**
 *
 * @author Henrri
 */
@WebServlet(name = "sMarca_", urlPatterns = {"/sMarca_"})
public class sMarca_ extends HttpServlet {

    @EJB
    private EjbMarca ejbTMarca;

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

        //prevenir envio por get o acceso directo por el URL
        if (request.getMethod().equals("GET")) {
            response.sendRedirect("articuloProducto/marcaMantenimiento.jsp");
            return;
        }
        //que el usaurio este logueado
        if (objUsuario == null) {
            out.print("No ha iniciado sesión.");
            return;
        }
        //accion a realizar
        if (accion == null) {
            out.print("Acción no definida");
            return;
        }
        if (accion.equals("registrar")) {
            //permiso de registrar
            if (!objUsuario.getP45()) {
                out.print("No tiene permiso para esta operación. ");
                return;
            }
            //inicializa
            ejbTMarca = new EjbMarca();
            //seteamos
            ejbTMarca.getMarca().setDescripcion(request.getParameter("descripcion"));
            ejbTMarca.getMarca().setRegistro(new cOtros().registro("1", objUsuario.getCodUsuario().toString()));
            //respuesta
            out.print(ejbTMarca.crear() ? ejbTMarca.getMarca().getCodMarca() : "Error al registrar: " + ejbTMarca.getError());

        }
        if (accion.equals("editar")) {
            //permiso de registrar
            if (!objUsuario.getP45()) {
                out.print("No tiene permiso para esta operación. ");
                return;
            }

        }

        if (accion.equals("eliminar")) {
            //permiso eliminar
            if (!objUsuario.getP45()) {
                out.print("No tiene permiso para esta operación. ");
                return;
            }

        }

        out.print("no se ha encontrado método para la acción: " + accion);
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
