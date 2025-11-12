/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */
package pe.edu.pucp.weardrop.services.almacen;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.List;
import pe.edu.pucp.weardrop.almacen.MovimientoAlmacen_X_Lote;
import pe.edu.pucp.weardrop.almacen.bo.MovimientoAlmacen_X_Lote_BOImpl;
import pe.edu.pucp.weardrop.almacen.boi.MovimientoAlmacen_X_Lote_BOI;

/**
 *
 * @author Leonardo
 */
@WebService(serviceName = "MovimientoAlmacenXLoteWS")
public class MovimientoAlmacenXLoteWS {

    private MovimientoAlmacen_X_Lote_BOI boMovXLote = new MovimientoAlmacen_X_Lote_BOImpl();
    //Util para las grillas
    @WebMethod(operationName = "listarMovimientoXLotesActivos")
    public List<MovimientoAlmacen_X_Lote> listarMovimientoXLotesActivos(){
        List<MovimientoAlmacen_X_Lote> listaMovimientoXLotes=null;
        try{
            listaMovimientoXLotes=boMovXLote.listarActivos();
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return listaMovimientoXLotes;
    }
    
    //Para Registrar un Almacen
    @WebMethod(operationName = "insertarMovXLote")
    public int insertarMovXLote(@WebParam(name="datMovXLote") MovimientoAlmacen_X_Lote datMovXLote){
        int resultado=0;
        try{
            resultado=boMovXLote.insertar(datMovXLote);
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    //Para modificar Almacen
    @WebMethod(operationName = "modificarMovXLote")
    public int modificarMovXLote (@WebParam(name="datMovXLote") MovimientoAlmacen_X_Lote datMovXLote){
        int resultado=0;
        try{
            resultado=boMovXLote.modificar(datMovXLote);
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    //Para Eliminar el Almacen
    @WebMethod(operationName = "eliminarMovXLote")
    public int eliminarMovXLote(@WebParam(name="idMovXLote") int idMovXLote){
        int resultado=0;
        try{
            resultado=boMovXLote.eliminar(idMovXLote);
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    //Para Obtener Por ID
    @WebMethod(operationName = "obtenerMovXLotePorID")
    public MovimientoAlmacen_X_Lote obtenerMovXLotePorID(@WebParam(name="obtenerMovXLotePorId") int idMovXLote){
        MovimientoAlmacen_X_Lote datLote=null;
        try{
            datLote=boMovXLote.obtenerXId(idMovXLote);
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return datLote;
    }
    
    @WebMethod(operationName = "listarMovXLoteActivosPorAlmacen")
    public List<MovimientoAlmacen_X_Lote> listarMovXLoteActivosPorAlmacen(@WebParam(name="idAlmacen") int idAlmacen){
        List<MovimientoAlmacen_X_Lote> listaMovXLoteActivosPorAlmacen=null;
        try{
            listaMovXLoteActivosPorAlmacen=boMovXLote.listarMovXLoteActivosPorAlmacen(idAlmacen);
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return listaMovXLoteActivosPorAlmacen;
    }
}
