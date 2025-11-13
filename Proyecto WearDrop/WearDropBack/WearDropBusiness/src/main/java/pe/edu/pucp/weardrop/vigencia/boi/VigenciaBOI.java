/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.vigencia.boi;

import java.util.ArrayList;
import pe.edu.pucp.weardrop.clasificacionropa.Vigencia;
import pe.edu.pucp.weardrop.vigencia.bo.VigenciaBO;
import pe.edu.pucp.weardrop.vigencia.dao.VigenciaDAO;
import pe.edu.pucp.weardrop.vigencia.mysql.VigenciaImpl;

/**
 *
 * @author leona
 */
public class VigenciaBOI implements VigenciaBO{
    private final VigenciaDAO daoVig;
    public VigenciaBOI(){
        daoVig=new VigenciaImpl();
    }

    @Override
    public int insertar(Vigencia objeto) throws Exception {
        validar(objeto);
        return daoVig.insertar(objeto);
    }

    @Override
    public int modificar(Vigencia objeto) throws Exception {
        validar(objeto);
        return daoVig.modificar(objeto);
    }

    @Override
    public int eliminar(int idObjeto) throws Exception {
        return daoVig.eliminar(idObjeto);
    }

    @Override
    public Vigencia obtenerXId(int idObjeto) throws Exception {
        Vigencia vig=daoVig.obtenerPorId(idObjeto);
        return vig;
    }

    @Override
    public ArrayList<Vigencia> listarTodos() throws Exception {
        ArrayList<Vigencia> lista=daoVig.listarTodos();
        return lista;
    }

    @Override
    public void validar(Vigencia objeto) throws Exception {
            if(objeto.getFechaInicio().compareTo(objeto.getFechaFin())>0){
                            throw new RuntimeException("La fecha de inicio debe ser menor a la fecha de fin.");

            }
    }

    @Override
    public ArrayList<Vigencia> listarActivos() {
        ArrayList<Vigencia> lista=daoVig.listarActivos();
        return lista;
    }
    
}
