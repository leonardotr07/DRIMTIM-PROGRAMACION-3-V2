/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.almacen.bo;

import java.util.ArrayList;
import pe.edu.pucp.weardrop.almacen.Almacen;
import pe.edu.pucp.weardrop.almacen.Lote;
import pe.edu.pucp.weardrop.almacen.MovimientoAlmacen;
import pe.edu.pucp.weardrop.almacen.boi.LoteBOI;
import pe.edu.pucp.weardrop.almacen.dao.AlmacenDAO;
import pe.edu.pucp.weardrop.almacen.dao.LoteDAO;
import pe.edu.pucp.weardrop.almacen.dao.MovimientoAlmacenDAO;
import pe.edu.pucp.weardrop.almacen.mysql.AlmacenImpl;
import pe.edu.pucp.weardrop.almacen.mysql.LoteImpl;
import pe.edu.pucp.weardrop.almacen.mysql.MovimientoAlmacenImpl;

/**
 *
 * @author Leonardo
 */
public class LoteBOImpl implements LoteBOI{
    private final LoteDAO daoLote;
    
    public LoteBOImpl(){
        daoLote=new LoteImpl();
    }
    @Override
    public ArrayList<Lote> listarActivos() {
        AlmacenDAO daoAlmacen=new AlmacenImpl();
        
        ArrayList<Lote> listarLotesPorAlmacen = null;
        listarLotesPorAlmacen=daoLote.listarActivos();
        
        return listarLotesPorAlmacen;
    }
    
    @Override
    public int insertar(Lote objeto) throws Exception {
        //El detalle mencionado en el MovimientoAlmacenBOImpl también ocurre aqui
        validar(objeto);
        return daoLote.insertar(objeto);
    }

    @Override
    public int modificar(Lote objeto) throws Exception {
        validar(objeto);
        return daoLote.modificar(objeto);
    }

    @Override
    public int eliminar(int idObjeto) throws Exception {
        return daoLote.eliminar(idObjeto);
    }

    @Override
    public Lote obtenerXId(int idObjeto) throws Exception {
        AlmacenDAO daoAlmacen=new AlmacenImpl();
        Lote datLote=daoLote.obtenerPorId(idObjeto);
        Almacen datAlmacen=daoAlmacen.obtenerPorId(datLote.getDatAlmacen().getId());
        datLote.setDatAlmacen(datAlmacen);
        return datLote;
    }

    @Override
    public ArrayList<Lote> listarTodos() throws Exception {
        AlmacenDAO daoAlmacen=new AlmacenImpl();
        ArrayList<Lote> listaLote=daoLote.listarTodos();
        for(Lote datLote:listaLote){
            Almacen datAlmacen=daoAlmacen.obtenerPorId(datLote.getDatAlmacen().getId());
            datLote.setDatAlmacen(datAlmacen);
        }
        return listaLote;
    }
    
    @Override
    public ArrayList<Lote> listarLotesActivosPorAlmacen(int idAlmacen) throws Exception {
        AlmacenDAO daoAlmacen=new AlmacenImpl();
        
        Almacen datAlmacen=daoAlmacen.obtenerPorId(idAlmacen);
        ArrayList<Lote> listarLotesPorAlmacen = null;
        
        listarLotesPorAlmacen=daoLote.listarLotesActivosPorAlmacen(idAlmacen);
        
        for(Lote datLote: listarLotesPorAlmacen)
            datLote.setDatAlmacen(new Almacen(datAlmacen));
        
        return listarLotesPorAlmacen;
    }

    @Override
    public void validar(Lote objeto) throws Exception {
        if(objeto.getDatAlmacen()==null)
            throw new Exception("En Lote: No existe un almacen vinculado");
        if(objeto.getDatAlmacen().getId()<=0)
            throw new Exception("En Lote: La FK del Almacen es nula (Almacen)");
        if(objeto.getDescripcion().length()>255)
            throw new Exception("En Lote: La descripcion supera el máximo de caracteres permitidos (255)");
    }
    
}
