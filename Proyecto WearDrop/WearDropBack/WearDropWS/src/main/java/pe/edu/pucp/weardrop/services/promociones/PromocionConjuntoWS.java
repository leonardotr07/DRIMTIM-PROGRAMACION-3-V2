/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */
package pe.edu.pucp.weardrop.services.promociones;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import java.util.List;
import pe.edu.pucp.weardrop.clasificacionropa.Vigencia;
import pe.edu.pucp.weardrop.prendas.Prenda;
import pe.edu.pucp.weardrop.promocionesdescuentos.PromocionConjunto;
import pe.edu.pucp.weardrop.promocion.bo.PromocionConjuntoBOImpl;
import pe.edu.pucp.weardrop.promocion.boi.PromocionConjuntoBOI;
import pe.edu.pucp.weardrop.promocionesdescuentos.PromocionCombo;
/**
 *
 * @author leona
 */
@WebService(serviceName = "PromocionConjuntoWS")
public class PromocionConjuntoWS {
    private final PromocionConjuntoBOI boProm=new PromocionConjuntoBOImpl();
    /**
     * This is a sample web service operation
     */
    @WebMethod(operationName = "hello")
    public String hello(@WebParam(name = "name") String txt) {
        return "Hello " + txt + " !";
    }
    @WebMethod(operationName = "mostrar_promocionesconjunto")
    public List<PromocionConjunto> mostrar_promocionesconjunto(){
        List<PromocionConjunto> listaProm=null;
        try{
            listaProm=boProm.listarTodos();
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return listaProm;
    }
@WebMethod(operationName = "mostrar_promocionesActivas")
    public List<PromocionConjunto> mostrar_promocionesActivas(){
        List<PromocionConjunto> listaProm=null;
        try{
            listaProm=boProm.listarActivos();
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return listaProm;
    }
    
    @WebMethod(operationName = "insertar_prendapromocion")
    public int insertar_prendapromocion(@WebParam(name="datDesc") PromocionConjunto datProm,@WebParam(name="prendas") ArrayList<Prenda> prendas, @WebParam(name="vig") Vigencia vig){
        
        int resultado=0;
        try{
            resultado=boProm.insertar_PrendaYConjunto(datProm, prendas, vig);
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    @WebMethod(operationName = "insertarPromocion")
    public int insertarPromocion(@WebParam(name="datProm") PromocionConjunto datProm){
        int resultado=0;
        try{
            resultado=boProm.insertar(datProm);
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    //Para modificar Almacen
    @WebMethod(operationName = "modificarPromocionConjunto")
    public int modificarPromocionConjunto(@WebParam(name="datProm") PromocionConjunto datProm){
        int resultado=0;
        try{
            resultado=boProm.modificar(datProm);
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "eliminarPromocionConjunto")
    public int eliminarPromocionConjunto(@WebParam(name="idProm") int idProm){
        int resultado=0;
        try{
            resultado=boProm.eliminar(idProm);
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    //Para Obtener Por ID
    @WebMethod(operationName = "obtenerPorId")
    public PromocionConjunto obtenerPorId(@WebParam(name="idProm") int idProm){
        PromocionConjunto datProm=null;
        try{
            datProm=boProm.obtenerXId(idProm);
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return datProm;
    }
}
