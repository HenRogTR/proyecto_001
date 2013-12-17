/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package personaServlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import personaClases.cZona;
import tablas.Usuario;
import tablas.Zona;
import utilitarios.cOtros;

/**
 *
 * @author Henrri
 */
@WebServlet(name = "sZona", urlPatterns = {"/sZona"})
public class sZona extends HttpServlet {

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
        String accion = request.getParameter("accionZona");
        Usuario objUsuario = (Usuario) session.getAttribute("usuario");

        cOtros objcOtros = new cOtros();
        cZona objcZona = new cZona();

        if (accion == null) {
            session.removeAttribute("codZonaMantenimiento");
            response.sendRedirect("persona/zonaMantenimiento.jsp");
        } else {
            if (accion.equals("registrar")) {
                if (!objUsuario.getP46()) {
                    out.print("No tiene permisos para esta acción.");
                    return;
                }
                try {
                    Zona objZona = new Zona();
                    objZona.setZona(request.getParameter("zona").toString());
                    objZona.setDescripcion(request.getParameter("descripcion").toString());
                    objZona.setRegistro(objcOtros.registro("1", objUsuario.getCodUsuario().toString()));
                    int codZona = objcZona.Crear(objZona);
                    out.print(codZona == 0 ? "Error en el registro" : codZona);
                } catch (Exception e) {
                    out.print("Error en parametros.");
                }
            }
            if (accion.equals("mantenimiento")) {
                session.removeAttribute("codZonaMantenimiento");
                session.setAttribute("codZonaMantenimiento", Integer.parseInt(request.getParameter("codZona")));
                response.sendRedirect("persona/zonaMantenimiento.jsp");
            }
            if (accion.equals("editar")) {
                if (!objUsuario.getP46()) {
                    out.print("No tiene permisos para esta acción.");
                    return;
                }
                try {
                    Zona objZona = new Zona();
                    objZona.setCodZona(Integer.parseInt(request.getParameter("codZona")));
                    objZona.setZona(request.getParameter("zona").toString());
                    objZona.setDescripcion(request.getParameter("descripcion").toString());
                    objZona.setRegistro(objcOtros.registro("1", objUsuario.getCodUsuario().toString()));
                    out.print(objcZona.actualizar(objZona) ? objZona.getCodZona() : "Error en el registro");
                } catch (Exception e) {
                    out.print("Error en parametros(editar).");
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
