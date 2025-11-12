/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.prendas.mysql;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import pe.edu.pucp.weardrop.config.DBManager;
import pe.edu.pucp.weardrop.prendas.Casaca;
import pe.edu.pucp.weardrop.prendas.Material;
import pe.edu.pucp.weardrop.prendas.TipoCasaca;
import pe.edu.pucp.weardrop.prendas.dao.CasacaDAO;

/**
 *
 * @author Leonardo
 */
public class CasacaImpl implements CasacaDAO{
    

    private Connection con;
    private CallableStatement cs;
    
    private ResultSet rs; //Para los Selects (Cursor)
    
    
    //Nueva función en DBManager!
    @Override
    public int insertar(Casaca datCasaca) {
        Map<Integer, Object> parametrosEntrada=new HashMap<>();
        Map<Integer, Object> parametrosSalida=new HashMap<>();
        
        parametrosSalida.put(1, Types.INTEGER);
        parametrosEntrada.put(2, datCasaca.getNombre());
        parametrosEntrada.put(3, datCasaca.getPrecioUnidad());
        parametrosEntrada.put(4, datCasaca.getPrecioMayor());
        parametrosEntrada.put(5, datCasaca.getPrecioDocena());
        parametrosEntrada.put(6, datCasaca.getAlertaMinStock());
        parametrosEntrada.put(7, datCasaca.getColor());
        parametrosEntrada.put(8, datCasaca.getMaterial().name());
        parametrosEntrada.put(9, datCasaca.getTipoCasaca().name());
        parametrosEntrada.put(10, datCasaca.isConCapucha());

        
        DBManager.getInstance().ejecutarProcedimiento("insertar_casaca", parametrosEntrada, parametrosSalida);
        //Retornamos el parametro de salida
        datCasaca.setIdPrenda((int)parametrosSalida.get(1));
        System.out.println("Se ha realizado el registro de la Prenda Casaca");
        return datCasaca.getIdPrenda();
    }

    @Override
    public int modificar(Casaca datCasaca) {
        Map<Integer,Object> parametrosEntrada = new HashMap<>();
        
        parametrosEntrada.put(1, datCasaca.getIdPrenda());
        parametrosEntrada.put(2, datCasaca.getNombre());
        parametrosEntrada.put(3, datCasaca.getPrecioUnidad());
        parametrosEntrada.put(4, datCasaca.getPrecioMayor());
        parametrosEntrada.put(5, datCasaca.getPrecioDocena());
        parametrosEntrada.put(6, datCasaca.getAlertaMinStock());
        parametrosEntrada.put(7, datCasaca.getColor());
        parametrosEntrada.put(8, datCasaca.getMaterial().name());
        parametrosEntrada.put(9, datCasaca.getTipoCasaca().name());
        parametrosEntrada.put(10, datCasaca.isConCapucha());
        int resultado=DBManager.getInstance().ejecutarProcedimiento("modificar_casaca", parametrosEntrada, null);
        System.out.println("Se ha realizado la modificación de la Prenda Casaca");
        return resultado;
    }

    @Override
    public int eliminar(int idPrenda) {
        Map<Integer, Object> parametrosEntrada=new HashMap<>();
        
        parametrosEntrada.put(1, idPrenda);
        
        int resultado=DBManager.getInstance().ejecutarProcedimiento("eliminar_casaca", parametrosEntrada, null);
        System.out.println("Se ha desvinculado o eliminado la casaca.");
        return resultado;
    }

    @Override
    public Casaca obtenerPorId(int idPrenda) {
        Casaca datCasaca = null; //No se pudo obtener por ID
        
        Map<Integer, Object> parametrosEntrada=new HashMap<>();
        parametrosEntrada.put(1, idPrenda);
        rs=DBManager.getInstance().ejecutarProcedimientoLectura("obtener_casaca_X_id", parametrosEntrada);
        System.out.println("Lectura de Prenda Falda...");
        
        try{
            if(rs.next()){
                datCasaca=new Casaca();
                //Obtenemos los datos del SELECT y los colocamos en datAlmacen
                datCasaca.setIdPrenda(rs.getInt("idPrenda"));
                datCasaca.setNombre(rs.getString("nombre"));
                datCasaca.setStockPrenda(rs.getInt("stockPrenda"));
                datCasaca.setAlertaMinStock(rs.getInt("alertaMinStock"));
                datCasaca.setColor(rs.getString("color"));
                datCasaca.setMaterial(Material.valueOf(rs.getString("material")));
                datCasaca.setTipoCasaca(TipoCasaca.valueOf(rs.getString("tipo_casaca")));
                datCasaca.setConCapucha(rs.getBoolean("con_capucha"));
            
                datCasaca.setPrecioUnidad(rs.getDouble("precioUnidad"));
                datCasaca.setPrecioMayor(rs.getDouble("precioMayor"));
                datCasaca.setPrecioDocena(rs.getDouble("precioDocena"));
                System.out.println("SE OBTUVO LA PRENDA CASACA CORRECTAMENTE.");
            }
        }catch(SQLException ex){
            System.out.println("ERROR al obtener por ID: "+ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();
        }
        return datCasaca;
    }

    
    //Falta crear un método de listarTodosLosActivos
    @Override
    public ArrayList<Casaca> listarTodos() {
        ArrayList<Casaca> listaCasaca=null;
        rs=DBManager.getInstance().ejecutarProcedimientoLectura("mostrar_casacas", null);
        System.out.println("Lectura de prendas casaca...");
        try{
            while(rs.next()){
                if(listaCasaca==null) listaCasaca=new ArrayList<>();
                Casaca datCasaca = new Casaca();
                //Obtenemos los datos del SELECT y los colocamos en datAlmacen
                datCasaca.setIdPrenda(rs.getInt("idPrenda"));
                datCasaca.setNombre(rs.getString("nombre"));
                datCasaca.setStockPrenda(rs.getInt("stockPrenda"));
                datCasaca.setAlertaMinStock(rs.getInt("alertaMinStock"));
                datCasaca.setColor(rs.getString("color"));
                datCasaca.setMaterial(Material.valueOf(rs.getString("material")));
                datCasaca.setTipoCasaca(TipoCasaca.valueOf(rs.getString("tipo_casaca")));
                datCasaca.setConCapucha(rs.getBoolean("con_capucha"));
                datCasaca.setActivo(rs.getBoolean("activo"));
                datCasaca.setPrecioUnidad(rs.getDouble("precioUnidad"));
                datCasaca.setPrecioMayor(rs.getDouble("precioMayor"));
                datCasaca.setPrecioDocena(rs.getDouble("precioDocena"));
                listaCasaca.add(datCasaca);
            }
            System.out.println("SE LISTO TODAS LAS PRENDAS CASACA CORRECTAMENTE.");
        }catch(SQLException ex){
            System.out.println("ERROR al listar todas las prendas casaca: "+ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();
        }
        return listaCasaca;
    }    
    @Override
    public ArrayList<Casaca> filtrarCasacas(
            String nombreLike,
            String colorLike,
            String materialLike,
            String tipoCasacaLike,
            Boolean conCapucha,
            Double precioMin,
            Double precioMax,
            Boolean soloActivos
    ) {
        ArrayList<Casaca> lista = null;

        Map<Integer, Object> in = new HashMap<>();
        // Orden EXACTO como en el SP filtrar_casacas
        in.put(1, nombreLike);
        in.put(2, colorLike);
        in.put(3, materialLike);
        in.put(4, tipoCasacaLike);
        in.put(5, (conCapucha == null ? null : (conCapucha ? 1 : 0)));
        in.put(6, precioMin);
        in.put(7, precioMax);
        in.put(8, (soloActivos == null ? null : (soloActivos ? 1 : 0)));

        rs = DBManager.getInstance().ejecutarProcedimientoLectura("filtrar_casacas", in);
        System.out.println("Filtrado LIKE de casacas...");

        try {
            while (rs.next()) {
                if (lista == null) {
                    lista = new ArrayList<>();
                }
                Casaca datCasaca = new Casaca();
                datCasaca.setIdPrenda(rs.getInt("idPrenda"));
                datCasaca.setNombre(rs.getString("nombre"));
                datCasaca.setStockPrenda(rs.getInt("stockPrenda"));
                datCasaca.setAlertaMinStock(rs.getInt("alertaMinStock"));
                datCasaca.setColor(rs.getString("color"));
                datCasaca.setMaterial(pe.edu.pucp.weardrop.prendas.Material.valueOf(rs.getString("material")));
                datCasaca.setPrecioUnidad(rs.getDouble("precioUnidad"));
                datCasaca.setPrecioMayor(rs.getDouble("precioMayor"));
                datCasaca.setPrecioDocena(rs.getDouble("precioDocena"));
                datCasaca.setActivo(rs.getBoolean("activo"));

                // Campos específicos de Casaca
                datCasaca.setTipoCasaca(pe.edu.pucp.weardrop.prendas.TipoCasaca.valueOf(rs.getString("tipo_casaca")));
                datCasaca.setConCapucha(rs.getBoolean("con_capucha"));

                lista.add(datCasaca);
            }
            System.out.println("SE LISTARON CASACAS (filtrar_casacas) CORRECTAMENTE.");
        } catch (java.sql.SQLException ex) {
            System.out.println("ERROR al filtrar casacas: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }
        return (lista == null) ? new ArrayList<>() : lista;
    }


}