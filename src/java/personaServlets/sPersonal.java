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
import personaClases.cNatural;
import personaClases.cPersona;
import personaClases.cPersonal;
import tablas.Area;
import tablas.Cargo;
import tablas.PNatural;
import tablas.Persona;
import tablas.Personal;
import tablas.Usuario;
import tablas.Zona;
import utilitarios.cManejoFechas;
import utilitarios.cOtros;

/**
 *
 * @author Henrri
 */
@WebServlet(name = "sPersonal", urlPatterns = {"/sPersonal"})
public class sPersonal extends HttpServlet {

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

        cPersona objcPersona = new cPersona();
        cNatural objcNatural = new cNatural();
        cPersonal objcPersonal = new cPersonal();
        cManejoFechas objcManejoFechas = new cManejoFechas();
        cOtros objcOtros = new cOtros();


        String accion = request.getParameter("accionPersonal");
        int codPersona = 0, codPersonal = 0, codNatural = 0;


        if (accion == null) {
            session.removeAttribute("codPersonalMantenimiento");
            response.sendRedirect("persona/personalMantenimiento.jsp");
        } else {
            if (accion.equals("registrar")) {
                try {
                    //datos t_persona
                    Persona objPersona = new Persona();
                    objPersona.setNombres(request.getParameter("nombres"));
                    objPersona.setDireccion(request.getParameter("direccion"));
                    objPersona.setDniPasaporte(request.getParameter("dniPasaporte"));
                    objPersona.setTelefono1(request.getParameter("telefono1"));
                    objPersona.setTelefono2(request.getParameter("telefono2"));
                    objPersona.setRuc(request.getParameter("ruc"));
                    objPersona.setEmail(request.getParameter("email"));
                    objPersona.setFoto(request.getParameter("foto"));
                    objPersona.setEstado(true);
                    objPersona.setFechaNacimiento(objcManejoFechas.StringADate(request.getParameter("fechaNacimiento")));
                    objPersona.setObservaciones(request.getParameter("observacionPersona"));
                    objPersona.setRegistro(objcOtros.registro("1", objUsuario.getCodUsuario().toString()));
                    Zona objZona = new Zona();
                    objZona.setCodZona(Integer.parseInt(request.getParameter("codZona")));
                    objPersona.setZona(objZona);
                    //datos t_natural
                    PNatural objNatural = new PNatural();
                    objNatural.setCodModular("");
                    objNatural.setCargo("");
                    objNatural.setCarben("");
                    objNatural.setApePaterno(request.getParameter("apePaterno"));
                    objNatural.setApeMaterno(request.getParameter("apeMaterno"));
                    objNatural.setSexo(request.getParameter("sexo").equals("1") ? true : false);
                    objNatural.setEstadoCivil(request.getParameter("estadoCivil"));
                    objNatural.setDetalle(request.getParameter("observacionPersona"));
                    objNatural.setRegistro(objcOtros.registro("1", objUsuario.getCodUsuario().toString()));
                    //nombres c
                    objPersona.setNombresC(objNatural.getApePaterno() + " " + objNatural.getApeMaterno() + " " + objPersona.getNombres());
                    //datos t_personal
                    Personal objPersonal = new Personal();
                    objPersonal.setFechaInicioActividades(objcManejoFechas.StringADate(request.getParameter("fechaInicioActividades")));
                    objPersonal.setFechaFinActividades(objcManejoFechas.StringADate(request.getParameter("fechaFinActividades")));
                    objPersonal.setEstado(request.getParameter("estado").equals("1") ? true : false);
                    objPersonal.setObservacion(request.getParameter("observacionPersonal"));
                    objPersonal.setRegistro(objcOtros.registro("1", objUsuario.getCodUsuario().toString()));
                    Area objArea = new Area();
                    objArea.setCodArea(Integer.parseInt(request.getParameter("codArea")));
                    objPersonal.setArea(objArea);
                    Cargo objCargo = new Cargo();
                    objCargo.setCodCargo(Integer.parseInt(request.getParameter("codCargo")));
                    objPersonal.setCargo(objCargo);
                    //para ver si se actualiza o registra
                    try {
                        objPersona.setCodPersona(Integer.parseInt(request.getParameter("codPersona")));
                        objNatural.setPersona(objPersona);
                        objNatural.setCodNatural(Integer.parseInt(request.getParameter("codNatural")));
                        //se actualizara                     
                        objcPersona.actualizarObjeto(objPersona);
                        objcNatural.actualizar(objNatural);
                    } catch (Exception e) {
                        objPersona.setCodPersona(objcPersona.crear(objPersona));
                        objNatural.setPersona(objPersona);
                        objNatural.setCodNatural(objcNatural.Crear(objNatural));
                    }
                    objPersonal.setPersona(objPersona);
                    codPersonal = objcPersonal.crear(objPersonal);
                    out.print(codPersonal + "");
                } catch (Exception e) {
                    out.print("Error en parámetros");
                    return;
                }
            }
            if (accion.equals("mantenimiento")) {
                session.removeAttribute("codPersonalMantenimiento");
                try {
                    codPersonal = Integer.parseInt(request.getParameter("codPersonal"));
                    session.setAttribute("codPersonalMantenimiento", codPersonal);
                } catch (Exception e) {
                }
                response.sendRedirect("persona/personalMantenimiento.jsp");
            }
            if (accion.equals("editar")) {
                try {
                    //datos t_persona
                    Persona objPersona = new Persona();
                    objPersona.setCodPersona(Integer.parseInt(request.getParameter("codPersona")));
                    objPersona.setNombres(request.getParameter("nombres"));
                    objPersona.setDireccion(request.getParameter("direccion"));
                    objPersona.setDniPasaporte(request.getParameter("dniPasaporte"));
                    objPersona.setTelefono1(request.getParameter("telefono1"));
                    objPersona.setTelefono2(request.getParameter("telefono2"));
                    objPersona.setRuc(request.getParameter("ruc"));
                    objPersona.setEmail(request.getParameter("email"));
                    objPersona.setFoto(request.getParameter("foto"));
                    objPersona.setEstado(true);
                    objPersona.setFechaNacimiento(objcManejoFechas.StringADate(request.getParameter("fechaNacimiento")));
                    objPersona.setObservaciones(request.getParameter("observacionPersona"));
                    objPersona.setRegistro(objcOtros.registro("1", objUsuario.getCodUsuario().toString()));
                    Zona objZona = new Zona();
                    objZona.setCodZona(Integer.parseInt(request.getParameter("codZona")));
                    objPersona.setZona(objZona);
                    //datos t_natural
                    PNatural objNatural = new PNatural();
                    objNatural.setCodNatural(Integer.parseInt(request.getParameter("codNatural")));
                    objNatural.setApePaterno(request.getParameter("apePaterno"));
                    objNatural.setApeMaterno(request.getParameter("apeMaterno"));
                    objNatural.setSexo(request.getParameter("sexo").equals("1") ? true : false);
                    objNatural.setEstadoCivil(request.getParameter("estadoCivil"));
                    objNatural.setDetalle(request.getParameter("observacionPersona"));
                    objNatural.setRegistro(objcOtros.registro("1", objUsuario.getCodUsuario().toString()));
                    objNatural.setPersona(objPersona);//asignado persona
                    //nombres c
                    objPersona.setNombresC(objNatural.getApePaterno() + " " + objNatural.getApeMaterno() + " " + objPersona.getNombres());
                    //datos t_personal
                    Personal objPersonal = new Personal();
                    objPersonal.setCodPersonal(Integer.parseInt(request.getParameter("codPersonal")));
                    objPersonal.setFechaInicioActividades(objcManejoFechas.StringADate(request.getParameter("fechaInicioActividades")));
                    objPersonal.setFechaFinActividades(objcManejoFechas.StringADate(request.getParameter("fechaFinActividades")));
                    objPersonal.setEstado(request.getParameter("estado").equals("1") ? true : false);
                    objPersonal.setObservacion(request.getParameter("observacionPersonal"));
                    objPersonal.setRegistro(objcOtros.registro("1", objUsuario.getCodUsuario().toString()));
                    Area objArea = new Area();
                    objArea.setCodArea(Integer.parseInt(request.getParameter("codArea")));
                    objPersonal.setArea(objArea);
                    Cargo objCargo = new Cargo();
                    objCargo.setCodCargo(Integer.parseInt(request.getParameter("codCargo")));
                    objPersonal.setCargo(objCargo);
                    objPersonal.setPersona(objPersona);//asignado persona

                    objcPersona.actualizar(objPersona);
                    objcNatural.actualizar(objNatural);
                    objcPersonal.actualizar(objPersonal);

                    out.print(objPersonal.getCodPersonal());

                } catch (Exception e) {
                    out.print("Error en parámetros");
                    return;
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
