/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package personaServlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import personaClases.cDatosCliente;
import tablas.Usuario;
import utilitarios.cManejoFechas;
import utilitarios.cOtros;

/**
 *
 * @author henrri
 */
@WebServlet(name = "sDatoCliente", urlPatterns = {"/sDatoCliente"})
public class sDatoCliente extends HttpServlet {

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

        //Clases
        Usuario objUsuario = (Usuario) session.getAttribute("usuario");
        cDatosCliente objcDatosCliente = new cDatosCliente();
        //variables
        String accion = request.getParameter("accionDatoCliente");

        if (objUsuario == null) {
            out.print(new cOtros().iniciarSesion());
            return;
        }

        if (accion == null) {
            session.removeAttribute("codDatoClienteMantenimiento");
            response.sendRedirect("persona/clienteMantenimiento.jsp");

        } else {
            //editar el cobrador del cliente
            if (accion.equals("editarCobrador")) {
                if (!objUsuario.getP29()) {
                    out.print("No tiene permisos para esta acción.");
                    return;
                }
                int codCobrador = 0;
                int codDatoCliente = 0;
                try {
                    codDatoCliente = Integer.parseInt(request.getParameter("codDatoCliente"));
                    codCobrador = Integer.parseInt(request.getParameter("codCobrador"));
                } catch (Exception e) {
                    out.print("Error en parámetros, contacte al administrador.<br>");
                    return;
                }
                if (objcDatosCliente.actualizar_cobrador(codDatoCliente, codCobrador)) {
                    out.print(codDatoCliente);
                } else {
                    out.print(objcDatosCliente.getError());
                }
            }
            //listar el cliente            
            if (accion.equals("mantenimiento")) {
                int codPersona = 0;
                try {
                    codPersona = Integer.parseInt(request.getParameter("codDatoCliente"));
                } catch (Exception e) {
                }
                session.removeAttribute("codDatoClienteMantenimiento");
                session.setAttribute("codDatoClienteMantenimiento", codPersona);
                response.sendRedirect("persona/clienteMantenimiento.jsp");
            }
            if (accion.equals("actualizar_interesEvitar")) {
                if (!objUsuario.getP51()) {
                    out.print("No tiene permisos para esta acción.");
                    return;
                }
                int codCliente = 0;
                Date fecha = null;
                try {
                    codCliente = Integer.parseInt(request.getParameter("codCliente"));
                    fecha = new cManejoFechas().StringADate(request.getParameter("fecha"));
                    out.print(new cDatosCliente().actualizar_interesEvitar(codCliente, fecha) ? codCliente : "Error al registrar");
                } catch (Exception e) {
                    out.print("Error en parámetros.");
                }

            }
            if (accion.equals("interesEvitar_habilitar")) {
                if (!objUsuario.getP51()) {
                    out.print("No tiene permisos para esta acción.");
                    return;
                }
                int codCliente = 0;
                Date fecha = null;
                try {
                    codCliente = Integer.parseInt(request.getParameter("codCliente"));
                    out.print(new cDatosCliente().actualizar_interesEvitar(codCliente, fecha) ? codCliente : "Error al registrar");
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
