/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.almacen.bo;

import java.util.ArrayList;
import pe.edu.pucp.weardrop.almacen.Almacen;
import pe.edu.pucp.weardrop.almacen.Lote;
import pe.edu.pucp.weardrop.almacen.MovimientoAlmacen_X_Lote;
import pe.edu.pucp.weardrop.almacen.boi.MovimientoAlmacen_X_Lote_BOI;
import pe.edu.pucp.weardrop.almacen.dao.AlmacenDAO;
import pe.edu.pucp.weardrop.almacen.dao.LoteDAO;
import pe.edu.pucp.weardrop.almacen.dao.MovimientoAlmacenDAO;
import pe.edu.pucp.weardrop.almacen.dao.MovimientoAlmacen_X_Lote_DAO;
import pe.edu.pucp.weardrop.almacen.mysql.AlmacenImpl;
import pe.edu.pucp.weardrop.almacen.mysql.LoteImpl;
import pe.edu.pucp.weardrop.almacen.mysql.MovimientoAlmacenImpl;
import pe.edu.pucp.weardrop.almacen.mysql.MovimientoAlmacen_X_Lote_Impl;

/**
 *
 * @author Leonardo
 */
public class MovimientoAlmacen_X_Lote_BOImpl implements MovimientoAlmacen_X_Lote_BOI {

    private final LoteDAO daoLote;
    private final MovimientoAlmacenDAO daoMov;
    private final AlmacenDAO daoAlmacen;
    private final MovimientoAlmacen_X_Lote_DAO daoMov_X_Lote;
    
    public MovimientoAlmacen_X_Lote_BOImpl() {
        daoMov=new MovimientoAlmacenImpl();
        daoAlmacen=new AlmacenImpl();
        daoLote=new LoteImpl();
        daoMov_X_Lote=new MovimientoAlmacen_X_Lote_Impl();
    }
    
    @Override
    public int insertar(MovimientoAlmacen_X_Lote objeto) throws Exception {
        validar(objeto);
        return daoMov_X_Lote.insertar(objeto);
    }

    @Override
    public int modificar(MovimientoAlmacen_X_Lote objeto) throws Exception {
        validar(objeto);
        return daoMov_X_Lote.modificar(objeto);
    }

    @Override
    public int eliminar(int idObjeto) throws Exception {
        return daoMov_X_Lote.eliminar(idObjeto);
    }

    @Override
    public MovimientoAlmacen_X_Lote obtenerXId(int idObjeto) throws Exception {
        MovimientoAlmacen_X_Lote dato=daoMov_X_Lote.obtenerPorId(idObjeto);
        //Hallamos los datos asociados de Lote y Mov
        dato.setDatLote(daoLote.obtenerPorId(dato.getDatLote().getIdLote()));
        dato.setDatMov(daoMov.obtenerPorId(dato.getDatMov().getIdMovimiento()));
        return dato;
    }

    @Override
    public ArrayList<MovimientoAlmacen_X_Lote> listarTodos() throws Exception {
        ArrayList<MovimientoAlmacen_X_Lote> listaRelaciones=daoMov_X_Lote.listarTodos();
        for(MovimientoAlmacen_X_Lote dato: listaRelaciones){
            //Al igual que en obtener X Id... Hallamos los datos de Lote y Movimiento por cada registro de relacion...
            dato.setDatLote(daoLote.obtenerPorId(dato.getDatLote().getIdLote()));
            dato.setDatMov(daoMov.obtenerPorId(dato.getDatMov().getIdMovimiento()));
        }
        return listaRelaciones;
    }

    @Override
    public void validar(MovimientoAlmacen_X_Lote datMov_X_Lote) throws Exception {
        if(datMov_X_Lote.getDatLote()==null)
            throw new Exception("MovimientoAlmacen_X_Lote: Debe ingresar un Lote");
        
        if(datMov_X_Lote.getDatMov()==null)
            throw new Exception("MovimientoAlmacen_X_Lote: Debe ingresar un Movimiento");
        
        if(datMov_X_Lote.getDatMov().getDatAlmacen()==null)
            throw new Exception("MovimientoAlmacen_X_Lote: Debe vincular un almacen para que el movimiento sea valido.");
        
        if(datMov_X_Lote.getDatLote().getIdLote()<=0)
            throw new Exception("MovimientoAlmacen_X_Lote: El ID del lote no es válido (Debe ingresarlo y ser mayor a 0)");
        if(datMov_X_Lote.getDatMov().getIdMovimiento()<=0)
            throw new Exception("MovimientoAlmacen_X_Lote: El ID del movimiento no es válido (Debe ingresarlo y ser mayor a 0)");
        if(datMov_X_Lote.getDatMov().getDatAlmacen().getId()<=0)
            throw new Exception("MovimientoAlmacen_X_Lote: El ID del almacen asociado al Movimiento no es válido (Debe ingresarlo y ser mayor a 0)");
    }
    
    
    @Override
    public ArrayList<MovimientoAlmacen_X_Lote> listarActivos() {
        ArrayList<MovimientoAlmacen_X_Lote> listaRelacionesActivos=daoMov_X_Lote.listarActivos();
        for(MovimientoAlmacen_X_Lote dato: listaRelacionesActivos){
            //Al igual que en obtener X Id... Hallamos los datos de Lote y Movimiento por cada registro de relacion...
            dato.setDatLote(daoLote.obtenerPorId(dato.getDatLote().getIdLote()));
            dato.setDatMov(daoMov.obtenerPorId(dato.getDatMov().getIdMovimiento()));
        }
        return listaRelacionesActivos;
    }

    @Override
    public ArrayList<MovimientoAlmacen_X_Lote> listarMovXLoteActivosPorAlmacen(int idAlmacen) {
        AlmacenDAO daoAlmacen=new AlmacenImpl();
        
        Almacen datAlmacen=daoAlmacen.obtenerPorId(idAlmacen);
        ArrayList<MovimientoAlmacen_X_Lote> listarMovXLotesPorAlmacen = null;
        
        listarMovXLotesPorAlmacen=daoMov_X_Lote.listarRelacionesActivasPorAlmacen(idAlmacen);
        return listarMovXLotesPorAlmacen;
    }
    
}
