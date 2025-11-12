/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */
package pe.edu.pucp.weardrop.services.almacen;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.List;
import pe.edu.pucp.weardrop.almacen.Lote;
import pe.edu.pucp.weardrop.almacen.bo.LoteBOImpl;
import pe.edu.pucp.weardrop.almacen.boi.LoteBOI;

/**
 *
 * @author Leonardo
 */
@WebService(serviceName = "LoteWS")
public class LoteWS {

    private LoteBOI boLote = new LoteBOImpl();
    
    //Util para las grillas
    @WebMethod(operationName = "listarLotesActivos")
    public List<Lote> listarLotesActivos(){
        List<Lote> listaMovimientoAlmacen=null;
        try{
            listaMovimientoAlmacen=boLote.listarActivos();
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return listaMovimientoAlmacen;
    }
    
    //Para Registrar un Almacen
    @WebMethod(operationName = "insertarLote")
    public int insertarLote(@WebParam(name="datMovimiento") Lote datLote){
        int resultado=0;
        try{
            resultado=boLote.insertar(datLote);
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    //Para modificar Almacen
    @WebMethod(operationName = "modificarLote")
    public int modificarLote(@WebParam(name="datLote") Lote datLote){
        int resultado=0;
        try{
            resultado=boLote.modificar(datLote);
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    //Para Eliminar el Almacen
    @WebMethod(operationName = "eliminarLote")
    public int eliminarLote(@WebParam(name="idLote") int idLote){
        int resultado=0;
        try{
            resultado=boLote.eliminar(idLote);
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    //Para Obtener Por ID
    @WebMethod(operationName = "obtenerLotePorID")
    public Lote obtenerLotePorId(@WebParam(name="idLote") int idLote){
        Lote datLote=null;
        try{
            datLote=boLote.obtenerXId(idLote);
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return datLote;
    }
    
    @WebMethod(operationName = "listarLotesActivosPorAlmacen")
    public List<Lote> listarLotesActivosPorAlmacen(@WebParam(name="idAlmacen") int idAlmacen){
        List<Lote> listaLotesPorAlmacen=null;
        try{
            listaLotesPorAlmacen=boLote.listarLotesActivosPorAlmacen(idAlmacen);
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return listaLotesPorAlmacen;
    }
    
    /*Método para los filtros*/
}
