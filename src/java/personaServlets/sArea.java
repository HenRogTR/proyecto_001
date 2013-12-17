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
import otros.cUtilitarios;
import personaClases.cArea;
import tablas.Area;
import tablas.Usuario;

/**
 *
 * @author Henrri
 */
@WebServlet(name = "sArea", urlPatterns = {"/sArea"})
public class sArea extends HttpServlet {

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
        String accion = request.getParameter("accionArea");

//        Area objArea=new Area();
        Usuario objUsuario = (Usuario) session.getAttribute("usuario");

        cArea objcArea = new cArea();
        cUtilitarios objcUtilitarios = new cUtilitarios();


        int codArea;
        String area;
        String detalle;
        String registro;
        if (accion != null) {
            if (accion.equals("r")) {
                session.removeAttribute("accionArea");
                session.setAttribute("accionArea", "r");
                response.sendRedirect("persona/areaFrm.jsp");
            }
            if (accion.equals("a")) {
                codArea = Integer.parseInt(request.getParameter("codArea"));
                session.removeAttribute("accionArea");
                session.setAttribute("accionArea", "a");
                session.removeAttribute("codArea");
                session.setAttribute("codArea", codArea);
                response.sendRedirect("persona/areaFrm.jsp");
            }
            if (accion.equals("e")) {
                codArea = Integer.parseInt(request.getParameter("codArea"));
                if (objcArea.actualizar_registro(codArea, "0", objUsuario.getCodUsuario().toString())) {
                    response.sendRedirect("persona/areaListar.jsp");
                }
            }
        } else {
            accion = (String) session.getAttribute("accionArea");
            if (accion.equals("r")) {
                Area objArea = new Area();
                objArea.setArea(request.getParameter("area"));
                objArea.setDetalle(request.getParameter("detalle").equals("") ? "sd" : request.getParameter("detalle"));
                objArea.setRegistro(objcUtilitarios.registro("1", objUsuario.getCodUsuario().toString()));
                if (objcArea.Crear(objArea) != 0) {
                    out.print("1");
                } else {
                    out.print("0");
                }
            }
            if (accion.equals("a")) {
                Area objArea = new Area();
                codArea = Integer.parseInt(request.getParameter("codArea"));
                area = request.getParameter("area");
                detalle = request.getParameter("detalle");
                objArea = new Area(area, detalle, objcUtilitarios.registro("1", objUsuario.getCodUsuario().toString()));
                objArea.setCodArea(codArea);
                if (objcArea.actualizar(objArea)) {
                    session.removeAttribute("codArea");
                    session.removeAttribute("accionArea");
                    response.sendRedirect("persona/areaListar.jsp");
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
