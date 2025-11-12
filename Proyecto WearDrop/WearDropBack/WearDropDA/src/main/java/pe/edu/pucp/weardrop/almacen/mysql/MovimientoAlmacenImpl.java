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
import pe.edu.pucp.weardrop.almacen.MovimientoAlmacen;
import pe.edu.pucp.weardrop.almacen.TipoMovimiento;
import pe.edu.pucp.weardrop.almacen.dao.AlmacenDAO;
import pe.edu.pucp.weardrop.almacen.dao.MovimientoAlmacenDAO;
import pe.edu.pucp.weardrop.config.DBManager;

/**
 *
 * @author Leonardo
 */
public class MovimientoAlmacenImpl implements MovimientoAlmacenDAO {
    //Atributos
    private ResultSet rs;
    
    //Métodos de Interfaz, es muy dependiente de Almacen y Lote
    @Override
    public int insertar(MovimientoAlmacen datMov) {
        //0: Si tuvo error, devuelve el id asignado por la BD si fue exitoso.
        Map<Integer, Object> parametrosEntrada=new HashMap<>();
        Map<Integer, Object> parametrosSalida=new HashMap<>();
        
        //En el model existe un atributo de IdAlmacen... Debería ser un Objeto?
        parametrosSalida.put(1, Types.INTEGER);
        parametrosEntrada.put(2, datMov.getDatAlmacen().getId());
        parametrosEntrada.put(3, datMov.getFecha());
        parametrosEntrada.put(4, datMov.getLugarDestino());
        parametrosEntrada.put(5, datMov.getLugarOrigen());
        parametrosEntrada.put(6, datMov.getTipo().toString());
        
        DBManager.getInstance().ejecutarProcedimiento("insertar_mov_almacen", parametrosEntrada, parametrosSalida);
        
        datMov.setIdMovimiento((int)parametrosSalida.get(1)); //Devolvemos el parametro.
        
        datMov.mostrarMovAlmacen();
        if(datMov.getIdMovimiento()>0) System.out.println("Se ha insertado el movimiento correctamente.");
        else System.out.println("Ocurrio un error en la inserción del movimiento");
        
        return datMov.getIdMovimiento();
    }

    @Override
    public int modificar(MovimientoAlmacen datMov) {
        Map<Integer, Object> parametrosEntrada=new HashMap<>();
        
        parametrosEntrada.put(1, datMov.getIdMovimiento());
        parametrosEntrada.put(2, datMov.getDatAlmacen().getId());
        parametrosEntrada.put(3, datMov.getFecha());
        parametrosEntrada.put(4, datMov.getLugarDestino());
        parametrosEntrada.put(5, datMov.getLugarOrigen());
        parametrosEntrada.put(6, datMov.getTipo().toString());
        parametrosEntrada.put(7, datMov.isActivo());
        
        int resultado=DBManager.getInstance().ejecutarProcedimiento("modificar_mov_almacen", parametrosEntrada, null);
        
        if(resultado>0) System.out.println("Se ha realizado la modificación de un movimiento.");
        else System.out.println("Ocurrio un error en la modificacion de un movimiento.");
        return resultado;
    }

    @Override
    public int eliminar(int idMov) {
        Map<Integer, Object> parametrosEntrada=new HashMap<>();
        
        parametrosEntrada.put(1, idMov);
        
        int resultado=DBManager.getInstance().ejecutarProcedimiento("eliminar_mov_almacen", parametrosEntrada, null);
        
        if(resultado>0) System.out.println("Se ha actualizado como eliminado el movimiento.");
        else System.out.println("Ocurrio un error en la eliminación de un movimiento.");
        return resultado;
    }

    @Override
    public MovimientoAlmacen obtenerPorId(int idMov) {
        MovimientoAlmacen datMovAlmacen=null;
        Almacen datAlmacen=null;
        AlmacenDAO daoAlmacen=null;
        Map<Integer, Object>parametrosEntrada=new HashMap<>();
        parametrosEntrada.put(1, idMov);
        rs=DBManager.getInstance().ejecutarProcedimientoLectura("obtener_mov_X_id", parametrosEntrada);
        
        try{
            if(rs.next()){
                datMovAlmacen=new MovimientoAlmacen();
                datAlmacen=new Almacen();
                //Obtenemos los datos del SELECT y los colocamos en datAlmacen
                datMovAlmacen.setIdMovimiento(rs.getInt("idMovAlmacen"));
                
                datAlmacen.setId(rs.getInt("Almacen_idAlmacen"));
                
                datMovAlmacen.setDatAlmacen(datAlmacen);
                datMovAlmacen.setFecha(rs.getDate("fecha"));
                datMovAlmacen.setLugarDestino(rs.getString("lugarDestino"));
                datMovAlmacen.setLugarOrigen(rs.getString("lugarOrigen"));
                //Sintaxis para leer ENUM.
                datMovAlmacen.setTipo(TipoMovimiento.valueOf(rs.getString("tipo")));
                datMovAlmacen.setActivo(rs.getBoolean("activo"));
                
                System.out.println("SE OBTUVO EL MOVIMIENTO CORRECTAMENTE.");
            }
        }catch(SQLException ex){
            System.out.println("ERROR al obtener por ID: "+ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();
        }
        return datMovAlmacen;
    }

    @Override
    public ArrayList<MovimientoAlmacen> listarTodos() {
        Almacen datAlmacen=null;
        ArrayList<MovimientoAlmacen> listaMovimientos=null;
        
        //No hay parametros en el select para llamarlo...
        rs=DBManager.getInstance().ejecutarProcedimientoLectura("mostrar_mov_almacenes", null);
        try{
            while(rs.next()){
                if(listaMovimientos==null){ //Si es la primera iteracion...
                    listaMovimientos=new ArrayList<>();
                }
                MovimientoAlmacen datMov = new MovimientoAlmacen();
                datAlmacen=new Almacen();
                
                datAlmacen.setId(rs.getInt("Almacen_idAlmacen"));
                datMov.setDatAlmacen(datAlmacen);
                
                datMov.setIdMovimiento(rs.getInt("idMovAlmacen"));
                datMov.setFecha(rs.getDate("fecha"));
                datMov.setLugarDestino(rs.getString("lugarDestino"));
                datMov.setLugarOrigen(rs.getString("lugarOrigen"));
                datMov.setTipo(TipoMovimiento.valueOf(rs.getString("tipo")));
                datMov.setActivo(rs.getBoolean("activo"));
                
                listaMovimientos.add(datMov);
            }
            System.out.println("SE LISTO TODOS LOS MOVIMIENTOS CORRECTAMENTE.");
        }catch(SQLException ex){
            System.out.println("ERROR al listar todos los movimientos: "+ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();
        }
        return listaMovimientos; //Ocurrio error
    }
    
    @Override
    public ArrayList<MovimientoAlmacen> listarActivos() {
        Almacen datAlmacen=null;
        AlmacenDAO daoAlmacen=null;
        ArrayList<MovimientoAlmacen> listaMovimientos=null;
        
        //No hay parametros en el select para llamarlo...
        rs=DBManager.getInstance().ejecutarProcedimientoLectura("mostrar_mov_almacenes_activos", null);
        try{
            while(rs.next()){
                if(listaMovimientos==null){ //Si es la primera iteracion...
                    listaMovimientos=new ArrayList<>();
                    daoAlmacen=new AlmacenImpl();
                }
                MovimientoAlmacen datMov=new MovimientoAlmacen();
                //datAlmacen=daoAlmacen.obtenerPorId(rs.getInt("Almacen_IdAlmacen"));
                datAlmacen=new Almacen();
                datAlmacen.setId(rs.getInt("Almacen_IdAlmacen"));
                datMov.setDatAlmacen(datAlmacen);
                
                datMov.setIdMovimiento(rs.getInt("idMovAlmacen"));
                datMov.setFecha(rs.getDate("fecha"));
                datMov.setLugarDestino(rs.getString("lugarDestino"));
                datMov.setLugarOrigen(rs.getString("lugarOrigen"));
                datMov.setTipo(TipoMovimiento.valueOf(rs.getString("tipo")));
                datMov.setActivo(rs.getBoolean("activo"));
                
                listaMovimientos.add(datMov);
            }
            System.out.println("SE LISTO TODOS LOS MOVIMIENTOS ACTIVOS CORRECTAMENTE.");
        }catch(SQLException ex){
            System.out.println("ERROR al listar todos los movimientos activos: "+ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();
        }
        return listaMovimientos; //Ocurrio error
    }
    
    @Override
    public ArrayList<MovimientoAlmacen> listarMovimientosActivosPorAlmacen(int idAlmacen) {
        Almacen datAlmacen=null;
        AlmacenDAO daoAlmacen=null;
        ArrayList<MovimientoAlmacen> listaMovimientos=null;
        
        
        Map<Integer, Object> parametrosEntrada=new HashMap<>();
        
        parametrosEntrada.put(1, idAlmacen);
        
        rs=DBManager.getInstance().ejecutarProcedimientoLectura("mostrar_mov_activo_por_almacen", parametrosEntrada);
        try{
            while(rs.next()){
                if(listaMovimientos==null){ //Si es la primera iteracion...
                    listaMovimientos=new ArrayList<>();
                    daoAlmacen=new AlmacenImpl();
                }
                MovimientoAlmacen datMov = new MovimientoAlmacen();
                
                //datAlmacen=daoAlmacen.obtenerPorId(rs.getInt("Almacen_IdAlmacen"));
                datAlmacen=new Almacen();
                datAlmacen.setId(rs.getInt(2));
                datMov.setDatAlmacen(datAlmacen);
                
                datMov.setIdMovimiento(rs.getInt(1));
                datMov.setFecha(rs.getDate(3));
                datMov.setLugarDestino(rs.getString(4));
                datMov.setLugarOrigen(rs.getString(5));
                datMov.setTipo(TipoMovimiento.valueOf(rs.getString(6)));
                datMov.setActivo(rs.getBoolean(7));
                
                listaMovimientos.add(datMov);
            }
            System.out.println("SE LISTO TODOS LOS MOVIMIENTOS ACTIVOS POR ALMACEN CORRECTAMENTE.");
        }catch(SQLException ex){
            System.out.println("ERROR al listar todos los movimientos activos por almacen: "+ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();
        }
        return listaMovimientos; //Ocurrio error
    }
}
