/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */
package pe.edu.pucp.weardrop.services.almacen;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.List;
import pe.edu.pucp.weardrop.almacen.Almacen;
import pe.edu.pucp.weardrop.almacen.MovimientoAlmacen;
import pe.edu.pucp.weardrop.almacen.bo.MovimientoAlmacenBOImpl;
import pe.edu.pucp.weardrop.almacen.boi.MovimientoAlmacenBOI;

/**
 *
 * @author Leonardo
 */
@WebService(serviceName = "MovimientoAlmacenWS")
public class MovimientoAlmacenWS {

    private MovimientoAlmacenBOI boMovimiento=new MovimientoAlmacenBOImpl();
    
    //Se demora
    @WebMethod(operationName = "listarMovimientosActivos")
    public List<MovimientoAlmacen> listarMovimientosActivos(){
        List<MovimientoAlmacen> listaMovimientoAlmacen=null;
        try{
            listaMovimientoAlmacen=boMovimiento.listarActivos();
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return listaMovimientoAlmacen;
    }
    
    //Para Registrar un Almacen
    @WebMethod(operationName = "insertarMovAlmacen")
    public int insertarMovAlmacen(@WebParam(name="datMovimiento") MovimientoAlmacen datMov){
        int resultado=0;
        try{
            resultado=boMovimiento.insertar(datMov);
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    //Para modificar Almacen
    @WebMethod(operationName = "modificarMovimientoAlmacen")
    public int modificarMovAlmacen(@WebParam(name="datMovimiento") MovimientoAlmacen datMov){
        int resultado=0;
        try{
            resultado=boMovimiento.modificar(datMov);
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    //Para Eliminar el Almacen
    @WebMethod(operationName = "eliminarMovimientoAlmacen")
    public int eliminarMovAlmacen(@WebParam(name="idMovimiento") int idMov){
        int resultado=0;
        try{
            resultado=boMovimiento.eliminar(idMov);
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    //Para Obtener Por ID
    @WebMethod(operationName = "obtenerMovimientoPorId")
    public MovimientoAlmacen obtenerMovPorId(@WebParam(name="idMovimiento") int idMov){
        MovimientoAlmacen datMovimiento=null;
        try{
            datMovimiento=boMovimiento.obtenerXId(idMov);
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return datMovimiento;
    }
    //Util para las grillas
    @WebMethod(operationName = "listarMovimientosPorAlmacen")
    public List<MovimientoAlmacen> listarMovimientosPorAlmacen(int idAlmacen){
        List<MovimientoAlmacen> listaMovimientosXAlmacen=null;
        try{
            //ListarMovimientosPorAlmacen
            listaMovimientosXAlmacen=boMovimiento.listarMovimientosActivosPorAlmacen(idAlmacen);
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return listaMovimientosXAlmacen;
    }
    
    /*Faltan los filtros */
}
