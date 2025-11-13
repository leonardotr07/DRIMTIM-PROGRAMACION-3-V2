/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.descuento.bo;

import java.util.ArrayList;
import pe.edu.pucp.weardrop.clasificacionropa.Vigencia;
import pe.edu.pucp.weardrop.descuento.boi.DescuentoPorcentajeBOI;
import pe.edu.pucp.weardrop.descuento.dao.DescuentoPorcentajeDAO;
import pe.edu.pucp.weardrop.descuento.mysql.DescuentoPorcentajeImpl;
import pe.edu.pucp.weardrop.prendas.Prenda;
import pe.edu.pucp.weardrop.promocionesdescuentos.DescuentoPorcentaje;

/**
 *
 * @author leona
 */
public class DescuentoPorcentajeBOImpl implements DescuentoPorcentajeBOI{
    private final DescuentoPorcentajeDAO daoDesc;
    public DescuentoPorcentajeBOImpl(){
        daoDesc=new DescuentoPorcentajeImpl();
    }
    @Override
    public int insertar(DescuentoPorcentaje objeto) throws Exception {
        validar(objeto);
        return daoDesc.insertar(objeto);
    }

    @Override
    public int modificar(DescuentoPorcentaje objeto) throws Exception {
        validar(objeto);
        return daoDesc.modificar(objeto);
    }

    @Override
    public int eliminar(int idObjeto) throws Exception {
        return daoDesc.eliminar(idObjeto);
    }

    @Override
    public DescuentoPorcentaje obtenerXId(int idObjeto) throws Exception {
        return daoDesc.obtenerPorId(idObjeto);
    }

    @Override
    public ArrayList<DescuentoPorcentaje> listarTodos() throws Exception {
        return daoDesc.listarTodos();
    }

    @Override
    public void validar(DescuentoPorcentaje objeto) throws Exception {
       Double porcen=objeto.getPorcentaje();
       if(porcen==null){
           throw new Exception("El campo de porcentaje no puede ser nulo");
       }
       if(porcen<0){
           throw new Exception("El campo de porcentaje no puede ser menor a 0");
       }
       if(objeto.getNombre().length()>75){
           throw new Exception("El campo del nombre no puede tener más de 75 caractéres");
       }
    }

    @Override
    public ArrayList<DescuentoPorcentaje> listarActivos() throws Exception {
        return daoDesc.listarActivos();
    }

    @Override
    public int insertar_PrendaDescuento(DescuentoPorcentaje descuento, ArrayList<Prenda> prendas, Vigencia vig) throws Exception {
        validar(descuento);
        int resultado=daoDesc.insertar_PrendaDescuento(descuento, prendas, vig);
        return resultado ;
    }
    
}
