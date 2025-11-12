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
import pe.edu.pucp.weardrop.almacen.dao.AlmacenDAO;
import pe.edu.pucp.weardrop.almacen.dao.LoteDAO;
import pe.edu.pucp.weardrop.almacen.dao.MovimientoAlmacenDAO;
import pe.edu.pucp.weardrop.config.DBManager;

/**
 *
 * @author Leonardo
 */
public class LoteImpl implements LoteDAO{
    //Atributos
    private ResultSet rs;
    
    //Métodos de interfaz

    //Método que sirve para crear los datos de la tabla Lote.
    //No va a tocar Prendas
    @Override
    public int insertar(Lote datLote) {
        Map<Integer, Object> parametrosEntrada=new HashMap<>();
        Map<Integer, Object> parametrosSalida=new HashMap<>();
        
        //Aqui en este método solo se esta registrando el lote.
        parametrosSalida.put(1, Types.INTEGER);
        parametrosEntrada.put(2, datLote.getDatAlmacen().getId());
        parametrosEntrada.put(3, datLote.getDescripcion());

        DBManager.getInstance().ejecutarProcedimiento("insertar_lote", parametrosEntrada, parametrosSalida);
        
        datLote.setIdLote((int)parametrosSalida.get(1)); //Devolvemos el parametro.

        if(datLote.getIdLote()>0) System.out.println("Se ha insertado el lote correctamente.");
        else System.out.println("Ocurrio un error en la insercion del movimiento");
        
        return datLote.getIdLote();
    }

    //Modificar los datos de la tabla Lote.
    //No va a tocar Prendas
    @Override
    public int modificar(Lote datLote) {
        Map<Integer, Object> parametrosEntrada=new HashMap<>();
        
        parametrosEntrada.put(1, datLote.getIdLote());
        parametrosEntrada.put(2, datLote.getDatAlmacen().getId());
        parametrosEntrada.put(3, datLote.isActivo());
        parametrosEntrada.put(4, datLote.getDescripcion());

        DBManager.getInstance().ejecutarProcedimiento("modificar_lote", parametrosEntrada, null);

        if(datLote.getIdLote()>0) System.out.println("Se ha modificado el lote correctamente.");
        else System.out.println("Ocurrio un error en la modificacion del lote");
        
        return datLote.getIdLote();
    }

    @Override
    public int eliminar(int idLote) {
        Map<Integer, Object> parametrosEntrada=new HashMap<>();
        
        parametrosEntrada.put(1, idLote);
        
        int resultado=DBManager.getInstance().ejecutarProcedimiento("eliminar_lote", parametrosEntrada, null);
        
        if(resultado>0) System.out.println("Se ha eliminado el lote correctamente");
        else System.out.println("Ocurrio un error en la eliminacion del lote.");
        
        return resultado;
    }

    //Método para obtener todos los elementos según por ID
    @Override
    public Lote obtenerPorId(int idLote) {
        Lote datLote=null;
        Almacen datAlmacen=null;
        Map<Integer, Object>parametrosEntrada=new HashMap<>();
        parametrosEntrada.put(1, idLote);
        rs=DBManager.getInstance().ejecutarProcedimientoLectura("obtener_lote_X_id", parametrosEntrada);
        
        try{
            if(rs.next()){
                datLote=new Lote();
                datAlmacen=new Almacen();
                datLote.setIdLote(rs.getInt(1));
                datLote.setActivo(rs.getBoolean(3));
                datLote.setDescripcion(rs.getString(4));
                
                datAlmacen.setId(rs.getInt(2));
                
                datLote.setDatAlmacen(datAlmacen);
                
                System.out.println("SE OBTUVO EL LOTE CORRECTAMENTE.");
            }
        }catch(SQLException ex){
            System.out.println("ERROR en el lote al obtener por ID: "+ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();
        }
        return datLote;
    }

    @Override
    public ArrayList<Lote> listarTodos() {
        ArrayList<Lote> listaLotes=null;
        Lote datLote=null;
        Almacen datAlmacen=null;
        AlmacenDAO daoAlmacen=null;
        rs=DBManager.getInstance().ejecutarProcedimientoLectura("mostrar_lotes", null);
        
        try{
            while(rs.next()){
                if(listaLotes==null){ 
                    listaLotes=new ArrayList<>();
                    daoAlmacen=new AlmacenImpl();
                }
                datLote=new Lote();
                datLote.setIdLote(rs.getInt(1));
                datLote.setActivo(rs.getBoolean(3));
                datLote.setDescripcion(rs.getString(4));
                
                datAlmacen.setId(rs.getInt(2));
                
                datLote.setDatAlmacen(datAlmacen);
            }
            System.out.println("SE LISTO TODOS LOS LOTES CORRECTAMENTE.");
        }catch(SQLException ex){
            System.out.println("ERROR al obtener por ID: "+ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();
        }
        return listaLotes;
    }
    
    @Override
    public ArrayList<Lote> listarActivos() {
        ArrayList<Lote> listaLotes=null;
        Lote datLote=null;
        Almacen datAlmacen=null;
        rs=DBManager.getInstance().ejecutarProcedimientoLectura("mostrar_lotes_activos", null);
        
        try{
            while(rs.next()){
                if(listaLotes==null){ 
                    listaLotes=new ArrayList<>();
                    datAlmacen=new Almacen();
                }
                datLote=new Lote();
                datLote.setIdLote(rs.getInt(1));
                datLote.setActivo(rs.getBoolean(3));
                datLote.setDescripcion(rs.getString(4));
                
                datAlmacen.setId(rs.getInt(2));
                datLote.setDatAlmacen(datAlmacen);
                
                listaLotes.add(datLote);
            }
            System.out.println("SE LISTO TODOS LOS LOTES ACTIVOS CORRECTAMENTE.");
        }catch(SQLException ex){
            System.out.println("ERROR al obtener todos los lotes activos: "+ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();
        }
        return listaLotes;
    }

    @Override
    public ArrayList<Lote> listarLotesActivosPorAlmacen(int idAlmacen) {
        ArrayList<Lote> listaLotes=null;
        Lote datLote=null;
        Almacen datAlmacen=null;
        
        Map<Integer, Object>parametrosEntrada=new HashMap<>();
        parametrosEntrada.put(1, idAlmacen);
        
        rs=DBManager.getInstance().ejecutarProcedimientoLectura("mostrar_lote_activo_por_almacen", parametrosEntrada);
        
        try{
            while(rs.next()){
                if(listaLotes==null){ 
                    listaLotes=new ArrayList<>();
                    datAlmacen=new Almacen();
                }
                datLote=new Lote();
                
                datLote.setIdLote(rs.getInt(1));
                datLote.setActivo(rs.getBoolean(3));
                datLote.setDescripcion(rs.getString(4));
                
                datAlmacen.setId(rs.getInt(2));
                datLote.setDatAlmacen(datAlmacen);
                listaLotes.add(datLote);
            }
            System.out.println("SE LISTO TODOS LOS LOTES ACTIVOS POR ALMACEN CORRECTAMENTE.");
        }catch(SQLException ex){
            System.out.println("ERROR al listar lotes activos por el almacen: "+ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();
        }
        return listaLotes;
    }
}
