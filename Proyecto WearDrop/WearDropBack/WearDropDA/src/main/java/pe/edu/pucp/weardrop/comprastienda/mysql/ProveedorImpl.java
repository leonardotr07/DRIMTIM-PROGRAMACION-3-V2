/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.comprastienda.mysql;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import pe.edu.pucp.weardrop.comprastienda.CondicionPago;
import pe.edu.pucp.weardrop.comprastienda.Proveedor;
import pe.edu.pucp.weardrop.comprastienda.dao.ProveedorDAO;
import pe.edu.pucp.weardrop.config.DBManager;

/**
 *
 * @author matia
 */
public class ProveedorImpl implements ProveedorDAO {

    private Connection con;
    private CallableStatement cs;
    private ResultSet rs;

    @Override
    public int insertar(Proveedor objeto) {
        
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        Map<Integer, Object> parametrosSalida = new HashMap<>();
        
        parametrosSalida.put( 1 , Types.INTEGER );
        parametrosEntrada.put( 2 , objeto.getRUC());
        parametrosEntrada.put( 3 , objeto.getNombre() );
        parametrosEntrada.put( 4 , objeto.getTelefono() );
        parametrosEntrada.put( 5 , objeto.getDireccion() );
        
        
        //Posiblemente se necesite agregar un  parámetro más XDD 
        
        DBManager.getInstance().ejecutarProcedimiento(
                "insertar_proveedor", parametrosEntrada, parametrosSalida);
        
        objeto.setIdProveedor((int) parametrosSalida.get(1));
        
        
        
        System.out.println( objeto.getIdProveedor() + " ID ");
        
        for(CondicionPago condicion :
                objeto.getCondiciones()){
            
            parametrosSalida = new HashMap<>();
                parametrosEntrada = new HashMap<>();

                parametrosSalida.put(1,
                        Types.INTEGER);
                parametrosEntrada.put(2,
                        condicion.getDescripcion());
                parametrosEntrada.put(3,
                        condicion.getNumDias());
                parametrosEntrada.put(4,
                        condicion.isVigente());
               parametrosEntrada.put(5,
                        objeto.getIdProveedor());
        
                DBManager.getInstance()
                        .ejecutarProcedimientoTransaccion(
                                "insertar_condicion_de_pago",
                                parametrosEntrada, parametrosSalida);

                condicion.setIdCondicion((int) parametrosSalida.get(1));
                System.out.println("Se ha realizado el "
                        + "registro de la condicion depago.");
            
            
        }
        
        
        
        
        
        if(objeto.getIdProveedor()>0){
            System.out.println("Se ha registrado un proveedor. ");
        }
        else{
            System.out.println("Ocurrio un error al registrar el proveedor. ");
        }
        
        return objeto.getIdProveedor();
    }

    
    
    @Override
    public int modificar(Proveedor objeto) {
        
        
        Map<Integer,Object> parametrosEntrada = new HashMap<>();
        
        parametrosEntrada.put( 1 , objeto.getIdProveedor() );
        parametrosEntrada.put( 2 , objeto.getRUC() );
        parametrosEntrada.put( 3 , objeto.getNombre() );
        parametrosEntrada.put( 4 , objeto.getTelefono() );
        parametrosEntrada.put( 5 , objeto.getDireccion() );
        parametrosEntrada.put( 6 , objeto.isActivo() );
        
        int resultado=DBManager.getInstance().
                ejecutarProcedimiento(
                        "modificar_proveedor",
                        parametrosEntrada, null);
        
        for(CondicionPago condicion :
                objeto.getCondiciones()){
            Map<Integer, Object> parametrosSalida = new HashMap<>();
                parametrosEntrada = new HashMap<>();

                parametrosSalida.put(1,
                        Types.INTEGER);
                parametrosEntrada.put(2,
                        condicion.getDescripcion());
                parametrosEntrada.put(3,
                        condicion.getNumDias());
                parametrosEntrada.put(4,
                        condicion.isVigente());
               parametrosEntrada.put(5,
                        objeto.getIdProveedor());
        
                DBManager.getInstance()
                        .ejecutarProcedimientoTransaccion(
                                "insertar_condicion_de_pago",
                                parametrosEntrada, parametrosSalida);

                condicion.setIdCondicion((int) parametrosSalida.get(1));
                System.out.println("Se ha realizado el "
                        + "registro de la condicion depago.");
            
        }

        
        if(resultado>0) System.out.println("Se ha modificado el proveedor.");
        else System.out.println("Ocurrio un error en la "
                + "modificacion del proveedor.");
        return resultado;

    }
    
    
    
    
    

    @Override
    public int eliminar(int idObjeto) {
        
        Map<Integer, Object> parametrosEntrada=new HashMap<>();
        
        parametrosEntrada.put(1, idObjeto);
        
        int resultado=DBManager.getInstance().
                ejecutarProcedimiento("eliminar_proveedor",
                        parametrosEntrada, null);
        
        if(resultado>0) System.out.println("Se ha eliminado el proveedor.");
        else System.out.println("Ocurrio un error al eliminar el proveedor.");
        
        return resultado;
  
    }
    
   
    
    
    
    @Override
    public Proveedor obtenerPorId(int idObjeto) {
         
        Proveedor proveedor = null;
        Map<Integer, Object> parametrosEntrada=new HashMap<>();
         parametrosEntrada.put(1, idObjeto);
        rs=DBManager.getInstance().ejecutarProcedimientoLectura(
                "obtenerId_proveedor", parametrosEntrada);
        
        try{
            if(rs.next()){
                proveedor = new Proveedor();
                proveedor.setIdProveedor(rs.getInt("idProveedor"));
                proveedor.setRUC(rs.getLong("RUC"));
                proveedor.setNombre(rs.getString("nombre"));
                proveedor.setTelefono(rs.getInt("telefono"));
                proveedor.setDireccion(rs.getString("direccion"));
                proveedor.setActivo(rs.getBoolean("activo"));
                System.out.println(
                        "Se obtuvo un resultado"
                                + " en la busqueda de Proveedor");
            }
            else{
                System.out.println("No se obtuvo ningun"
                        + " resultado en la busqueda de Proveedor");
            }
        }
        catch(SQLException ex){
            System.out.println("ERROR al buscar por ID a un Proveedor: "+
                    ex.getMessage());
        }
        finally{
            DBManager.getInstance().cerrarConexion();
        }
        
        return proveedor;
    }
    
    
    
    

    @Override
    public ArrayList<Proveedor> listarTodos() {
        
        ArrayList<Proveedor> listaProveedores = null;
        rs=DBManager.getInstance().
                ejecutarProcedimientoLectura("mostrar_proveedores", null);
        System.out.println("Lectura de Proveedores...");
        int i = 0;
        try{
            while(rs.next()){
                if(listaProveedores==null) listaProveedores=new ArrayList<>();
                Proveedor datProveedor = new Proveedor();
                
                datProveedor.setIdProveedor(rs.getInt("idProveedor"));
                datProveedor.setRUC(rs.getLong("RUC"));
                datProveedor.setNombre(rs.getString("nombre"));
                datProveedor.setTelefono(rs.getInt("telefono"));
                datProveedor.setDireccion(rs.getString("direccion"));
                datProveedor.setActivo(rs.getBoolean("activo"));
                listaProveedores.add(datProveedor);
                i++;
            }
            if(i>0){
                System.out.println("Se obtuvo por lo menos un resultado en la busqueda de Proveedores");
            }
            else{
                System.out.println("No se obtuvo ningun resultado en la busqueda de Proveedores");
            } 
            System.out.println("Se listaron los proveedores"
                    + " correctamente.");
        }catch(SQLException ex){
            System.out.println("ERROR "
                    + "al listar todos los proveedores: "+ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();
        }
        return listaProveedores;
        
        
    }
    
    
    @Override
    public ArrayList<Proveedor> listarActivos() {
        
        ArrayList<Proveedor> listaProveedores = null;
        rs=DBManager.getInstance().
                ejecutarProcedimientoLectura("mostrar_proveedores_activos", null);
        System.out.println("Lectura de Proveedores...");
        int i = 0;
        try{
            while(rs.next()){
                if(listaProveedores==null) listaProveedores=new ArrayList<>();
                Proveedor datProveedor = new Proveedor();
                
                datProveedor.setIdProveedor(rs.getInt("idProveedor"));
                datProveedor.setRUC(rs.getLong("RUC"));
                datProveedor.setNombre(rs.getString("nombre"));
                datProveedor.setTelefono(rs.getInt("telefono"));
                datProveedor.setDireccion(rs.getString("direccion"));
                datProveedor.setActivo(rs.getBoolean("activo"));
                listaProveedores.add(datProveedor);
                i++;
            }
            if(i>0){
                System.out.println("Se obtuvo por lo menos un resultado en la busqueda de Proveedores");
            }
            else{
                System.out.println("No se obtuvo ningun resultado en la busqueda de Proveedores");
            } 
            System.out.println("Se listaron los proveedores"
                    + " correctamente.");
        }catch(SQLException ex){
            System.out.println("ERROR "
                    + "al listar todos los proveedores: "+ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();
        }
        return listaProveedores;
        
        
    }
    
    
    
}
