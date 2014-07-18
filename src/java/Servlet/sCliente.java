/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import Ejb.EjbCliente;
import Clase.Fecha;
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
import personaClases.cDatosCliente;
import tablas.Usuario;

/**
 *
 * @author Henrri
 */
@WebServlet(name = "sCliente", urlPatterns = {"/sCliente"})
public class sCliente extends HttpServlet {

    @EJB
    private EjbCliente ejbCliente;

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

        if (null == accion) {
            out.print("Acción encontrada");
            return;
        }
        if ("mantenimiento".equals(accion)) {
            int codCliente = 0;
            try {
                codCliente = Integer.parseInt(request.getParameter("codCliente"));
            } catch (Exception e) {
            }
            session.removeAttribute("codClienteMantenimiento");
            session.setAttribute("codClienteMantenimiento", codCliente);
            response.sendRedirect("persona/clienteMantenimiento.jsp");
        }
        if ("editarCobrador".equals(accion)) {
            if (!objUsuario.getP29()) {
                out.print("No tiene permisos para esre acción.");
                return;
            }
            try {
                int codCliente = Integer.parseInt(request.getParameter("codCliente"));
                int codCobrador = Integer.parseInt(request.getParameter("codCobrador"));
                out.print((new cDatosCliente().actualizar_cobrador(codCliente, codCobrador)) ? codCliente : "Error al registrar.");
            } catch (Exception e) {
                out.print("Error en parámetros, contacte al administrador.");
            }
            return;
        }
        if ("actualizarInteresAsignar".equals(accion)) {
            //verificar permisos
            if (!objUsuario.getP51()) {
                out.print("No tiene permisos para esta acción.");
                return;
            }
            //iniciando variables
            int codCliente;
            String estado;
            Date interesEvitar = null;
            boolean interesEvitarPermanente = false;
            try {
                codCliente = Integer.parseInt(request.getParameter("codCliente"));
                estado = request.getParameter("estado").toString();
                //si se habilita estado obtenemos fecha actual
                if ("deshabilitar".equals(estado)) {
                    interesEvitar = new Fecha().fechaHoraAFecha(new Date());
                } else if ("deshabilitarPermanente".equals(estado)) {
                    interesEvitarPermanente = true;
                }
                //si es otro caso solo lo dejamos allí.
            } catch (Exception e) {
                out.print("Error en parámetros.");
                return;
            }
            ejbCliente = new EjbCliente();
            out.print(ejbCliente.actualizarInteresAsignar(codCliente, interesEvitar, interesEvitarPermanente) ? codCliente : ejbCliente.getError());
            return;
        }
        if ("imprimirVenta".equals(accion)) {
            int codCliente = 0;
            try {
                codCliente = Integer.parseInt(request.getParameter("codCliente"));
                //asignar el código a una sessión
                session.setAttribute("reporteVentaCodCliente", codCliente);
                //redireccionamos
                response.sendRedirect("reporte/ventaPorCodCliente.jsp");
            } catch (Exception e) {
                out.print("Código de cliente no encontrado.");
            }
            return;
        }
        out.print("No se encontró operación para: " + accion);
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
