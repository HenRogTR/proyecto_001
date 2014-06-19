/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package articuloProductoServlets;

import articuloProductoClases.cArticuloProducto;
import articuloProductoClases.cPrecioVenta;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import tablas.ArticuloProducto;
import tablas.Familia;
import tablas.Marca;
import tablas.PrecioVenta;
import tablas.Usuario;
import utilitarios.cOtros;

/**
 *
 * @author Henrri
 */
@WebServlet(name = "sArticuloProducto", urlPatterns = {"/sArticuloProducto"})
public class sArticuloProducto extends HttpServlet {

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

        String accion = request.getParameter("accionArticuloProducto");
        Usuario objUsuario = (Usuario) session.getAttribute("usuario");
        if (objUsuario == null) {
            out.print("Estimado usuario, es necesario que se loguee.<a href=\"#\" id=\"aIniciarSesion\"> Clic aqui.</a>");
            return;
        }
        cOtros objcOtros = new cOtros();
        cArticuloProducto objcArticuloProducto = new cArticuloProducto();
        cPrecioVenta objcPrecioVenta = new cPrecioVenta();
        int codArticuloProducto = 0;
        if (accion == null) {
            session.removeAttribute("codArticuloProductoMantenimiento");
            response.sendRedirect("articuloProducto/articuloProductoMantenimiento.jsp");
        } else {
            if (accion.equals("mantenimiento")) {
                session.removeAttribute("codArticuloProductoMantenimiento");
                try {
                    codArticuloProducto = Integer.parseInt(request.getParameter("codArticuloProducto"));
                    session.setAttribute("codArticuloProductoMantenimiento", codArticuloProducto);
                } catch (Exception e) {
                }
                response.sendRedirect("articuloProducto/articuloProductoMantenimiento.jsp");
            }
            if (accion.equals("registrar")) {
                ArticuloProducto objArticuloProducto = new ArticuloProducto();
                objArticuloProducto.setCodReferencia(request.getParameter("codReferencia"));
                objArticuloProducto.setDescripcion(request.getParameter("descripcion"));    //  2
                objArticuloProducto.setPrecioVenta(0.00);
                objArticuloProducto.setPrecioCash(0.00);
                Familia objFamilia = new Familia();
                objFamilia.setCodFamilia(Integer.parseInt(request.getParameter("codFamilia")));
                objArticuloProducto.setFamilia(objFamilia); //  3
                Marca objMarca = new Marca();
                objMarca.setCodMarca(Integer.parseInt(request.getParameter("codMarca")));
                objArticuloProducto.setMarca(objMarca); //4
                objArticuloProducto.setUnidadMedida(request.getParameter("unidadMedida") == null ? "Unidad" : (request.getParameter("unidadMedida").equals("") ? "Unidad" : request.getParameter("unidadMedida")));
                objArticuloProducto.setUsarSerieNumero(request.getParameter("usarSerieNumero").equals("1") ? true : false);
                objArticuloProducto.setReintegroTributario(request.getParameter("reintegroTributario").equals("1") ? true : false);  //6
                objArticuloProducto.setObservaciones(request.getParameter("observacion"));    //7
                objArticuloProducto.setFoto(request.getParameter("foto"));  //8
                objArticuloProducto.setRegistro(objcOtros.registro("1", objUsuario.getCodUsuario().toString()));  //9
                codArticuloProducto = objcArticuloProducto.Crear(objArticuloProducto);
                if (codArticuloProducto != 0) {
                    out.print(codArticuloProducto);
                } else {
                    out.print("Error al registrar.");
                }
            }
            //**********Editar un artículo producto**********
            if (accion.equals("editar")) {//comprobar que el usuario tiene permiso para editar
                if (!objUsuario.getP28()) {
                    out.print("No tiene permisos para realizar esta acción.");
                    return;
                }
                //verificar que los parametros sean los correctos.
//                int codArticuloProducto;
                ArticuloProducto objArticuloProducto;
                try {
                    codArticuloProducto = Integer.parseInt(request.getParameter("codArticuloProducto"));
                    objArticuloProducto = objcArticuloProducto.leer_cod(codArticuloProducto);
                    if (objArticuloProducto == null) {
                        out.print("Artículo no identificado");
                        return;
                    }
                } catch (Exception e) {
                    out.print("Error en parámetros: " + e.getMessage());
                    return;
                }
                //recogemos todos los datos
                ArticuloProducto objArticuloProductoNuevo = new ArticuloProducto();
                objArticuloProductoNuevo.setCodArticuloProducto(codArticuloProducto);
                objArticuloProductoNuevo.setCodReferencia(request.getParameter("codReferencia"));
                objArticuloProductoNuevo.setDescripcion(request.getParameter("descripcion"));    //  2
                objArticuloProductoNuevo.setPrecioVenta(objArticuloProducto.getPrecioVenta());
                Familia objFamilia = new Familia();
                objFamilia.setCodFamilia(Integer.parseInt(request.getParameter("codFamilia")));
                objArticuloProductoNuevo.setFamilia(objFamilia); //  3
                Marca objMarca = new Marca();
                objMarca.setCodMarca(Integer.parseInt(request.getParameter("codMarca")));
                objArticuloProductoNuevo.setMarca(objMarca); //4
                objArticuloProductoNuevo.setUnidadMedida(request.getParameter("unidadMedida") == null ? "Unidad" : (request.getParameter("unidadMedida").equals("") ? "Unidad" : request.getParameter("unidadMedida")));
                objArticuloProductoNuevo.setUsarSerieNumero(request.getParameter("usarSerieNumero").equals("1") ? true : false);
                objArticuloProductoNuevo.setReintegroTributario(request.getParameter("reintegroTributario").equals("1") ? true : false);  //6
                objArticuloProductoNuevo.setObservaciones(request.getParameter("observaciones"));    //7
                objArticuloProductoNuevo.setFoto(request.getParameter("foto"));  //8
                objArticuloProductoNuevo.setRegistro(objcOtros.registro("1", objUsuario.getCodUsuario().toString()));  //9

                //verificar que no haya el mismo artículo dos veces.
                Iterator iArticuloProducto = objcArticuloProducto.leer_descripcion(objArticuloProductoNuevo.getDescripcion()).iterator();
                while (iArticuloProducto.hasNext()) {
                    ArticuloProducto objArticuloProductoRegistrados = (ArticuloProducto) iArticuloProducto.next();
                    if (objArticuloProductoNuevo.getDescripcion().equals(objArticuloProductoRegistrados.getDescripcion()) & !objArticuloProductoNuevo.getCodArticuloProducto().equals(objArticuloProductoRegistrados.getCodArticuloProducto())) {
                        out.print("El artículo <b>" + objArticuloProductoNuevo.getDescripcion() + "</b> ya se encuenta registrado.<br>");
                        return;
                    }
                }
                if (!objcArticuloProducto.actualizar(objArticuloProductoNuevo)) {
                    out.print("Error al actualizar: " + objcArticuloProducto.getError() + "<br>");
                }
                out.print(objArticuloProductoNuevo.getCodArticuloProducto());
            }
            if (accion.equals("editarPrecioVenta")) {
                if (!objUsuario.getP27()) {
                    out.print("No tiene permisos para realizar esta acción.");
                    return;
                }
                double precioVenta = 0;
                try {
                    codArticuloProducto = Integer.parseInt(request.getParameter("codArticuloProducto"));
                    precioVenta = Double.parseDouble(request.getParameter("precioVenta"));
                } catch (Exception e) {
                    out.print("Error en parametros");
                    return;
                }
                objcArticuloProducto.actualizar_precio_venta(codArticuloProducto, precioVenta, 1);

                PrecioVenta objPrecioVenta = new PrecioVenta();
                objPrecioVenta.setCodCompraDetalle(0);
                objPrecioVenta.setPrecioVenta(precioVenta);
                objPrecioVenta.setObservacion("Actualización Manual(" + objcOtros.agregarCerosNumeroFormato(objcOtros.redondearDecimales(precioVenta, 2), 2) + ")");
                objPrecioVenta.setArticuloProducto(objcArticuloProducto.leer_cod(codArticuloProducto));
                objPrecioVenta.setRegistro(objcOtros.registro("1", objUsuario.getCodUsuario().toString()));
                objcPrecioVenta.crear(objPrecioVenta);
                out.print(codArticuloProducto);
            }

            if (accion.equals("editarPrecioCash")) {
                if (!objUsuario.getP52()) {
                    out.print("No tiene permisos para realizar esta acción.");
                    return;
                }
                double precioVenta = 0;
                try {
                    codArticuloProducto = Integer.parseInt(request.getParameter("codArticuloProducto"));
                    precioVenta = Double.parseDouble(request.getParameter("precioCash"));
                } catch (Exception e) {
                    out.print("Error en parametros");
                    return;
                }
                out.print(objcArticuloProducto.actualizar_precioCash(codArticuloProducto, precioVenta) ? codArticuloProducto : "Error al registrar.");
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
