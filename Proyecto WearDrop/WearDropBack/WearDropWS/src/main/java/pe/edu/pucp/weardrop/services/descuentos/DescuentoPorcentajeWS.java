/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */
package pe.edu.pucp.weardrop.services.descuentos;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import java.util.List;
import pe.edu.pucp.weardrop.clasificacionropa.Vigencia;

import pe.edu.pucp.weardrop.promocionesdescuentos.DescuentoPorcentaje;
import pe.edu.pucp.weardrop.descuento.boi.DescuentoPorcentajeBOI;
import pe.edu.pucp.weardrop.descuento.bo.DescuentoPorcentajeBOImpl;
import pe.edu.pucp.weardrop.prendas.Prenda;
import pe.edu.pucp.weardrop.promocionesdescuentos.DescuentoLiquidacion;

/**
 *
 * @author leona
 */
@WebService(serviceName = "DescuentoPorcentajeWS")
public class DescuentoPorcentajeWS {
    private final DescuentoPorcentajeBOI boDesc=new DescuentoPorcentajeBOImpl();
    /**
     * This is a sample web service operation
     */
    @WebMethod(operationName = "hello")
    public String hello(@WebParam(name = "name") String txt) {
        return "Hello " + txt + " !";
    }
    @WebMethod(operationName = "mostrar_descuentosporcentaje")
    public List<DescuentoPorcentaje> mostrar_descuentosporcentaje(){
        List<DescuentoPorcentaje> listaDesc=null;
        try{
            listaDesc=boDesc.listarTodos();
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return listaDesc;
    }
    @WebMethod(operationName = "mostrar_descuentosActivos")
    public List<DescuentoPorcentaje> mostrar_descuentosActivos(){
        List<DescuentoPorcentaje> listaDesc=null;
        try{
            listaDesc=boDesc.listarActivos();
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return listaDesc;
    }
    
     @WebMethod(operationName = "insertar_prendadescuento")
    public int insertar_prendadescuento(@WebParam(name="datDesc") DescuentoPorcentaje datDesc, @WebParam(name="prendas") ArrayList<Prenda> prendas, @WebParam(name="vig") Vigencia vig){
        
        int resultado=0;
        try{
            resultado=boDesc.insertar_PrendaDescuento(datDesc, prendas, vig);
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
   
    @WebMethod(operationName = "insertarDescuento")
    public int insertarDescuento(@WebParam(name="datDesc") DescuentoPorcentaje datDesc){
        int resultado=0;
        try{
            resultado=boDesc.insertar(datDesc);
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    //Para modificar Almacen
    @WebMethod(operationName = "modificarDescuentoPorcentaje")
    public int modificarDescuentoPorcentaje(@WebParam(name="datDesc") DescuentoPorcentaje datDesc){
        int resultado=0;
        try{
            resultado=boDesc.modificar(datDesc);
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "eliminarDescuentoPorcentaje")
    public int eliminarDescuentoPorcentaje(@WebParam(name="idDesc") int idDesc){
        int resultado=0;
        try{
            resultado=boDesc.eliminar(idDesc);
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    //Para Obtener Por ID
    @WebMethod(operationName = "obtenerPorId")
    public DescuentoPorcentaje obtenerPorId(@WebParam(name="idDesc") int idDesc){
        DescuentoPorcentaje datProm=null;
        try{
            datProm=boDesc.obtenerXId(idDesc);
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return datProm;
    }
}
