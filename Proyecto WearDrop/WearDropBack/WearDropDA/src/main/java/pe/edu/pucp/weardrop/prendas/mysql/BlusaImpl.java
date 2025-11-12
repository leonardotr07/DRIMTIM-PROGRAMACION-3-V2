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
import pe.edu.pucp.weardrop.prendas.Blusa;
import pe.edu.pucp.weardrop.prendas.Casaca;
import pe.edu.pucp.weardrop.prendas.Material;
import pe.edu.pucp.weardrop.prendas.TipoBlusa;
import pe.edu.pucp.weardrop.prendas.TipoCasaca;
import pe.edu.pucp.weardrop.prendas.TipoManga;
import pe.edu.pucp.weardrop.prendas.dao.BlusaDAO;

/**
 *
 * @author valer
 */
public class BlusaImpl implements BlusaDAO{
    
    private Connection con;
    private CallableStatement cs;
    private ResultSet rs; //Para los Selects (Cursor)    
    //Nueva función en DBManager!
    @Override
    public int insertar(Blusa datBlusa) {
        Map<Integer, Object> parametrosEntrada=new HashMap<>();
        Map<Integer, Object> parametrosSalida=new HashMap<>();        
        parametrosSalida.put(1, Types.INTEGER);
        parametrosEntrada.put(2, datBlusa.getNombre());
        parametrosEntrada.put(3, datBlusa.getPrecioUnidad());
        parametrosEntrada.put(4, datBlusa.getPrecioMayor());
        parametrosEntrada.put(5, datBlusa.getPrecioDocena());
        parametrosEntrada.put(6, datBlusa.getAlertaMinStock());
        parametrosEntrada.put(7, datBlusa.getColor());
        parametrosEntrada.put(8, datBlusa.getMaterial().name());
        parametrosEntrada.put(9, datBlusa.getTipoBlusa().name());
        parametrosEntrada.put(10, datBlusa.getTipoManga().name());
        DBManager.getInstance().ejecutarProcedimiento("insertar_blusa", parametrosEntrada, parametrosSalida);
        //Retornamos el parametro de salida
        datBlusa.setIdPrenda((int)parametrosSalida.get(1));
        System.out.println("Se ha realizado el registro de la Prenda Blusa");
        return datBlusa.getIdPrenda();
    }

    @Override
    public int modificar(Blusa datBlusa) {
        Map<Integer,Object> parametrosEntrada = new HashMap<>();        
        parametrosEntrada.put(1, datBlusa.getIdPrenda());
        parametrosEntrada.put(2, datBlusa.getNombre());
        parametrosEntrada.put(3, datBlusa.getPrecioUnidad());
        parametrosEntrada.put(4, datBlusa.getPrecioMayor());
        parametrosEntrada.put(5, datBlusa.getPrecioDocena());
        parametrosEntrada.put(6, datBlusa.getAlertaMinStock());
        parametrosEntrada.put(7, datBlusa.getColor());
        parametrosEntrada.put(8, datBlusa.getMaterial().name());
        parametrosEntrada.put(9, datBlusa.getTipoBlusa().name());
        parametrosEntrada.put(10, datBlusa.getTipoManga().name());
        int resultado=DBManager.getInstance().ejecutarProcedimiento("modificar_blusa", parametrosEntrada, null);
        System.out.println("Se ha realizado la modificación de la Prenda Blusa");
        return resultado;
    }

    @Override
    public int eliminar(int idPrenda) {
        Map<Integer, Object> parametrosEntrada=new HashMap<>();        
        parametrosEntrada.put(1, idPrenda);        
        int resultado=DBManager.getInstance().ejecutarProcedimiento("eliminar_blusa", parametrosEntrada, null);
        System.out.println("Se ha desvinculado o eliminado la blusa.");
        return resultado;
    }

    @Override
    public Blusa obtenerPorId(int idPrenda) {
        Blusa datBlusa = null; //No se pudo obtener por ID        
        Map<Integer, Object> parametrosEntrada=new HashMap<>();
        parametrosEntrada.put(1, idPrenda);
        rs=DBManager.getInstance().ejecutarProcedimientoLectura("obtener_blusa_X_id", parametrosEntrada);
        System.out.println("Lectura de Prenda Blusa...");        
        try{
            if(rs.next()){
                datBlusa=new Blusa();
                //Obtenemos los datos del SELECT y los colocamos en datAlmacen
                datBlusa.setIdPrenda(rs.getInt("idPrenda"));
                datBlusa.setNombre(rs.getString("nombre"));
                datBlusa.setStockPrenda(rs.getInt("stockPrenda"));
                datBlusa.setAlertaMinStock(rs.getInt("alertaMinStock"));
                datBlusa.setColor(rs.getString("color"));
                datBlusa.setMaterial(Material.valueOf(rs.getString("material")));
                datBlusa.setTipoBlusa(TipoBlusa.valueOf(rs.getString("tipo_blusa")));
                datBlusa.setTipoManga(TipoManga.valueOf(rs.getString("tipo_manga")));
                datBlusa.setPrecioUnidad(rs.getDouble("precioUnidad"));
                datBlusa.setPrecioMayor(rs.getDouble("precioMayor"));
                datBlusa.setPrecioDocena(rs.getDouble("precioDocena"));
                System.out.println("SE OBTUVO LA PRENDA BLUSA CORRECTAMENTE.");
            }
        }catch(SQLException ex){
            System.out.println("ERROR al obtener por ID: "+ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();
        }
        return datBlusa;
    }

    
    //Falta crear un método de listarTodosLosActivos
    @Override
    public ArrayList<Blusa> listarTodos() {
        ArrayList<Blusa> listaBlusa=null;
        rs=DBManager.getInstance().ejecutarProcedimientoLectura("mostrar_blusas", null);
        System.out.println("Lectura de prendas blusa...");
        try{
            while(rs.next()){
                if(listaBlusa==null) listaBlusa=new ArrayList<>();
                Blusa datBlusa = new Blusa();
                //Obtenemos los datos del SELECT y los colocamos en datAlmacen
                datBlusa.setIdPrenda(rs.getInt("idPrenda"));
                datBlusa.setNombre(rs.getString("nombre"));
                datBlusa.setStockPrenda(rs.getInt("stockPrenda"));
                datBlusa.setAlertaMinStock(rs.getInt("alertaMinStock"));
                datBlusa.setColor(rs.getString("color"));
                datBlusa.setMaterial(Material.valueOf(rs.getString("material")));
                datBlusa.setTipoBlusa(TipoBlusa.valueOf(rs.getString("tipo_blusa")));
                datBlusa.setTipoManga(TipoManga.valueOf(rs.getString("tipo_manga")));
                datBlusa.setActivo(rs.getBoolean("activo"));    
                
                datBlusa.setPrecioUnidad(rs.getDouble("precioUnidad"));
                datBlusa.setPrecioMayor(rs.getDouble("precioMayor"));
                datBlusa.setPrecioDocena(rs.getDouble("precioDocena"));
                
                listaBlusa.add(datBlusa);
            }
            System.out.println("SE LISTO TODAS LAS PRENDAS BLUSA CORRECTAMENTE.");
        }catch(SQLException ex){
            System.out.println("ERROR al listar todas las prendas blusa: "+ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();
        }
        return listaBlusa;
    }    
    
    @Override
    public ArrayList<Blusa> filtrarBlusas(
            String nombreLike,
            String colorLike,
            String materialLike,
            String tipoBlusaLike,
            String tipoMangaLike,
            Double precioMin,
            Double precioMax,
            Boolean soloActivos
    ) {
        ArrayList<Blusa> lista = null;

        Map<Integer, Object> in = new HashMap<>();
        // Orden EXACTO como en el SP filtrar_blusas
        in.put(1, nombreLike);
        in.put(2, colorLike);
        in.put(3, materialLike);
        in.put(4, tipoBlusaLike);
        in.put(5, tipoMangaLike);
        in.put(6, precioMin);
        in.put(7, precioMax);
        in.put(8, (soloActivos == null ? null : (soloActivos ? 1 : 0)));

        rs = DBManager.getInstance().ejecutarProcedimientoLectura("filtrar_blusas", in);
        System.out.println("Filtrado LIKE de blusas...");

        try {
            while (rs.next()) {
                if (lista == null) {
                    lista = new ArrayList<>();
                }
                Blusa datBlusa = new Blusa();
                datBlusa.setIdPrenda(rs.getInt("idPrenda"));
                datBlusa.setNombre(rs.getString("nombre"));
                datBlusa.setStockPrenda(rs.getInt("stockPrenda"));
                datBlusa.setAlertaMinStock(rs.getInt("alertaMinStock"));
                datBlusa.setColor(rs.getString("color"));
                datBlusa.setMaterial(pe.edu.pucp.weardrop.prendas.Material.valueOf(rs.getString("material")));
                datBlusa.setPrecioUnidad(rs.getDouble("precioUnidad"));
                datBlusa.setPrecioMayor(rs.getDouble("precioMayor"));
                datBlusa.setPrecioDocena(rs.getDouble("precioDocena"));
                datBlusa.setActivo(rs.getBoolean("activo"));

                // Específicos de Blusa
                datBlusa.setTipoBlusa(pe.edu.pucp.weardrop.prendas.TipoBlusa.valueOf(rs.getString("tipo_blusa")));
                datBlusa.setTipoManga(pe.edu.pucp.weardrop.prendas.TipoManga.valueOf(rs.getString("tipo_manga")));

                lista.add(datBlusa);
            }
            System.out.println("SE LISTARON BLUSAS (filtrar_blusas) CORRECTAMENTE.");
        } catch (java.sql.SQLException ex) {
            System.out.println("ERROR al filtrar blusas: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }
        return (lista == null) ? new ArrayList<>() : lista;
    }

}