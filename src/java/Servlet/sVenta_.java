/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import Clase.Fecha;
import Ejb.EjbVenta;
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
@WebServlet(name = "sVenta_", urlPatterns = {"/sVenta_"})
public class sVenta_ extends HttpServlet {

    @EJB
    private EjbVenta ejbVenta;

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
        String accion = request.getParameter("accionVenta");
        if (null == accion) {
            out.print("Acción encontrada");
            return;
        }
        //Modificar letras de pago
        if ("editarCuotaPago".equals(accion)) {
            //Recuperar los parámetros
            ejbVenta = new EjbVenta();//Inicializamos el cliente
            try {
                ejbVenta.setVenta(ejbVenta.leerPorCodigo(Integer.parseInt(request.getParameter("codVenta")), true));
                ejbVenta.getVenta().setCantidadLetras(Integer.parseInt(request.getParameter("cantidadLetras")));
                ejbVenta.getVenta().setFechaVencimientoLetraDeuda(new Fecha().stringADate(request.getParameter("fechaInicioLetras").toString()));
                ejbVenta.getVenta().setMontoInicial(Double.parseDouble(request.getParameter("montoInicialLetra")));
                ejbVenta.getVenta().setFechaInicialVencimiento(new Fecha().stringADate(request.getParameter("fechaVencimientoInicial").toString()));
                ejbVenta.getVenta().setDuracion(request.getParameter("periodoLetra").toString());
                ejbVenta.setCodUsuarioSession(objUsuario.getCodUsuario());
            } catch (Exception e) {
                out.print("Error en parámetros.");
                return;
            }
            out.print(ejbVenta.modificarVentaCreditoLetra() ? ejbVenta.getVenta().getCodVentas() : ejbVenta.getError());
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
