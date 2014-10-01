/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
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
import personaClases.cDocumentoNotificacion;
import tablas.DatosCliente;
import tablas.DocumentoNotificacion;
import tablas.Usuario;
import utilitarios.cManejoFechas;
import utilitarios.cOtros;

/**
 *
 * @author Henrri
 */
@WebServlet(name = "sDocumentoNotificacion", urlPatterns = {"/sDocumentoNotificacion"})
public class sDocumentoNotificacion extends HttpServlet {

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
        String accion = request.getParameter("accion");

        cOtros objcOtros = new cOtros();
        cDocumentoNotificacion objcDocumentoNotificacion = new cDocumentoNotificacion();
        if (objUsuario == null) {
            out.print("Sesión no iniciada");
            return;
        }

        if (accion == null) {

        } else {
            int codCliente = 0;
            if (accion.equals("registrar")) {
                try {
                    codCliente = Integer.parseInt(request.getParameter("codCliente"));
                    DocumentoNotificacion objDocumentoNotificacion = new DocumentoNotificacion();
                    objDocumentoNotificacion.setDatosCliente(new cDatosCliente().leer_cod(codCliente));
                    objDocumentoNotificacion.setFech1(new cManejoFechas().StringADate(request.getParameter("fech1").toString()));
                    objDocumentoNotificacion.setVarchar1(request.getParameter("varchar1").toString());
                    objDocumentoNotificacion.setText1(request.getParameter("text1").toString());
                    objDocumentoNotificacion.setText2(request.getParameter("text2").toString());
                    objDocumentoNotificacion.setRegistro(objcOtros.registro("1", objUsuario.getCodUsuario().toString()));
                    int cod = objcDocumentoNotificacion.crear(objDocumentoNotificacion);
                    if (cod != 0) {
                        out.print(codCliente);
                    } else {
                        out.print(objcDocumentoNotificacion.getError());
                    }
                } catch (Exception e) {
                    out.print("Error en parámetros: " + e.getMessage());
                }
            }
            if (accion.equals("editar")) {
                try {
                    int codDocumentoNotificacion = Integer.parseInt(request.getParameter("codDocumentoNotificacion"));
                    DocumentoNotificacion objDocumentoNotificacion = objcDocumentoNotificacion.leer_cod(codDocumentoNotificacion);
                    DocumentoNotificacion objDNNuevo = new DocumentoNotificacion();
                    objDNNuevo.setCodDocumentoNotificacion(codDocumentoNotificacion);
                    //***
                    DatosCliente objCliente=new cDatosCliente().leer_cod(objDocumentoNotificacion.getDatosCliente().getCodDatosCliente());
                    //**
                    objDNNuevo.setDatosCliente(objCliente);
                    objDNNuevo.setFech1(new cManejoFechas().StringADate(request.getParameter("fech1").toString()));
                    objDNNuevo.setVarchar1(request.getParameter("varchar1").toString());
                    objDNNuevo.setText1(request.getParameter("text1").toString());
                    objDNNuevo.setText2(request.getParameter("text2").toString());
                    objDNNuevo.setRegistro(objcOtros.registro("1", objUsuario.getCodUsuario().toString()));
                    if (objcDocumentoNotificacion.actualizar(objDNNuevo)) {
                        out.print(objCliente.getCodDatosCliente());
                    } else {
                        out.print(objcDocumentoNotificacion.getError());
                    }
                } catch (Exception e) {
                    out.print("Error en parámetros: " + e.getMessage());
                }
            }
            if(accion.equals("eliminar")){
                try{
                    int codDocumentoNotificacion = Integer.parseInt(request.getParameter("codDocumentoNotificacion"));
                    if(objcDocumentoNotificacion.actualizar_registro_historial(codDocumentoNotificacion, objcOtros.registro("0", objUsuario.getCodUsuario().toString()))){
                        out.print(codDocumentoNotificacion);
                    }else{
                        out.print(objcDocumentoNotificacion.getError());
                    }
                }catch(Exception e){
                   out.print("Error en parámetros: " + e.getMessage()); 
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
