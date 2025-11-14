/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.comprastienda.mysql;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import pe.edu.pucp.weardrop.comprastienda.CondicionPago;
import pe.edu.pucp.weardrop.comprastienda.dao.CondicionPagoDAO;
import pe.edu.pucp.weardrop.config.DBManager;

/**
 *
 * @author matia
 */
public class CondicionPagoImpl implements 
        CondicionPagoDAO {
    
    
    private ResultSet rs;

    @Override
    public ArrayList<CondicionPago> listarPorIdProveedor(
            int idProveedor) {
        
        ArrayList<CondicionPago> listaCondiciones = new ArrayList<>();
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, idProveedor);
        rs = DBManager.getInstance().ejecutarProcedimientoLectura(
                "mostrar_condiciones_de_Pago_X_idproveedor", 
                parametrosEntrada);
        
        System.out.println("Lectura de Condiciones de pago"
                + "por proveedor ...");
        
        try{
            while(rs.next()){
               
                CondicionPago condicionDepago =
                        new CondicionPago();
                
                condicionDepago.setIdCondicion(
                    rs.getInt("id_condicon"));
                condicionDepago.setDescripcion(
                    rs.getString("descripcion_condicion"));
                condicionDepago.setNumDias(
                    rs.getInt("num_dias_condicion"));
                condicionDepago.setVigente(
                    rs.getBoolean("vigente_condicion"));
                
                listaCondiciones.add(condicionDepago);
            }
            System.out.println("Se listaron todas las "
                    + "condiciones de pago "
                    + " correctamente.");
        }catch(SQLException ex){
            System.out.println(ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();
        }
        return listaCondiciones;
        
        
    }

    @Override
    public ArrayList<CondicionPago> listarPorIdProveedor_Activo(
            int idProveedor) {
        
        ArrayList<CondicionPago> listaCondiciones = new ArrayList<>();
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, idProveedor);
        rs = DBManager.getInstance().ejecutarProcedimientoLectura(
                "mostrar_condiciones_de_Pago_X_idproveedor_activo", 
                parametrosEntrada);
        
        System.out.println("Lectura de Condiciones de pago activas "
                + "por proveedor ...");
        
        try{
            while(rs.next()){
                
                CondicionPago condicionDepago =
                        new CondicionPago();
                
                condicionDepago.setIdCondicion(
                    rs.getInt("id_condicon"));
                condicionDepago.setDescripcion(
                    rs.getString("descripcion_condicion"));
                condicionDepago.setNumDias(
                    rs.getInt("num_dias_condicion"));
                condicionDepago.setVigente(
                    rs.getBoolean("vigente_condicion"));
                
                listaCondiciones.add(condicionDepago);
            }
            System.out.println("Se listaron todas las "
                    + "condiciones de pago "
                    + " correctamente.");
        }catch(SQLException ex){
            System.out.println(ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();
        }
        return listaCondiciones;
        
        
        
       
    }
    
    
    
}
