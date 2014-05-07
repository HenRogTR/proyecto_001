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
import personaClases.cProveedor;
import tablas.Proveedor;
import tablas.Usuario;
import utilitarios.cOtros;

/**
 *
 * @author Henrri
 */
@WebServlet(name = "sProveedor", urlPatterns = {"/sProveedor"})
public class sProveedor extends HttpServlet {

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
        String accion = request.getParameter("accionProveedor");

        Usuario objUsuario = (Usuario) session.getAttribute("usuario");
        cProveedor objcProveedor = new cProveedor();
        Proveedor objProveedor = new Proveedor();

        Integer codProveedor;
        String ruc;
        String razonSocial;
        String direccion;
        String telefono;
        String email;
        String paginaWeb;
        String observaciones;
        String logo;
        String registro;
        if (accion == null) {
            try {
                codProveedor = Integer.parseInt("codProveedor");
            } catch (Exception e) {
                codProveedor = 0;
            }
            session.removeAttribute("codProveedorListar");
            session.setAttribute("codProveedorListar", codProveedor);
            response.sendRedirect("persona/proveedorListar.jsp");
        } else {
            if (accion.equals("registrar")) {
                ruc = request.getParameter("ruc");
                razonSocial = request.getParameter("razonSocial");
                direccion = request.getParameter("direccion");
                telefono = request.getParameter("telefono1");
                email = request.getParameter("email");
                paginaWeb = request.getParameter("paginaWeb");
                observaciones = request.getParameter("observaciones");
                logo = request.getParameter("logo");
                registro = new cOtros().registro("1", objUsuario.getCodUsuario().toString());

                objProveedor = new Proveedor();
                objProveedor.setRuc(ruc);
                objProveedor.setRazonSocial(razonSocial);
                objProveedor.setDireccion(direccion);
                objProveedor.setTelefono(telefono);
                objProveedor.setEmail(email);
                objProveedor.setPaginaWeb(paginaWeb);
                objProveedor.setObservaciones(observaciones);
                objProveedor.setLogo(logo);
                objProveedor.setRegistro(registro);
                codProveedor = objcProveedor.Crear(objProveedor);
                if (codProveedor != 0) {
                    out.print(codProveedor);
                } else {
                    out.print(objcProveedor.getError());
                }
            }
            //editar proveedor
            if (accion.equals("editarVar")) {
                try {
                    codProveedor = Integer.parseInt(request.getParameter("codProveedor"));
                    session.removeAttribute("codProveedorEditar");
                    session.setAttribute("codProveedorEditar", codProveedor);
                    response.sendRedirect("persona/proveedorEditar.jsp");
                } catch (Exception e) {
                    response.sendRedirect("persona/proveedorListar.jsp");
                    return;
                }
            }
            //editar
            if (accion.equals("editar")) {
                objProveedor.setRuc(request.getParameter("ruc"));
                objProveedor.setRazonSocial(request.getParameter("razonSocial"));
                objProveedor.setDireccion(request.getParameter("direccion"));
                objProveedor.setTelefono(request.getParameter("telefono1"));
                objProveedor.setEmail(request.getParameter("email") != null ? (!request.getParameter("email").equals("") ? request.getParameter("email") : "Sin datos") : "Sin datos");
                objProveedor.setPaginaWeb(request.getParameter("paginaWeb") != null ? (!request.getParameter("paginaWeb").equals("") ? request.getParameter("paginaWeb") : "Sin datos") : "Sin datos");
                objProveedor.setObservaciones(request.getParameter("observvaciones") != null ? request.getParameter("Observaciones") : "Sin datos");
                objProveedor.setLogo(request.getParameter("logo") != null ? request.getParameter("logo") : "");
                objProveedor.setRegistro(new cOtros().registro("1", objUsuario.getCodUsuario().toString()));
                out.print("implementando");
            }
            //eliminar proveedor
            if (accion.equals("eliminar")) {
                try {
                    codProveedor = Integer.parseInt(request.getParameter("codProveedor"));
                } catch (Exception e) {
                    out.print("Error en parámetros");
                    return;
                }
                if (objcProveedor.actualizar_registro(Integer.parseInt(request.getParameter("codProveedor")), "0", objUsuario.getCodUsuario().toString())) {
                    out.print(codProveedor);
                } else {
                    out.print("Error al eliminar");
                }
            }
            if (accion != null) {
                if (accion.equals("a")) {
                    codProveedor = Integer.parseInt(request.getParameter("codProveedor"));
                    session.removeAttribute("accionProveedor");
                    session.setAttribute("accionProveedor", "a");
                    session.removeAttribute("objProveedor");
                    session.setAttribute("objProveedor", objcProveedor.leer_cod(codProveedor));
                    response.sendRedirect("persona/proveedorFrm.jsp");
//                response.sendRedirect("persona/proveedorListar.jsp");
                }
                if (accion.equals("e")) {
                    codProveedor = Integer.parseInt(request.getParameter("codProveedor"));

//                if (codProveedor == 0) {
//                    response.sendRedirect("");
//                }
                    response.sendRedirect("persona/proveedorListar.jsp");
                }
            } else {
                accion = (String) session.getAttribute("accionProveedor");
                if (accion.equals("a")) {
                    objProveedor.setRuc(request.getParameter("ruc"));
                    objProveedor.setRazonSocial(request.getParameter("razonSocial"));
                    objProveedor.setDireccion(request.getParameter("direccion"));
                    objProveedor.setTelefono(request.getParameter("telefono1"));
                    objProveedor.setEmail(request.getParameter("email") != null ? (!request.getParameter("email").equals("") ? request.getParameter("email") : "Sin datos") : "Sin datos");
                    objProveedor.setPaginaWeb(request.getParameter("paginaWeb") != null ? (!request.getParameter("paginaWeb").equals("") ? request.getParameter("paginaWeb") : "Sin datos") : "Sin datos");
                    objProveedor.setObservaciones(request.getParameter("observvaciones") != null ? request.getParameter("Observaciones") : "Sin datos");
                    objProveedor.setLogo(request.getParameter("logo") != null ? request.getParameter("logo") : "Sin datos");
                    objProveedor.setRegistro(new cOtros().registro("1", objUsuario.getCodUsuario().toString()));
                    if (objcProveedor.Crear(objProveedor) != 0) {
                        objcProveedor.actualizar_registro(Integer.parseInt(request.getParameter("codProveedor")), "0", objUsuario.getCodUsuario().toString());
                        session.removeAttribute("accionProveedor");
                        out.print("1");
                    } else {
                        out.print("0");
                    }
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
