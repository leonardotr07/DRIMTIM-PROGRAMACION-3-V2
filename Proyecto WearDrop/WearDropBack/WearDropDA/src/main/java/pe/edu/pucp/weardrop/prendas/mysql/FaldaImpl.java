/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.prendas.mysql;

import pe.edu.pucp.weardrop.prendas.dao.FaldaDAO;
import pe.edu.pucp.weardrop.prendas.Falda;
import pe.edu.pucp.weardrop.config.DBManager;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import pe.edu.pucp.weardrop.almacen.Almacen;
import pe.edu.pucp.weardrop.almacen.dao.AlmacenDAO;
import pe.edu.pucp.weardrop.prendas.Material;
import pe.edu.pucp.weardrop.prendas.TipoFalda;

public class FaldaImpl implements FaldaDAO {
    

    private Connection con;
    private CallableStatement cs;
    
    private ResultSet rs; //Para los Selects (Cursor)
    
    
    //Nueva función en DBManager!
    @Override
    public int insertar(Falda datFalda) {
        Map<Integer, Object> parametrosEntrada=new HashMap<>();
        Map<Integer, Object> parametrosSalida=new HashMap<>();
        
        parametrosSalida.put(1, Types.INTEGER);
        parametrosEntrada.put(2, datFalda.getNombre());
        parametrosEntrada.put(3, datFalda.getPrecioUnidad());
        parametrosEntrada.put(4, datFalda.getPrecioMayor());
        parametrosEntrada.put(5, datFalda.getPrecioDocena());
        parametrosEntrada.put(6, datFalda.getAlertaMinStock());
        parametrosEntrada.put(7, datFalda.getColor());
        parametrosEntrada.put(8, datFalda.getMaterial().name());
        parametrosEntrada.put(9, datFalda.getTipoFalda().name());
        parametrosEntrada.put(10, datFalda.getLargo());
        parametrosEntrada.put(11, datFalda.isConForro());
        parametrosEntrada.put(12, datFalda.isConVolantes());

        
        DBManager.getInstance().ejecutarProcedimiento("insertar_falda", parametrosEntrada, parametrosSalida);
        //Retornamos el parametro de salida
        datFalda.setIdPrenda((int)parametrosSalida.get(1));
        System.out.println("Se ha realizado el registro de la Prenda Falda");
        return datFalda.getIdPrenda();
    }

    @Override
    public int modificar(Falda datFalda) {
        Map<Integer,Object> parametrosEntrada = new HashMap<>();
        
        parametrosEntrada.put(1, datFalda.getIdPrenda());
        parametrosEntrada.put(2, datFalda.getNombre());
        parametrosEntrada.put(3, datFalda.getPrecioUnidad());
        parametrosEntrada.put(4, datFalda.getPrecioMayor());
        parametrosEntrada.put(5, datFalda.getPrecioDocena());
        parametrosEntrada.put(6, datFalda.getAlertaMinStock());
        parametrosEntrada.put(7, datFalda.getColor());
        parametrosEntrada.put(8, datFalda.getMaterial().name());
        parametrosEntrada.put(9, datFalda.getTipoFalda().name());
        parametrosEntrada.put(10, datFalda.getLargo());
        parametrosEntrada.put(11, datFalda.isConForro());
        parametrosEntrada.put(12, datFalda.isConVolantes());
        int resultado=DBManager.getInstance().ejecutarProcedimiento("modificar_falda", parametrosEntrada, null);
        System.out.println("Se ha realizado la modificación de la Prenda Falda");
        return resultado;
    }

    @Override
    public int eliminar(int idPrenda) {
        Map<Integer, Object> parametrosEntrada=new HashMap<>();
        
        parametrosEntrada.put(1, idPrenda);
        
        int resultado=DBManager.getInstance().ejecutarProcedimiento("eliminar_falda", parametrosEntrada, null);
        System.out.println("Se ha desvinculado o eliminado la falda.");
        return resultado;
    }

    @Override
    public Falda obtenerPorId(int idPrenda) {
        Falda datFalda = null; //No se pudo obtener por ID
        
        Map<Integer, Object> parametrosEntrada=new HashMap<>();
        parametrosEntrada.put(1, idPrenda);
        rs=DBManager.getInstance().ejecutarProcedimientoLectura("obtener_falda_X_id", parametrosEntrada);
        System.out.println("Lectura de Prenda Falda...");
        
        try{
            if(rs.next()){
                datFalda=new Falda();
                //Obtenemos los datos del SELECT y los colocamos en datAlmacen
                datFalda.setIdPrenda(rs.getInt("idPrenda"));
                datFalda.setNombre(rs.getString("nombre"));
                datFalda.setStockPrenda(rs.getInt("stockPrenda"));
                datFalda.setAlertaMinStock(rs.getInt("alertaMinStock"));
                datFalda.setColor(rs.getString("color"));
                datFalda.setMaterial(Material.valueOf(rs.getString("material")));
                datFalda.setTipoFalda(TipoFalda.valueOf(rs.getString("tipo_falda")));
                datFalda.setLargo(rs.getInt("largo"));
                datFalda.setConForro(rs.getBoolean("con_forro"));
                datFalda.setConVolantes(rs.getBoolean("con_volantes"));
              
               datFalda.setPrecioUnidad(rs.getDouble("precioUnidad"));
                datFalda.setPrecioMayor(rs.getDouble("precioMayor"));
                datFalda.setPrecioDocena(rs.getDouble("precioDocena"));
                System.out.println("SE OBTUVO LA PRENDA FALDA CORRECTAMENTE.");
            }
        }catch(SQLException ex){
            System.out.println("ERROR al obtener por ID: "+ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();
        }
        return datFalda;
    }

    
    //Falta crear un método de listarTodosLosActivos
    @Override
    public ArrayList<Falda> listarTodos() {
        ArrayList<Falda> listaFaldas=null;
        rs=DBManager.getInstance().ejecutarProcedimientoLectura("mostrar_faldas", null);
        System.out.println("Lectura de prendas falda...");
        try{
            while(rs.next()){
                if(listaFaldas==null) listaFaldas=new ArrayList<>();
                Falda datFalda = new Falda();
                //Obtenemos los datos del SELECT y los colocamos en datAlmacen
                datFalda.setIdPrenda(rs.getInt("idPrenda"));
                datFalda.setNombre(rs.getString("nombre"));
                datFalda.setStockPrenda(rs.getInt("stockPrenda"));
                datFalda.setAlertaMinStock(rs.getInt("alertaMinStock"));
                datFalda.setColor(rs.getString("color"));
                datFalda.setMaterial(Material.valueOf(rs.getString("material")));
                datFalda.setTipoFalda(TipoFalda.valueOf(rs.getString("tipo_falda")));
                datFalda.setLargo(rs.getInt("largo"));
                datFalda.setConForro(rs.getBoolean("con_forro"));
                datFalda.setConVolantes(rs.getBoolean("con_volantes"));
                datFalda.setActivo(rs.getBoolean("activo"));
                datFalda.setPrecioUnidad(rs.getDouble("precioUnidad"));
                datFalda.setPrecioMayor(rs.getDouble("precioMayor"));
                datFalda.setPrecioDocena(rs.getDouble("precioDocena"));
                listaFaldas.add(datFalda);
            }
            System.out.println("SE LISTO TODAS LAS PRENDAS FALDA CORRECTAMENTE.");
        }catch(SQLException ex){
            System.out.println("ERROR al listar todas las prendas falda: "+ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();
        }
        return listaFaldas;
    }    
    
    @Override
    public ArrayList<Falda> filtrarFaldas(
            String nombreLike,
            String colorLike,
            String materialLike,
            String tipoFaldaLike,
            Boolean conForro,
            Boolean conVolantes,
            Double precioMin,
            Double precioMax,
            Double largoMin,
            Double largoMax,
            Boolean soloActivos
    ) {
        ArrayList<Falda> lista = null;

        Map<Integer, Object> in = new HashMap<>();
        // Orden EXACTO como en el SP filtrar_faldas
        in.put(1, nombreLike);
        in.put(2, colorLike);
        in.put(3, materialLike);
        in.put(4, tipoFaldaLike);
        in.put(5, (conForro == null ? null : (conForro ? 1 : 0)));
        in.put(6, (conVolantes == null ? null : (conVolantes ? 1 : 0)));
        in.put(7, precioMin);
        in.put(8, precioMax);
        in.put(9, largoMin);
        in.put(10, largoMax);
        in.put(11, (soloActivos == null ? null : (soloActivos ? 1 : 0)));

        rs = DBManager.getInstance().ejecutarProcedimientoLectura("filtrar_faldas", in);
        System.out.println("Filtrado LIKE de faldas...");

        try {
            while (rs.next()) {
                if (lista == null) {
                    lista = new ArrayList<>();
                }
                Falda f = new Falda();
                f.setIdPrenda(rs.getInt("idPrenda"));
                f.setNombre(rs.getString("nombre"));
                f.setStockPrenda(rs.getInt("stockPrenda"));
                f.setAlertaMinStock(rs.getInt("alertaMinStock"));
                f.setColor(rs.getString("color"));
                f.setMaterial(pe.edu.pucp.weardrop.prendas.Material.valueOf(rs.getString("material")));
                f.setPrecioUnidad(rs.getDouble("precioUnidad"));
                f.setPrecioMayor(rs.getDouble("precioMayor"));
                f.setPrecioDocena(rs.getDouble("precioDocena"));
                f.setActivo(rs.getBoolean("activo"));

                // Específicos de Falda
                f.setTipoFalda(pe.edu.pucp.weardrop.prendas.TipoFalda.valueOf(rs.getString("tipo_falda")));
                f.setLargo(rs.getDouble("largo"));
                f.setConForro(rs.getBoolean("con_forro"));
                f.setConVolantes(rs.getBoolean("con_volantes"));

                lista.add(f);
            }
            System.out.println("SE LISTARON FALDAS (filtrar_faldas) CORRECTAMENTE.");
        } catch (java.sql.SQLException ex) {
            System.out.println("ERROR al filtrar faldas: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }
        return (lista == null) ? new ArrayList<>() : lista;
    }

    
}

