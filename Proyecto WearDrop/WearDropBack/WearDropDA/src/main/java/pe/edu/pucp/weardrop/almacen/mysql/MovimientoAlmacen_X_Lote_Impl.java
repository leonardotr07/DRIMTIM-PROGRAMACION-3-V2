/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.almacen.mysql;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import pe.edu.pucp.weardrop.almacen.Almacen;
import pe.edu.pucp.weardrop.almacen.Lote;
import pe.edu.pucp.weardrop.almacen.MovimientoAlmacen;
import pe.edu.pucp.weardrop.almacen.MovimientoAlmacen_X_Lote;
import pe.edu.pucp.weardrop.almacen.TipoMovimiento;
import pe.edu.pucp.weardrop.almacen.dao.MovimientoAlmacen_X_Lote_DAO;
import pe.edu.pucp.weardrop.config.DBManager;

/**
 *
 * @author Leonardo
 */
public class MovimientoAlmacen_X_Lote_Impl implements MovimientoAlmacen_X_Lote_DAO {
    //Atributos
    private ResultSet rs;
    @Override
    public int insertar(MovimientoAlmacen_X_Lote datMov_X_Lote) {
        Map<Integer, Object> parametrosEntrada=new HashMap<>();
        Map<Integer, Object> parametrosSalida=new HashMap<>();
        
        parametrosSalida.put(1, Types.INTEGER);
        parametrosEntrada.put(2, datMov_X_Lote.getDatLote().getIdLote());
        parametrosEntrada.put(3, datMov_X_Lote.getDatMov().getIdMovimiento());
        parametrosEntrada.put(4, datMov_X_Lote.getDatMov().getDatAlmacen().getId());

        DBManager.getInstance().ejecutarProcedimiento("insertar_mov_X_lote", parametrosEntrada, parametrosSalida);
        
        datMov_X_Lote.setIdMov_X_Lote((int)parametrosSalida.get(1)); //Devolvemos el parametro.

        if(datMov_X_Lote.getIdMov_X_Lote()>0) System.out.println("Se ha insertado la relacion Movimiento - Lote correctamente.");
        else System.out.println("Ocurrio un error en la insercion de Movimiento - Lote");
        
        return datMov_X_Lote.getIdMov_X_Lote();
    }

    @Override
    public int modificar(MovimientoAlmacen_X_Lote datMov_X_Lote) {
        int resultado=0;
        Map<Integer, Object> parametrosEntrada=new HashMap<>();
        
        parametrosEntrada.put(1, datMov_X_Lote.getIdMov_X_Lote());
        parametrosEntrada.put(2, datMov_X_Lote.getDatLote().getIdLote());
        parametrosEntrada.put(3, datMov_X_Lote.getDatMov().getIdMovimiento());
        parametrosEntrada.put(4, datMov_X_Lote.getDatMov().getDatAlmacen().getId());
        parametrosEntrada.put(5, datMov_X_Lote.isActivo());

        resultado=DBManager.getInstance().ejecutarProcedimiento("modificar_mov_X_lote", parametrosEntrada, null);

        if(resultado>0) System.out.println("Se ha modificado correctamente la relacion mov_X_lote.");
        else System.out.println("Ocurrio un error en la modificación de la relacion mov_X_lote");
        
        return resultado;
    }

    @Override
    public int eliminar(int idMov_X_Lote) {
        Map<Integer, Object> parametrosEntrada=new HashMap<>();
        
        parametrosEntrada.put(1, idMov_X_Lote);
        
        int resultado=DBManager.getInstance().ejecutarProcedimiento("eliminar_mov_X_lote", parametrosEntrada, null);
        
        if(resultado>0) System.out.println("Se ha eliminado la relación mov_X_Lote correctamente");
        else System.out.println("Ocurrio un error en la eliminacion de la relación mov_X_Lote.");
        
        return resultado;
    }

    @Override
    public MovimientoAlmacen_X_Lote obtenerPorId(int idMov_X_Almacen) {
        MovimientoAlmacen_X_Lote datMov_X_Lote=null;
        
        Lote datLote=null;
        Almacen datAlmacen=null;
        MovimientoAlmacen datMov=null;
        
        Map<Integer, Object>parametrosEntrada=new HashMap<>();
        parametrosEntrada.put(1, idMov_X_Almacen);
        rs=DBManager.getInstance().ejecutarProcedimientoLectura("obtener_mov_X_lote_X_id", parametrosEntrada);
        
        try{
            if(rs.next()){
                datMov_X_Lote=new MovimientoAlmacen_X_Lote();
                datLote=new Lote();
                datMov=new MovimientoAlmacen();
                datAlmacen=new Almacen();
                
                datMov_X_Lote.setIdMov_X_Lote(rs.getInt(1));
                
                datLote.setIdLote(rs.getInt(2));
                datMov.setIdMovimiento(rs.getInt(3));
                datAlmacen.setId(rs.getInt(4));
                
                datMov_X_Lote.setActivo(rs.getBoolean(5));
                
                datMov.setDatAlmacen(datAlmacen);
                datLote.setDatAlmacen(datAlmacen);
                
                datMov_X_Lote.setDatLote(datLote);
                datMov_X_Lote.setDatMov(datMov);
                
                System.out.println("SE OBTUVO LA RELACION MOVIMIENTO ALMACEN-LOTE CORRECTAMENTE.");
            }
        }catch(SQLException ex){
            System.out.println("ERROR al obtener por ID en Movimiento Almacen-Lote: "+ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();
        }
        return datMov_X_Lote;
    }

    @Override
    public ArrayList<MovimientoAlmacen_X_Lote> listarTodos() {
        ArrayList<MovimientoAlmacen_X_Lote> listaMov_X_Lote=null;
        MovimientoAlmacen_X_Lote datMov_X_Lote=null;
        Lote datLote=null;
        Almacen datAlmacen=null;
        MovimientoAlmacen datMov=null;
        
        rs=DBManager.getInstance().ejecutarProcedimientoLectura("mostrar_mov_X_lote", null);
        
        try{
            while(rs.next()){
                if(listaMov_X_Lote==null) listaMov_X_Lote=new ArrayList<>();
                datMov_X_Lote=new MovimientoAlmacen_X_Lote();
                datLote=new Lote();
                datAlmacen=new Almacen();
                datMov=new MovimientoAlmacen();
                
                datMov_X_Lote.setIdMov_X_Lote(rs.getInt(1));
                
                datLote.setIdLote(rs.getInt(2));
                datMov.setIdMovimiento(rs.getInt(3));
                datAlmacen.setId(rs.getInt(4));
                
                datMov_X_Lote.setActivo(rs.getBoolean(5));
                
                datMov.setDatAlmacen(datAlmacen);
                datLote.setDatAlmacen(new Almacen(datAlmacen));
                
                datMov_X_Lote.setDatLote(datLote);
                datMov_X_Lote.setDatMov(datMov);
                
                listaMov_X_Lote.add(datMov_X_Lote);
            }
            System.out.println("SE LISTO TODAS LAS RELACIONES MOV ALMACEN - LOTE CORRECTAMENTE.");
        }catch(SQLException ex){
            System.out.println("ERROR al listar las relaciones Movimiento Almacen-Lote: "+ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();
        }
        return listaMov_X_Lote;
    }
    
    @Override
    public ArrayList<MovimientoAlmacen_X_Lote> listarActivos() {
        ArrayList<MovimientoAlmacen_X_Lote> listaMov_X_Lote=null;
        MovimientoAlmacen_X_Lote datMov_X_Lote=null;
        Lote datLote=null;
        Almacen datAlmacen=null;
        MovimientoAlmacen datMov=null;
        
        rs=DBManager.getInstance().ejecutarProcedimientoLectura("mostrar_mov_X_lote_activos", null);
        
        try{
            while(rs.next()){
                if(listaMov_X_Lote==null) listaMov_X_Lote=new ArrayList<>();
                datMov_X_Lote=new MovimientoAlmacen_X_Lote();
                datLote=new Lote();
                datAlmacen=new Almacen();
                datMov=new MovimientoAlmacen();
                
                datMov_X_Lote.setIdMov_X_Lote(rs.getInt(1));
                
                datLote.setIdLote(rs.getInt(2));
                datMov.setIdMovimiento(rs.getInt(3));
                datAlmacen.setId(rs.getInt(4));
                
                datMov_X_Lote.setActivo(rs.getBoolean(5));
                
                datMov.setDatAlmacen(datAlmacen);
                datLote.setDatAlmacen(new Almacen(datAlmacen));
                
                datMov_X_Lote.setDatLote(datLote);
                datMov_X_Lote.setDatMov(datMov);
                
                listaMov_X_Lote.add(datMov_X_Lote);
            }
            System.out.println("SE LISTO TODAS LAS RELACIONES ACTIVAS MOV ALMACEN - LOTE CORRECTAMENTE.");
        }catch(SQLException ex){
            System.out.println("ERROR al listar las relaciones activas Movimiento Almacen-Lote: "+ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();
        }
        return listaMov_X_Lote;
    }

    @Override
public ArrayList<MovimientoAlmacen_X_Lote> listarRelacionesActivasPorAlmacen(int idAlmacen) {
    ArrayList<MovimientoAlmacen_X_Lote> listaMov_X_Lote = null;
    MovimientoAlmacen_X_Lote datMov_X_Lote = null;
    Lote datLote = null;
    Almacen datAlmacen = null;
    MovimientoAlmacen datMov = null;
    
    Map<Integer, Object> parametrosEntrada = new HashMap<>();
    parametrosEntrada.put(1, idAlmacen);
    // Ejecutar el nuevo procedimiento que devuelve los detalles
    rs = DBManager.getInstance().ejecutarProcedimientoLectura("mostrar_mov_X_lote_activos_por_almacen", parametrosEntrada);
    
    try {
        while (rs.next()) {
            if (listaMov_X_Lote == null) listaMov_X_Lote = new ArrayList<>();
            datMov_X_Lote = new MovimientoAlmacen_X_Lote();
            datLote = new Lote();
            datAlmacen = new Almacen();
            datMov = new MovimientoAlmacen();
            
            // Mapeo del ResultSet a Objetos:
            // Columnas del SELECT:
            // 1. MQL.idMovAlmacen_X_Lote
            // 2. L.idLote
            // 3. MA.idMovAlmacen
            // 4. MA.Almacen_idAlmacen
            // 5. MA.tipo
            // 6. MA.lugarDestino
            // 7. MA.lugarOrigen
            // 8. L.descripcion
            // 9. MQL.activo
            
            // 1. Datos de la Relación (MovimientoAlmacen_X_Lote)
            datMov_X_Lote.setIdMov_X_Lote(rs.getInt(1));
            datMov_X_Lote.setActivo(rs.getBoolean(9)); 
            
            // 2. Datos del Lote
            datLote.setIdLote(rs.getInt(2));
            datLote.setDescripcion(rs.getString(8)); 
            
            // 3. Datos del Movimiento
            datMov.setIdMovimiento(rs.getInt(3));
            datMov.setTipo(TipoMovimiento.valueOf(rs.getString(5)));
            datMov.setLugarDestino(rs.getString(6));
            datMov.setLugarOrigen(rs.getString(7));
            
            // 4. Datos del Almacén (Usado en Lote y Movimiento)
            datAlmacen.setId(rs.getInt(4)); // ID Almacén
            
            // 5. Establecer relaciones
            datMov.setDatAlmacen(datAlmacen);
            // El lote y el movimiento tienen el mismo objeto Almacen para respetar la consistencia
            datLote.setDatAlmacen(new Almacen(datAlmacen)); 
            
            datMov_X_Lote.setDatLote(datLote);
            datMov_X_Lote.setDatMov(datMov);
            
            listaMov_X_Lote.add(datMov_X_Lote);
        }
        System.out.println("SE LISTARON LAS RELACIONES ACTIVAS MOV ALMACEN - LOTE CON DETALLE CORRECTAMENTE.");
    } catch (SQLException ex) {
        System.out.println("ERROR al listar las relaciones activas Movimiento Almacen-Lote: " + ex.getMessage());
    } finally {
        DBManager.getInstance().cerrarConexion();
    }
    return listaMov_X_Lote;
}
}
