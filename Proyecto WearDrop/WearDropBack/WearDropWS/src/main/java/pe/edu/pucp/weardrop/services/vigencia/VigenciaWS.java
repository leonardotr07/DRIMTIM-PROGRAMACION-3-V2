/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */
package pe.edu.pucp.weardrop.services.vigencia;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.List;
import pe.edu.pucp.weardrop.clasificacionropa.Vigencia;
import pe.edu.pucp.weardrop.vigencia.bo.VigenciaBO;
import pe.edu.pucp.weardrop.vigencia.boi.VigenciaBOI;

/**
 *
 * @author leona
 */
@WebService(serviceName = "VigenciaWS")
public class VigenciaWS {
    private final VigenciaBO boVig=new VigenciaBOI();

    /**
     * This is a sample web service operation
     */
    @WebMethod(operationName = "hello")
    public String hello(@WebParam(name = "name") String txt) {
        return "Hello " + txt + " !";
    }
     @WebMethod(operationName = "mosrtra_vigencias")
    public List<Vigencia> mosrtra_vigencias(){
        List<Vigencia> listaVig=null;
        try{
            listaVig=boVig.listarTodos();
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return listaVig;
    }
     @WebMethod(operationName = "mostrar_vigenciasActivas")
    public List<Vigencia> mostrar_vigenciasActivas(){
        List<Vigencia> listaDesc=null;
        try{
            listaDesc=boVig.listarActivos();
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return listaDesc;
    }
     @WebMethod(operationName = "insertarVigencia")
    public int insertarVigencia(@WebParam(name="datDesc") Vigencia datDesc){
        int resultado=0;
        try{
            resultado=boVig.insertar(datDesc);
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    @WebMethod(operationName = "modificarVigencia")
    public int modificarVigencia(@WebParam(name="datDesc") Vigencia datDesc){
        int resultado=0;
        try{
            resultado=boVig.modificar(datDesc);
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "eliminarVigencia")
    public int eliminarVigencia(@WebParam(name="idDesc") int idDesc){
        int resultado=0;
        try{
            resultado=boVig.eliminar(idDesc);
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
     @WebMethod(operationName = "obtenerPorId")
    public Vigencia obtenerPorId(@WebParam(name="idDesc") int idDesc){
        Vigencia datProm=null;
        try{
            datProm=boVig.obtenerXId(idDesc);
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return datProm;
    }
    
}
