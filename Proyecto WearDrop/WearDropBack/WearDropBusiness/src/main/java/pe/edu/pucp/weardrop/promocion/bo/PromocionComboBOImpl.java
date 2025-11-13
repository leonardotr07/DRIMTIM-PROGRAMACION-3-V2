/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.promocion.bo;

import java.util.ArrayList;
import pe.edu.pucp.weardrop.clasificacionropa.Vigencia;
import pe.edu.pucp.weardrop.prendas.Prenda;
import pe.edu.pucp.weardrop.promocion.boi.PromocionComboBOI;
import pe.edu.pucp.weardrop.promocion.dao.PromocionComboDAO;
import pe.edu.pucp.weardrop.promocion.mysql.PromocionComboImpl;
import pe.edu.pucp.weardrop.promocionesdescuentos.PromocionCombo;

/**
 *
 * @author leona
 */
public class PromocionComboBOImpl implements PromocionComboBOI{
    private final PromocionComboDAO daoProm;
    
    public PromocionComboBOImpl(){
        daoProm=new PromocionComboImpl();
    }
    @Override
    public int insertar(PromocionCombo objeto) throws Exception {
        validar(objeto);
        return daoProm.insertar(objeto);
    }

    @Override
    public int modificar(PromocionCombo objeto) throws Exception {
        validar(objeto);
        return daoProm.modificar(objeto);
    }

    @Override
    public int eliminar(int idObjeto) throws Exception {
        return daoProm.eliminar(idObjeto);
    }

    @Override
    public PromocionCombo obtenerXId(int idObjeto) throws Exception {
        return daoProm.obtenerPorId(idObjeto);
    }

    @Override
    public ArrayList<PromocionCombo> listarTodos() throws Exception {
        return daoProm.listarTodos();
    }

    @Override
    public void validar(PromocionCombo objeto) throws Exception {
        Integer cantgratis;
        cantgratis=objeto.getCantidadGratis();
        Integer cantReq=objeto.getCantidadRequerida();
        if(cantgratis>cantReq){
            throw new Exception("En promocion: El campo de cantidad Requerida no debe menor a la cantidad gratis");
        }
        if(cantReq==null) {
            throw new Exception("En promocion: El campo de cantidad Requerida no debe ser nulo");

        }
        if(cantgratis==null){
            throw new Exception("En promocion: El campo de cantidad gratis no debe ser nulo");
        }
        if(cantReq<0) {
            throw new Exception("En promocion: El campo de cantidad Requerida debe ser mayor a 0");
        }
        if(cantgratis<0){
            throw new Exception("En promocion: El campo de cantidad gratis debe ser mayor a 0");
        }
        if(75<objeto.getNombre().length())
            throw new Exception("En Promocion: El campo de nombre supera los 75 caracteres permitidos");
    }

    @Override
    public ArrayList<PromocionCombo> listarActivos() throws Exception {
        return daoProm.listarActivos();
    }

    @Override
    public int insertar_PrendaYCombo(PromocionCombo descuento, ArrayList<Prenda> prendas, Vigencia vig) throws Exception {
        validar(descuento);
        int resultado=daoProm.insertarPrendaYCombo(descuento, prendas, vig);
        return resultado;
    }
    
}
