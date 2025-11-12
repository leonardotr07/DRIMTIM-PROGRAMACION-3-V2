/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.almacen.bo;

import java.util.ArrayList;
import java.util.List;
import pe.edu.pucp.weardrop.almacen.Almacen;
import pe.edu.pucp.weardrop.almacen.MovimientoAlmacen;
import pe.edu.pucp.weardrop.almacen.boi.MovimientoAlmacenBOI;
import pe.edu.pucp.weardrop.almacen.dao.AlmacenDAO;
import pe.edu.pucp.weardrop.almacen.dao.MovimientoAlmacenDAO;
import pe.edu.pucp.weardrop.almacen.mysql.AlmacenImpl;
import pe.edu.pucp.weardrop.almacen.mysql.MovimientoAlmacenImpl;

/**
 *
 * @author Leonardo
 */
public class MovimientoAlmacenBOImpl implements MovimientoAlmacenBOI{
    private final MovimientoAlmacenDAO daoMov;
    private final AlmacenDAO daoAlmacen;

    public MovimientoAlmacenBOImpl() {
        daoMov=new MovimientoAlmacenImpl();
        daoAlmacen=new AlmacenImpl();
    }
    
    @Override
    public ArrayList<MovimientoAlmacen> listarActivos() {
        Almacen auxAlmacen=null;
        ArrayList<MovimientoAlmacen> listaMov=daoMov.listarActivos();
//        for(MovimientoAlmacen datMov: listaMov){
//            auxAlmacen=daoAlmacen.obtenerPorId(datMov.getDatAlmacen().getId()); //Para respetar el encapsulamiento
//            datMov.setDatAlmacen(auxAlmacen);
//        }
        return listaMov;
    }

    @Override
    public int insertar(MovimientoAlmacen objeto) throws Exception {
        validar(objeto);
        return daoMov.insertar(objeto);
    }

    @Override
    public int modificar(MovimientoAlmacen objeto) throws Exception {
        validar(objeto);
        return daoMov.modificar(objeto);
    }

    @Override
    public int eliminar(int idObjeto) throws Exception {
        return daoMov.eliminar(idObjeto);
    }

    @Override
    public MovimientoAlmacen obtenerXId(int idMovimiento) throws Exception {
        MovimientoAlmacen mov=daoMov.obtenerPorId(idMovimiento);
        Almacen datAlmacen=daoAlmacen.obtenerPorId(mov.getDatAlmacen().getId());
        mov.setDatAlmacen(datAlmacen);
        return mov;
    }

    @Override
    public ArrayList<MovimientoAlmacen> listarTodos() throws Exception {
        Almacen datAlmacen;
        ArrayList<MovimientoAlmacen> listaMov=daoMov.listarTodos();
        for(MovimientoAlmacen datMov: listaMov){
            datAlmacen=daoAlmacen.obtenerPorId(datMov.getDatAlmacen().getId());
            datMov.setDatAlmacen(datAlmacen);
        }
        return listaMov;
    }
    
    @Override
    public List<MovimientoAlmacen> listarMovimientosActivosPorAlmacen(int idAlmacen) {
        Almacen datAlmacen=daoAlmacen.obtenerPorId(idAlmacen);
        ArrayList<MovimientoAlmacen> listaMov=daoMov.listarMovimientosActivosPorAlmacen(idAlmacen);
        for(MovimientoAlmacen datMov: listaMov){
            Almacen auxAlmacen=new Almacen(datAlmacen); //Para respetar el encapsulamiento
            datMov.setDatAlmacen(auxAlmacen);
        }
        return listaMov;
    }

    @Override
    public void validar(MovimientoAlmacen objeto) throws Exception {
        if(objeto.getDatAlmacen()==null)
            throw new Exception("En Movimiento Almacen: No existe un Almacen Vinculado...");
        if(objeto.getDatAlmacen().getId()<=0)
            throw new Exception("En Movimiento Almacen: La FK es nula");
        
        if(objeto.getFecha()==null)
            throw new Exception("En Movimiento Almacen: El campo Fecha es nulo");
        
        if(objeto.getTipo().toString().length()>50)
            throw new Exception("En Movimiento Almacen: El campo Tipo supera los 50 caracteres (Utilize el ENUM)");
        if(objeto.getTipo()==null)
            throw new Exception("En Movimiento Almacen: El campo Tipo es nulo.");
        
        if(objeto.getLugarDestino().length()>100)
            throw new Exception("En Movimiento Almacen: El campo LugarDestino supera los 100 caracteres (Utilize el ENUM)");
        if(objeto.getLugarDestino()==null)
            throw new Exception("En Movimiento Almacen: El campo LugarDestino es nulo.");
        
        if(objeto.getLugarOrigen().length()>100)
            throw new Exception("En Movimiento Almacen: El campo LugarOrigen supera los 100 caracteres (Utilize el ENUM)");
        if(objeto.getLugarOrigen()==null)
            throw new Exception("En Movimiento Almacen: El campo LugarOrigen es nulo.");
    }
}
