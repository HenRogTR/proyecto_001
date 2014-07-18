/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ventaServlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import tablas.Usuario;
import tablas.VentaCredito;
import tablas.VentaCreditoLetra;
import utilitarios.cManejoFechas;
import utilitarios.cOtros;
import ventaClases.cVentaCredito;
import ventaClases.cVentaCreditoLetra;

/**
 *
 * @author Henrri
 */
@WebServlet(name = "sVentaCredito", urlPatterns = {"/sVentaCredito"})
public class sVentaCredito extends HttpServlet {

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

        String accion = request.getParameter("accionVentaCredito");

        if (accion == null) {
            out.print("Acción no definida");
            return;
        }
        cManejoFechas objcManejoFechas = new cManejoFechas();
        if (accion.equals("editar")) {
            if (!objUsuario.getP33()) {
                out.print("No tiene permiso para esta operación. ");
                return;
            }
            int codVentaCredito = 0;
            int cantidadLetras = 0;
            Date fechaInicioLetras = null;
            Double montoInicialLetra = 0.00;
            Date fechaVencimientoInicial = null;
            String periodoLetra = "";
            try {
                codVentaCredito = Integer.parseInt(request.getParameter("codVentaCredito"));
                cantidadLetras = Integer.parseInt(request.getParameter("cantidadLetras"));
                fechaInicioLetras = objcManejoFechas.StringADate(request.getParameter("fechaInicioLetras"));
                montoInicialLetra = Double.parseDouble(request.getParameter("montoInicialLetra"));
                fechaVencimientoInicial = objcManejoFechas.StringADate(request.getParameter("fechaVencimientoInicial"));
                periodoLetra = request.getParameter("periodoLetra").toString();
            } catch (Exception e) {
                out.print("Error en parámetros.");
                return;
            }
            VentaCredito objVentaCredito = new cVentaCredito().leer_cod(codVentaCredito);
            //primero anular las letras actuales
            for (VentaCreditoLetra objVentaCreditoLetra : objVentaCredito.getVentaCreditoLetras()) {
                new cVentaCreditoLetra().actualizar_registro(objVentaCreditoLetra.getCodVentaCreditoLetra(), "0", objUsuario.getCodUsuario().toString());
            }
            //registrar nuevas letras
            Double neto = objVentaCredito.getVentas().getNeto();
            Double montoLetra = new cOtros().redondearDecimales((neto - montoInicialLetra) / cantidadLetras, 1);
            Double acumulado = 0.0;
            List VCLList = new ArrayList();
            for (int m = 0; m <= cantidadLetras; m++) {
                VentaCreditoLetra objVentaCreditoLetra = new VentaCreditoLetra();
                objVentaCreditoLetra.setTotalPago(0.00);
                objVentaCreditoLetra.setMoneda(objVentaCredito.getVentas().getMoneda().equals("soles") ? 0 : 1);
                objVentaCreditoLetra.setInteres(0.00);
                objVentaCreditoLetra.setInteresPagado(0.00);
                objVentaCreditoLetra.setInteresPendiente(0.00);
                objVentaCreditoLetra.setRegistro(new cOtros().registro("1", objUsuario.getCodUsuario().toString()));
                if (m == 0) {
                    objVentaCreditoLetra.setNumeroLetra(m);
                    objVentaCreditoLetra.setDetalleLetra("Pago inicial");
                    objVentaCreditoLetra.setFechaVencimiento(fechaVencimientoInicial);
                    objVentaCreditoLetra.setMonto(montoInicialLetra);
                } else {
                    objVentaCreditoLetra.setNumeroLetra(m);
                    if (periodoLetra.equals("mensual")) {
                        objVentaCreditoLetra.setDetalleLetra("Letra N° " + m);
                        objVentaCreditoLetra.setFechaVencimiento(new cManejoFechas().StringADate(new cManejoFechas().fechaSumarMes(fechaInicioLetras, m - 1)));
                    }
                    if (periodoLetra.equals("quincenal")) {
                        objVentaCreditoLetra.setDetalleLetra("Letra N° " + m + " (Q)");
                        objVentaCreditoLetra.setFechaVencimiento(new cManejoFechas().StringADate(new cManejoFechas().fechaSumarDias(fechaInicioLetras, (m * 14) - 14)));
                    }
                    if (periodoLetra.equals("semanal")) {
                        objVentaCreditoLetra.setDetalleLetra("Letra N° " + m + " (S)");
                        objVentaCreditoLetra.setFechaVencimiento(new cManejoFechas().StringADate(new cManejoFechas().fechaSumarDias(fechaInicioLetras, (m * 7) - 7)));
                    }
                    if (m == cantidadLetras) {
                        Double ultimaLetra = neto - montoInicialLetra - acumulado;
                        objVentaCreditoLetra.setMonto(ultimaLetra);
                    } else {
                        objVentaCreditoLetra.setMonto(montoLetra);
                    }
                    acumulado += montoLetra;
                }
                VCLList.add(objVentaCreditoLetra);
            }
            for (int i = 0; i < VCLList.size(); i++) {
                VentaCreditoLetra objVentaCreditoLetra = (VentaCreditoLetra) VCLList.get(i);
                objVentaCreditoLetra.setVentaCredito(objVentaCredito);
                int a = new cVentaCreditoLetra().crear(objVentaCreditoLetra);
            }

            //editar obj VentaCredito
            new cVentaCredito().actualizar(codVentaCredito, fechaInicioLetras, montoLetra, periodoLetra, fechaVencimientoInicial, montoInicialLetra, cantidadLetras);
            out.print(codVentaCredito);
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
