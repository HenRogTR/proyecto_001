/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package cobranzaServlets;

import Clase.Fecha;
import Clase.Utilitarios;
import Ejb.EjbCobranza;
import Ejb.EjbDatosExtras;
import Ejb.EjbVentaCreditoLetra;
import cobranzaClases.cCobranza;
import cobranzaClases.cCobranzaDetalle;
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
import personaClases.cDatosCliente;
import tablas.Cobranza;
import tablas.CobranzaDetalle;
import tablas.DatosCliente;
import tablas.Usuario;
import ventaClases.cVentaCreditoLetra;

/**
 *
 * @author Henrri
 */
@WebServlet(name = "sCobranza", urlPatterns = {"/sCobranza"})
public class sCobranza extends HttpServlet {

    @EJB
    private EjbVentaCreditoLetra ejbVentaCreditoLetra;
    @EJB
    private EjbCobranza ejbCobranza;
    @EJB
    private EjbDatosExtras ejbDatosExtras;

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

        String accion = request.getParameter("accionCobranza");
        if (accion == null) {
            out.print("Error en acción");
            return;
        }
        if (accion.equals("registrar")) {
            //Verificar permiso de registro de cobranza.
            if (!objUsuario.getP35()) {
                out.print("No tiene permisos para esta acción.");
                return;
            }
            /*
             *tomar datos correctos para iniciar proceso de registro, se reciben
             *parámetros de formulario cobranza.
             */
            //Definiendo variables
            int codCliente;  //Recibir el código de cliente.
            String tipoPago;   //normal-> descuento de las cuotas   anticipo->se cargará como saldo a favor en el cliente
            String tipoCobro; //caja, descuento, manual
            Double montoAmortizar; //monto de dinero que ingresa
            Date fechaCobranza;   // se recibe en formato dd/mm/yyyy
            int codVenta; //Será diferente de 0 en caso el pago se filtre por venta
            String saldoFavorUsar; //0 en caso sea un pago normal y 1 en caso se use el saldo a favor
            String docSerieNumero; //en caso de que el ingreso sea manual xxx-000-000000
            String tipoCaja; //tipo del documento al ser seleccionado puede ser TKR, R etc.
            String tipoDescuento; //tipo del documento al ser seleccionado, código de descuento
            String serieCaja; // numero de serie en la forma 001,002,003, etc.
            String serieDescuento; // numero de serie en la forma 001,002,003, etc. Este ingreso es manual
            try {
                codCliente = Integer.parseInt(request.getParameter("codCliente").toString());
                tipoPago = request.getParameter("tipoPago").toString();
                tipoCobro = request.getParameter("tipoCobro").toString();
                montoAmortizar = Double.parseDouble(request.getParameter("montoAmortizar").toString());
                fechaCobranza = new Fecha().stringADate(request.getParameter("fechaCobranza").toString());
                codVenta = Integer.parseInt(request.getParameter("codVenta").toString());
                saldoFavorUsar = request.getParameter("saldoFavor").toString();
                docSerieNumero = request.getParameter("docSerieNumero").toString();
                tipoCaja = request.getParameter("docRecCaja").toString();
                tipoDescuento = request.getParameter("docRecDesc").toString();
                serieCaja = request.getParameter("serieSelect").toString();
                serieDescuento = request.getParameter("serie").toString();
            } catch (Exception e) {
                out.print("Error en parámetros. Contacte con el administrador.");
                return;
            }
            //Inicializar
            ejbVentaCreditoLetra = new EjbVentaCreditoLetra();
            if (!ejbVentaCreditoLetra.actualizarInteresPorCodigoCliente(codCliente)) {
                out.print("Error en ejecución de operación.");
                return;
            }

            //Buscamos el documento que se usará en el registro de la cobranza.
            ejbCobranza = new EjbCobranza();
            ejbCobranza.setCodUsuarioSession(objUsuario.getCodUsuario());
            String respuesta
                    = ejbCobranza.registrar(
                            codCliente, tipoPago, tipoCobro, montoAmortizar,
                            fechaCobranza, codVenta, saldoFavorUsar,
                            docSerieNumero, tipoCaja, tipoDescuento, serieCaja,
                            serieDescuento)
                    ? codCliente + ""
                    : "Error en el registro: " + ejbCobranza.getError();
            out.print(respuesta);
            return;
        }//fin accion registrar
        if (accion.equals("eliminar")) {//eliminar cobranza
            if (!objUsuario.getP24()) {
                out.print("No tiene permiso para esta operación. ");
                return;
            }
            Cobranza objCobranza = null;
            cCobranza objcCobranza = new cCobranza();
            cCobranzaDetalle objcCobranzaDetalle = new cCobranzaDetalle();
            cVentaCreditoLetra objcVentaCreditoLetra = new cVentaCreditoLetra();
            int codCobranza = 0;
            try {
                codCobranza = Integer.parseInt(request.getParameter("codCobranza"));
                objCobranza = new cCobranza().leer_codCobranza(codCobranza);
                if (objCobranza == null) {
                    out.print("No hay cobranza con ese parametro");
                    return;
                }
                if (objCobranza.getRegistro().substring(0, 1).equals("0")) {
                    out.print("El recibo y/o ticket se encuentra eliminado. Verifique o actualice");
                    return;
                }
            } catch (NumberFormatException e) {
                out.print("Error en parametros.");
                return;
            }
            for (CobranzaDetalle objCobranzaDetalle : objCobranza.getCobranzaDetalles()) {
                if (objCobranzaDetalle.getRegistro().substring(0, 1).equals("1")) {
                    //actualizamos el pago
                    objcVentaCreditoLetra.actualizar_pago(objCobranzaDetalle.getVentaCreditoLetra().getCodVentaCreditoLetra(), -objCobranzaDetalle.getImporte(), -objCobranzaDetalle.getInteres(), objCobranza.getFechaCobranza());
                    //reponemos si hay interes pendiente.
                    objcVentaCreditoLetra.actualizar_interesPendiente_retornar(objCobranzaDetalle.getVentaCreditoLetra().getCodVentaCreditoLetra());
                    objcCobranzaDetalle.actualizar_registro(objCobranzaDetalle.getCodCobranzaDetalle(), "0", objUsuario.getCodUsuario().toString());
                    //actualizar ultima fecha de pago
                    objcVentaCreditoLetra.actualizar_fechaUltimoPago(objCobranzaDetalle.getVentaCreditoLetra().getCodVentaCreditoLetra());
                }
            }
            DatosCliente objCliente = new cDatosCliente().leer_codPersona(objCobranza.getPersona().getCodPersona());// se lee a la persona
            System.out.println("Saldo actual= " + objCliente.getSaldoFavor());
            if (objCobranza.getDocSerieNumero().substring(0, 1).equals("X")) {//si en caso se uso el saldo a favor
                new cDatosCliente().actualizar_saldoFavor(objCliente.getCodDatosCliente(), objCobranza.getImporte());
            } else {
                new cDatosCliente().actualizar_saldoFavor(objCliente.getCodDatosCliente(), -objCobranza.getSaldo());
            }
            objcCobranza.actualizar_importe_saldo_registro(codCobranza, Utilitarios.registro("0", objUsuario.getCodUsuario()));// de la cobranza
            out.print(codCobranza);
            return;
        }//fin eliminar

        if (accion.equals("imprimirTicket")) {//inicio imprrmir ticket
            if (!objUsuario.getP36()) {
                out.print("No tiene permisos para esre acción.");
                return;
            }
            //Verificar si hay ruta
            ejbDatosExtras = new EjbDatosExtras();
            String rutaTemporalTicket = ejbDatosExtras.direccionArchivoTemporal();
            if ("".equals(rutaTemporalTicket)) {
                out.print("Dirección de archivo temporal no especificado. Contacte con el administrador del sistema.");
                return;
            }
            //Leyendo datos para preparar archivo temporal de impresión de ticket.
            int codCobranza = 0;
            try {
                codCobranza = Integer.parseInt(request.getParameter("codCobranza"));
            } catch (Exception e) {
                out.print("Error en parámetros.");
                return;
            }
            //Llamar método imprimir ticket
            ejbCobranza = new EjbCobranza();
            out.print(ejbCobranza.imprimir(codCobranza) ? codCobranza : ejbCobranza.getError());

//            List cobranzaDetalleList = null;
//            Cobranza objCobranza = null;
//            cCobranzaDetalle objcCobranzaDetalle = new cCobranzaDetalle();
//            Ticketera objTicketera = new Ticketera();
//            cNumeroLetra objcNumeroLetra = new cNumeroLetra();
//            try {
//                codCobranza = Integer.parseInt(request.getParameter("codCobranza"));
//                objCobranza = new cCobranza().leer_codCobranza(codCobranza);
//                cobranzaDetalleList = objcCobranzaDetalle.leer_codCobranza(codCobranza);
//            } catch (Exception e) {
//                out.print("Error en parametros");
//                return;
//            }
//            Iterator cobranzaDetalleIt = cobranzaDetalleList.iterator();
//
//            FileWriter file = null;
//            try {
//                file = new FileWriter(rutaTemporalTicket);
//            } catch (Exception e) {
//                e.printStackTrace();
//                out.print("Error al escribir archivo temporal en disco, no tiene persimo de escritura en -> " + rutaTemporalTicket + ". Cambie destino.");
//                return;
//            }
//            BufferedWriter buffer = new BufferedWriter(file);
//            PrintWriter ps = new PrintWriter(buffer);
//
//            objTicketera.setFormato(2, ps);
//            //2-> 33
//            //1-> 40
//            cDatosExtras objcDatosExtras = new cDatosExtras();
//            String cabecera = "******GRUPO YUCRA******";
//            String nombreEmpresa = objcDatosExtras.nombreEmpresa().getLetras();
//            String ruc = "RUC " + objcDatosExtras.rucEmpresa().getLetras();
//            String direccion = objcDatosExtras.direccionEmpresa().getLetras();
//            objTicketera.escribir(Utilitarios.centrar(cabecera.toUpperCase(), 33), ps);   //cabecera
//            objTicketera.escribir(Utilitarios.centrar(nombreEmpresa.toUpperCase(), 33), ps);  //nombre empresa
//            objTicketera.escribir(Utilitarios.centrar(ruc.toUpperCase(), 33), ps);       //ruc
//            objTicketera.escribir(Utilitarios.centrar(direccion.toUpperCase(), 33), ps);   //direccion
//            objTicketera.setFormato(1, ps);
//            objTicketera.escribir("          FEC. IMP. " + new cManejoFechas().fechaHoraAString(new Date()), ps);
//            objTicketera.correr(1, ps);
//            objTicketera.escribir("N. RECIBO: " + objCobranza.getDocSerieNumero(), ps);
//            objTicketera.escribir("FEC. PAGO: " + new Fecha().dateAString(objCobranza.getFechaCobranza()), ps);
//            objTicketera.escribir("CLIEN: " + objCobranza.getPersona().getNombresC(), ps);
//            String neto = Utilitarios.decimalFormato((objCobranza.getImporte() + objCobranza.getSaldo()), 2);
//            objTicketera.escribir("IMPORTE: S/. " + neto, ps);
//            objTicketera.escribir("SON: " + objcNumeroLetra.importeNumeroALetra(neto, true, "N.S."), ps);
//            objTicketera.correr(1, ps);
//            objTicketera.escribir("DETALLE                       MONTO", ps);
//            objTicketera.Dibuja_Linea(ps);
//
////            int cont = 0;
//            while (cobranzaDetalleIt.hasNext()) {
//                CobranzaDetalle objCobranzaDetalle = (CobranzaDetalle) cobranzaDetalleIt.next();
//                String letraDetalle = objCobranzaDetalle.getVentaCreditoLetra().getNumeroLetra() == 0 ? "INICIAL" : "LET. " + objCobranzaDetalle.getVentaCreditoLetra().getNumeroLetra().toString();
//                String monto = Utilitarios.decimalFormato(objCobranzaDetalle.getImporte(), 2);
//                int montoExt = monto.length();
//                for (int i = 0; i < 15 - montoExt; i++) {
//                    monto = "*" + monto;
//                }
//                monto = "   " + monto;
//                objTicketera.escribir(letraDetalle + " " + objCobranzaDetalle.getVentaCreditoLetra().getVentas().getDocSerieNumero() + monto, ps);
//                //para agregar detalle de interés
//                if (objCobranzaDetalle.getInteres() > 0) {
//                    String interesDetalle = letraDetalle;
//                    String montoInteres = Utilitarios.decimalFormato(objCobranzaDetalle.getInteres(), 2);
//                    int montoInt = montoInteres.length();
//                    for (int i = 0; i < 13 - montoInt; i++) {
//                        montoInteres = "*" + montoInteres;
//                    }
////                    montoInteres = " " + montoInteres;
//                    objTicketera.escribir(interesDetalle + " " + objCobranzaDetalle.getVentaCreditoLetra().getVentas().getDocSerieNumero() + " INT.", ps);
//                    objTicketera.escribir("       Venc. " + new Fecha().dateAString(objCobranzaDetalle.getVentaCreditoLetra().getFechaVencimiento()) + " " + montoInteres, ps);
//                }
//            }
//            if (objCobranza.getSaldo() > 0) {
//                String anticipo = Utilitarios.decimalFormato(objCobranza.getSaldo(), 2);
//                int tem = anticipo.length();
//                for (int j = 0; j < 15 - tem; j++) {
//                    anticipo = "*" + anticipo;
//                }
//                objTicketera.escribir("ANTICIPO              " + anticipo, ps);
//            }
//            objTicketera.Dibuja_Linea(ps);
//            objTicketera.escribir("OP: " + Utilitarios.agregarCerosIzquierda(codCobranza, 8) + "       USUARIO: " + objUsuario.getUsuario(), ps);
//            objTicketera.correr(1, ps);
//            objTicketera.escribir(" YUCRA ...PENSAMOS EN TI.", ps);
//            objTicketera.escribir("    VISITE NUESTRA WEB WWW.YUCRA.COM", ps);
//            objTicketera.correr(1, ps);
//            objTicketera.correr(10, ps);
//            objTicketera.cortar(ps);
//            ps.close();
//
//            FileInputStream inputStream = null;
//            try {
//                inputStream = new FileInputStream(rutaTemporalTicket);
//            } catch (FileNotFoundException e) {
//                e.printStackTrace();
//            }
//            if (inputStream == null) {
//                out.print("Error al imprimir ticket, archivo temporal no encontrado");
//                return;
//            }
//
//            DocFlavor docFormat = DocFlavor.INPUT_STREAM.AUTOSENSE;
//            Doc document = new SimpleDoc(inputStream, docFormat, null);
//
//            PrintRequestAttributeSet attributeSet = new HashPrintRequestAttributeSet();
//            PrintService ticketeraImp = PrintServiceLookup.lookupDefaultPrintService();
//
//            //*********************************************************************
//            List lTick = new cDatosExtras().leer_ticketera();
//            if (lTick == null) {
//                out.print("No hay ticketera asiganda.");
//                return;
//            }
//            if (lTick.isEmpty()) {
//                out.print("No hay ticketera asiganda.");
//                return;
//            }
//            DatosExtras objDatosExtras = (DatosExtras) lTick.get(0);
//            String ticket = objDatosExtras.getLetras();
////            String ticket = "\\\\CAJA-PC\\EPSON TM-U220 Receipt";
//            PrintService[] services = null;
//
//            // buscar por el nombre de la impresora (nombre que le diste en tu S.O.)
//            // en "aset" puedes agregar mas atributos de busqueda
//            AttributeSet aset = new HashAttributeSet();
//            aset.add(new PrinterName(ticket, null));
//            aset.add(ColorSupported.SUPPORTED); // si quisieras buscar ademas las que soporten color
////
//            services = PrintServiceLookup.lookupPrintServices(null, aset);
//            if (services.length == 0) {
//                out.print("No hay ticketera instalada " + ticket);
//                return;
//            }
//            for (PrintService printService : services) {
//                ticketeraImp = printService;
//                System.out.println("******************************" + printService.getName());
//            }
//            //*********************************************************************
//            if (ticketeraImp != null) {
//                System.out.println(ticketeraImp.getName());
//                DocPrintJob printJob = ticketeraImp.createPrintJob();
//                try {
//                    printJob.print(document, attributeSet);
//                    inputStream.close();
//                } catch (Exception e) {
//                    e.printStackTrace();
//                }
//            } else {
//                out.print("error al imprimir ticket(no hay impresora instalada)");
//                return;
//            }
//            out.print(codCobranza);
//            return;
        }//fin imprimir ticket
        if ("imprimirCobranzaReporte".equals(accion)) {
            //asignar el código a una sessión
            try {
                session.removeAttribute("reporteCobranzaCodCliente");
                session.setAttribute("reporteCobranzaCodCliente", request.getParameter("codCliente").toString());
                String tipo = request.getParameter("tipo").toString();
                session.removeAttribute("reporteCobranzaCodVenta");
                session.setAttribute("reporteCobranzaCodVenta", "ventaActual".equals(tipo) ? request.getParameter("codVenta") : null);
            } catch (Exception e) {
                out.print("Error en parámetros.");
                return;
            }
            //redireccionamos
            response.sendRedirect("reporte/cobranzaPorCodClienteYCodVenta.jsp");
            return;
        }

        out.print("No se encontró operación para: <strong>" + accion + "</strong>");
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
