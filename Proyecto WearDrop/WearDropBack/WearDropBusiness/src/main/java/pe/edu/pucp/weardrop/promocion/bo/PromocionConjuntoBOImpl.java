/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.promocion.bo;

import java.util.ArrayList;
import pe.edu.pucp.weardrop.clasificacionropa.Vigencia;
import pe.edu.pucp.weardrop.prendas.Prenda;
import pe.edu.pucp.weardrop.promocion.boi.PromocionConjuntoBOI;
import pe.edu.pucp.weardrop.promocion.dao.PromocionConjuntoDAO;
import pe.edu.pucp.weardrop.promocion.mysql.PromocionConjuntoImpl;
import pe.edu.pucp.weardrop.promocionesdescuentos.PromocionConjunto;

/**
 *
 * @author leona
 */
public class PromocionConjuntoBOImpl implements PromocionConjuntoBOI{
    private final PromocionConjuntoDAO daoProm;
    public PromocionConjuntoBOImpl(){
        daoProm=new PromocionConjuntoImpl();
    }
    @Override
    public int insertar(PromocionConjunto objeto) throws Exception {
        validar(objeto);
        return daoProm.insertar(objeto);
    }

    @Override
    public int modificar(PromocionConjunto objeto) throws Exception {
        validar(objeto);
        return daoProm.modificar(objeto);
    }

    @Override
    public int eliminar(int idObjeto) throws Exception {
        return daoProm.eliminar(idObjeto);
    }

    @Override
    public PromocionConjunto obtenerXId(int idObjeto) throws Exception {
        return daoProm.obtenerPorId(idObjeto);
    }

    @Override
    public ArrayList<PromocionConjunto> listarTodos() throws Exception {
        return daoProm.listarTodos();
    }

    @Override
    public void validar(PromocionConjunto objeto) throws Exception {
        
        Double porcen;
        porcen=objeto.getPorcentajePromocion();
        //Esto permite decidir si existe un valor asignado en la clase ya que en la BD no debe ser null
        if(porcen==null) throw new Exception("En promocion: El campo de porcentaje no debe ser nulo");

        if(porcen<0) 
            throw new Exception("En promocion: El campo de porcentaje debe ser mayor a 0");
        if(objeto.getNombre().length()>75)
            throw new Exception("En Promocion: El campo de nombre supera los 75 caracteres permitidos");
     }

    @Override
    public ArrayList<PromocionConjunto> listarActivos() throws Exception {
        return daoProm.listarActivos();
     }

    @Override
    public int insertar_PrendaYConjunto(PromocionConjunto descuento, ArrayList<Prenda> prendas, Vigencia vig) throws Exception {
        validar(descuento);
        int resultado=daoProm.insertarPrendaYConjunto(descuento, prendas, vig);
        return resultado;
    }
    
  
}
