/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.prendas.mysql;

import java.awt.List;
import pe.edu.pucp.weardrop.prendas.dao.PoloDAO;
import pe.edu.pucp.weardrop.prendas.Polo;
import pe.edu.pucp.weardrop.prendas.Material;
import pe.edu.pucp.weardrop.prendas.TipoManga;
import pe.edu.pucp.weardrop.prendas.TipoCuello;
import pe.edu.pucp.weardrop.config.DBManager;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import pe.edu.pucp.weardrop.prendas.Casaca;
import pe.edu.pucp.weardrop.prendas.TipoCasaca;

public class PoloImpl implements PoloDAO {
    

    private Connection con;
    private CallableStatement cs;
    
    private ResultSet rs; //Para los Selects (Cursor)
    
    
    //Nueva función en DBManager!
    @Override
    public int insertar(Polo datPolo) {
        Map<Integer, Object> parametrosEntrada=new HashMap<>();
        Map<Integer, Object> parametrosSalida=new HashMap<>();
        
        parametrosSalida.put(1, Types.INTEGER);
        parametrosEntrada.put(2, datPolo.getNombre());
        parametrosEntrada.put(3, datPolo.getPrecioUnidad());
        parametrosEntrada.put(4, datPolo.getPrecioMayor());
        parametrosEntrada.put(5, datPolo.getPrecioDocena());
        parametrosEntrada.put(6, datPolo.getAlertaMinStock());
        parametrosEntrada.put(7, datPolo.getColor());
        parametrosEntrada.put(8, datPolo.getMaterial().name());
        parametrosEntrada.put(9, datPolo.getTipoManga().name());
        parametrosEntrada.put(10, datPolo.getEstampado());
        parametrosEntrada.put(11, datPolo.getTipoCuello().name());

        
        DBManager.getInstance().ejecutarProcedimiento("insertar_polo", parametrosEntrada, parametrosSalida);
        //Retornamos el parametro de salida
        datPolo.setIdPrenda((int)parametrosSalida.get(1));
        System.out.println("Se ha realizado el registro de la Prenda Polo");
        return datPolo.getIdPrenda();
    }

    @Override
    public int modificar(Polo datPolo) {
        Map<Integer,Object> parametrosEntrada = new HashMap<>();
        
        parametrosEntrada.put(1, datPolo.getIdPrenda());
        parametrosEntrada.put(2, datPolo.getNombre());
        parametrosEntrada.put(3, datPolo.getPrecioUnidad());
        parametrosEntrada.put(4, datPolo.getPrecioMayor());
        parametrosEntrada.put(5, datPolo.getPrecioDocena());
        parametrosEntrada.put(6, datPolo.getAlertaMinStock());
        parametrosEntrada.put(7, datPolo.getColor());
        parametrosEntrada.put(8, datPolo.getMaterial().name());
        parametrosEntrada.put(9, datPolo.getTipoManga().name());
        parametrosEntrada.put(10, datPolo.getEstampado());
        parametrosEntrada.put(11, datPolo.getTipoCuello().name());
        int resultado=DBManager.getInstance().ejecutarProcedimiento("modificar_polo", parametrosEntrada, null);
        System.out.println("Se ha realizado la modificación de la Prenda Polo");
        return resultado;
    }

    @Override
    public int eliminar(int idPrenda) {
        Map<Integer, Object> parametrosEntrada=new HashMap<>();
        
        parametrosEntrada.put(1, idPrenda);
        
        int resultado=DBManager.getInstance().ejecutarProcedimiento("eliminar_polo", parametrosEntrada, null);
        System.out.println("Se ha desvinculado o eliminado la Polo.");
        return resultado;
    }

    @Override
    public Polo obtenerPorId(int idPrenda) {
        Polo datPolo = null; //No se pudo obtener por ID
        
        Map<Integer, Object> parametrosEntrada=new HashMap<>();
        parametrosEntrada.put(1, idPrenda);
        rs=DBManager.getInstance().ejecutarProcedimientoLectura("obtener_polo_X_id", parametrosEntrada);
        System.out.println("Lectura de Prenda Polo...");
        
        try{
            if(rs.next()){
                datPolo=new Polo();
                //Obtenemos los datos del SELECT y los colocamos en datAlmacen
                datPolo.setIdPrenda(rs.getInt("idPrenda"));
                datPolo.setNombre(rs.getString("nombre"));
                datPolo.setStockPrenda(rs.getInt("stockPrenda"));
                datPolo.setAlertaMinStock(rs.getInt("alertaMinStock"));
                datPolo.setColor(rs.getString("color"));
                datPolo.setMaterial(Material.valueOf(rs.getString("material")));
                datPolo.setTipoManga(TipoManga.valueOf(rs.getString("tipo_manga")));
                datPolo.setEstampado(rs.getString("estampado"));
                datPolo.setTipoCuello(TipoCuello.valueOf(rs.getString("tipo_cuello")));
                datPolo.setPrecioUnidad(rs.getDouble("precioUnidad"));
                datPolo.setPrecioMayor(rs.getDouble("precioMayor"));
                datPolo.setPrecioDocena(rs.getDouble("precioDocena"));
                System.out.println("SE OBTUVO LA PRENDA POLO CORRECTAMENTE.");
            }
        }catch(SQLException ex){
            System.out.println("ERROR al obtener por ID: "+ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();
        }
        return datPolo;
    }

    
    //Falta crear un método de listarTodosLosActivos
    @Override
    public ArrayList<Polo> listarTodos() {
        ArrayList<Polo> listaPolos=null;
        rs=DBManager.getInstance().ejecutarProcedimientoLectura("mostrar_polos", null);
        System.out.println("Lectura de prendas polo...");
        try{
            while(rs.next()){

                if(listaPolos==null) listaPolos=new ArrayList<>();
                Polo datPolo = new Polo();
                //Obtenemos los datos del SELECT y los colocamos en datAlmacen
                datPolo.setIdPrenda(rs.getInt("idPrenda"));
                datPolo.setNombre(rs.getString("nombre"));
                datPolo.setStockPrenda(rs.getInt("stockPrenda"));
                datPolo.setAlertaMinStock(rs.getInt("alertaMinStock"));
                datPolo.setColor(rs.getString("color"));
                datPolo.setMaterial(Material.valueOf(rs.getString("material")));
                datPolo.setTipoManga(TipoManga.valueOf(rs.getString("tipo_manga")));
                datPolo.setEstampado(rs.getString("estampado"));
                datPolo.setTipoCuello(TipoCuello.valueOf(rs.getString("tipo_cuello")));
                datPolo.setActivo(rs.getBoolean("activo"));
                datPolo.setPrecioUnidad(rs.getDouble("precioUnidad"));
                datPolo.setPrecioMayor(rs.getDouble("precioMayor"));
                datPolo.setPrecioDocena(rs.getDouble("precioDocena"));
                listaPolos.add(datPolo);
            }
            System.out.println("SE LISTO TODAS LAS PRENDAS POLO CORRECTAMENTE.");
        }catch(SQLException ex){
            System.out.println("ERROR al listar todas las prendas polo: "+ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();
        }
        return listaPolos;
    } 
    
    @Override
    public ArrayList<Polo> filtrarPolos(
            String nombreLike,
            String colorLike,
            String materialLike,
            String tipoCuelloLike,
            String tipoMangaLike,
            Double precioMin,
            Double precioMax,
            Boolean soloActivos
    ) {
        ArrayList<Polo> lista = null;

        Map<Integer, Object> in = new HashMap<>();
        // Orden EXACTO de parámetros del SP filtrar_polos
        in.put(1, nombreLike);
        in.put(2, colorLike);
        in.put(3, materialLike);
        in.put(4, tipoCuelloLike);
        in.put(5, tipoMangaLike);
        in.put(6, precioMin);
        in.put(7, precioMax);
        in.put(8, (soloActivos == null ? null : (soloActivos ? 1 : 0)));

        rs = DBManager.getInstance().ejecutarProcedimientoLectura("filtrar_polos", in);
        System.out.println("Filtrado LIKE de prendas polo...");

        try {
            while (rs.next()) {
                if (lista == null) {
                    lista = new ArrayList<>();
                }
                Polo p = new Polo();
                p.setIdPrenda(rs.getInt("idPrenda"));
                p.setNombre(rs.getString("nombre"));
                p.setStockPrenda(rs.getInt("stockPrenda"));
                p.setAlertaMinStock(rs.getInt("alertaMinStock"));
                p.setColor(rs.getString("color"));
                p.setMaterial(pe.edu.pucp.weardrop.prendas.Material.valueOf(rs.getString("material")));
                p.setPrecioUnidad(rs.getDouble("precioUnidad"));
                p.setPrecioMayor(rs.getDouble("precioMayor"));
                p.setPrecioDocena(rs.getDouble("precioDocena"));
                p.setActivo(rs.getBoolean("activo"));

                p.setTipoManga(pe.edu.pucp.weardrop.prendas.TipoManga.valueOf(rs.getString("tipo_manga")));
                p.setEstampado(rs.getString("estampado"));
                p.setTipoCuello(pe.edu.pucp.weardrop.prendas.TipoCuello.valueOf(rs.getString("tipo_cuello")));

                lista.add(p);
            }
            System.out.println("SE LISTARON POLOS (filtrar_polos) CORRECTAMENTE.");
        } catch (java.sql.SQLException ex) {
            System.out.println("ERROR al filtrar polos: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }
        return (lista == null) ? new ArrayList<>() : lista;
    }

    
    
}
