/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package otrasTablasServlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import otrasTablasClases.cComprobantePagoDetalle;
import tablas.ComprobantePago;
import tablas.ComprobantePagoDetalle;
import tablas.Usuario;
import utilitarios.cOtros;

/**
 *
 * @author Henrri
 */
@WebServlet(name = "sComprobantePagoDetalle", urlPatterns = {"/sComprobantePagoDetalle"})
public class sComprobantePagoDetalle extends HttpServlet {

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
        String accion = request.getParameter("accion");
        Usuario objUsuario = (Usuario) session.getAttribute("usuario");

        cOtros objcOtros = new cOtros();
        cComprobantePagoDetalle objcComprobantePagoDetalle = new cComprobantePagoDetalle();

        if (accion == null) {
            out.print("Error en parametros");
        } else {
            if (accion.equals("generar")) {
                try {
                    int codComprobantePago = Integer.parseInt(request.getParameter("codComprobantePago"));
                    String tipo = request.getParameter("tipo").toString();
                    String serie = request.getParameter("serie").toString();
                    int numeroSig = Integer.parseInt(request.getParameter("numero"));
                    int numeroGenerar = Integer.parseInt(request.getParameter("numeroGenerar"));
                    ComprobantePagoDetalle objcCPDUltimo = objcComprobantePagoDetalle.leer_ultimo(codComprobantePago);
                    if (objcCPDUltimo != null) {
                        if (Integer.parseInt(objcCPDUltimo.getNumero()) + 1 != numeroSig) {
                            out.print("Rango de incio incorrecto. Verifique los parametros para generar nuevos documentos");
                            return;
                        }
                    }
                    List lCPDList = new ArrayList();
                    for (int i = numeroSig; i <= numeroGenerar; i++) {
                        ComprobantePagoDetalle objComprobantePagoDetalle = new ComprobantePagoDetalle();
                        ComprobantePago objComprobantePago = new ComprobantePago();
                        objComprobantePago.setCodComprobantePago(codComprobantePago);
                        objComprobantePagoDetalle.setComprobantePago(objComprobantePago);
                        objComprobantePagoDetalle.setDocSerieNumero(tipo + "-" + serie + "-" + objcOtros.agregarCeros_int(i, 6));
                        objComprobantePagoDetalle.setNumero(objcOtros.agregarCeros_int(i, 6));
                        objComprobantePagoDetalle.setEstado(false);
                        objComprobantePagoDetalle.setRegistro(objcOtros.registro("1", objUsuario.getCodUsuario().toString()));
                        lCPDList.add(objComprobantePagoDetalle);
                    }
                    if (objcComprobantePagoDetalle.generar(lCPDList)) {
                        out.print(codComprobantePago);
                    } else {
                        out.print("Error al generar");
                    }

                } catch (Exception e) {
                    out.print("Error en parametros");
                }
            }
            if (accion.equals("habilitarDesabilitar")) {
                try {
                    int codCPD = Integer.parseInt(request.getParameter("codComprobantePagoDetalle"));
                    Boolean estado = Boolean.parseBoolean(request.getParameter("estado"));
                    if (objcComprobantePagoDetalle.actualizar_estado(codCPD, estado)) {
                        out.print(codCPD);
                    } else {
                        out.print("error en parametros");
                    }

                } catch (Exception e) {
                    out.print("Error en parametros");
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
