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
import pe.edu.pucp.weardrop.promocion.bo.PromocionComboBOImpl;
import pe.edu.pucp.weardrop.promocion.boi.PromocionComboBOI;
import pe.edu.pucp.weardrop.promocionesdescuentos.DescuentoLiquidacion;
import pe.edu.pucp.weardrop.promocionesdescuentos.PromocionCombo;

/**
 *
 * @author leona
 */
@WebService(serviceName = "PromocionCombo")
public class PromocionComboWS {
    private final PromocionComboBOI boProm=new PromocionComboBOImpl();
    /**
     * This is a sample web service operation
     */
    @WebMethod(operationName = "hello")
    public String hello(@WebParam(name = "name") String txt) {
        return "Hello " + txt + " !";
    }
    
    //Util para las grillas
    @WebMethod(operationName = "mostrar_promocionescombo")
    public List<PromocionCombo> mostrar_promocionescombo(){
        List<PromocionCombo> listaAlmacen=null;
        try{
            listaAlmacen=boProm.listarTodos();
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return listaAlmacen;
    }
       @WebMethod(operationName = "mostrar_promocionesActivas")
    public List<PromocionCombo> mostrar_promocionesActivas(){
        List<PromocionCombo> listaProm=null;
        try{
            listaProm=boProm.listarActivos();
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return listaProm;
    }
    
     @WebMethod(operationName = "insertar_prendapromocion")
    public int insertar_prendapromocion(@WebParam(name="datDesc") PromocionCombo datProm,@WebParam(name="prendas") ArrayList<Prenda> prendas, @WebParam(name="vig") Vigencia vig){
        
        int resultado=0;
        try{
            resultado=boProm.insertar_PrendaYCombo(datProm, prendas, vig);
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    //Para Registrar un Almacen
    @WebMethod(operationName = "insertarPromocion")
    public int insertarPromocion(@WebParam(name="datProm") PromocionCombo datProm){
        int resultado=0;
        try{
            resultado=boProm.insertar(datProm);
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    //Para modificar Almacen
    @WebMethod(operationName = "modificarPromocionCombo")
    public int modificarPromocionCombo(@WebParam(name="datProm") PromocionCombo datProm){
        int resultado=0;
        try{
            resultado=boProm.modificar(datProm);
        } catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "eliminarPromocionCombo")
    public int eliminarPromocionCombo(@WebParam(name="idProm") int idProm){
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
    public PromocionCombo obtenerPorId(@WebParam(name="idProm") int idProm){
        PromocionCombo datProm=null;
        try{
            datProm=boProm.obtenerXId(idProm);
        } catch(Exception ex){
            System.out.println(ex.getMessage());
            
        }
        
        return datProm;
    }
}
