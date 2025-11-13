/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.descuento.bo;

import java.util.ArrayList;
import pe.edu.pucp.weardrop.clasificacionropa.Vigencia;
import pe.edu.pucp.weardrop.descuento.boi.DescuentoMontoBOI;
import pe.edu.pucp.weardrop.descuento.dao.DescuentoMontoDAO;
import pe.edu.pucp.weardrop.descuento.mysql.DescuentoMontoImpl;
import pe.edu.pucp.weardrop.prendas.Prenda;
import pe.edu.pucp.weardrop.promocionesdescuentos.DescuentoMonto;

/**
 *
 * @author leona
 */
public class DescuentoMontoBOImpl implements DescuentoMontoBOI{
    private final DescuentoMontoDAO daoDesc;
    public DescuentoMontoBOImpl(){
        daoDesc=new DescuentoMontoImpl();
    }
    @Override
    public int insertar(DescuentoMonto objeto) throws Exception {
        validar(objeto);
        return daoDesc.insertar(objeto);
    }

    @Override
    public int modificar(DescuentoMonto objeto) throws Exception {
        validar(objeto);
        return daoDesc.modificar(objeto);
    }

    @Override
    public int eliminar(int idObjeto) throws Exception {
        return daoDesc.eliminar(idObjeto);
    }

    @Override
    public DescuentoMonto obtenerXId(int idObjeto) throws Exception {
        return daoDesc.obtenerPorId(idObjeto);
    }

    @Override
    public ArrayList<DescuentoMonto> listarTodos() throws Exception {
        return daoDesc.listarTodos();
    }

    @Override
    public void validar(DescuentoMonto objeto) throws Exception {
        Double montoE=objeto.getMontoEditable();
        Double montoM=objeto.getMontoMaximo();
        if(montoE>montoM){
            throw new Exception("El campo del monto editable tiene que ser menor igual a monto máximo");
        }
        if(montoE==null){
            throw new Exception("El campo del monto editable no puede ser nulo");
        }
        if(montoM==null){
            throw new Exception("El campo del monto máximo no puede ser nulo");
        }
        if(montoE<0){
            throw new Exception("El campo del monto editable no puede ser menor a 0");
        }
        if(montoM<0){
            throw new Exception("El campo del monto máximo no puede ser menor a 0");
        }
        if(objeto.getNombre().length()>75){
            throw new Exception("El campo del nombre no puede tener más de 75 carácteres");
        }
    }

    @Override
    public ArrayList<DescuentoMonto> listarActivos() throws Exception {
        return daoDesc.listarActivos();
    }

    @Override
    public int insertar_PrendaDescuento(DescuentoMonto descuento, ArrayList<Prenda> prendas, Vigencia vig) throws Exception {
        validar(descuento);
        int resultado=daoDesc.insertar_PrendaDescuento(descuento, prendas, vig);
        return resultado;
    }
    
}
