/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.prendas.mysql;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import pe.edu.pucp.weardrop.config.DBManager;
import pe.edu.pucp.weardrop.prendas.Material;
import pe.edu.pucp.weardrop.prendas.Pantalon;
import pe.edu.pucp.weardrop.prendas.TipoPantalon;
import pe.edu.pucp.weardrop.prendas.dao.PantalonDAO;

public class PantalonImpl implements PantalonDAO {

    private ResultSet rs; // Para SELECTs (Cursor)

    @Override
    public int insertar(Pantalon datPantalon) {
        Map<Integer, Object> in = new HashMap<>();
        Map<Integer, Object> out = new HashMap<>();

        // parámetro de salida (id)
        out.put(1, Types.INTEGER);

        // parámetros de entrada (respetar orden del SP)
        in.put(2,  datPantalon.getNombre());
        in.put(3,  datPantalon.getPrecioUnidad());
        in.put(4,  datPantalon.getPrecioMayor());
        in.put(5,  datPantalon.getPrecioDocena());
        in.put(6,  datPantalon.getAlertaMinStock());
        in.put(7,  datPantalon.getColor());
        in.put(8,  datPantalon.getMaterial().name());        // enum Material
        in.put(9,  datPantalon.getTipoPantalon().name());    // enum TipoPantalon
        in.put(10, datPantalon.getLargoPierna());     // double
        in.put(11, datPantalon.getCintura());         // double
        in.put(12, datPantalon.isElasticidad());      // boolean

        DBManager.getInstance().ejecutarProcedimiento("insertar_pantalon", in, out);

        datPantalon.setIdPrenda((int) out.get(1));
        System.out.println("Se ha realizado el registro de la Prenda Pantalón");
        return datPantalon.getIdPrenda();
    }

    @Override
    public int modificar(Pantalon datPantalon) {
        Map<Integer, Object> in = new HashMap<>();

        in.put(1,  datPantalon.getIdPrenda());
        in.put(2,  datPantalon.getNombre());
        in.put(3,  datPantalon.getPrecioUnidad());
        in.put(4,  datPantalon.getPrecioMayor());
        in.put(5,  datPantalon.getPrecioDocena());
        in.put(6,  datPantalon.getAlertaMinStock());
        in.put(7,  datPantalon.getColor());
        in.put(8,  datPantalon.getMaterial().name());
        in.put(9,  datPantalon.getTipoPantalon().name());
        in.put(10, datPantalon.getLargoPierna());
        in.put(11, datPantalon.getCintura());
        in.put(12, datPantalon.isElasticidad());

        int res = DBManager.getInstance().ejecutarProcedimiento("modificar_pantalon", in, null);
        System.out.println("Se ha realizado la modificación de la Prenda Pantalón");
        return res;
    }

    @Override
    public int eliminar(int idPrenda) {
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, idPrenda);

        int res = DBManager.getInstance().ejecutarProcedimiento("eliminar_pantalon", in, null);
        System.out.println("Se ha desvinculado o eliminado el pantalón.");
        return res;
    }

    @Override
    public Pantalon obtenerPorId(int idPrenda) {
        Pantalon datPantalon = null;
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, idPrenda);

        rs = DBManager.getInstance().ejecutarProcedimientoLectura("obtener_pantalon_X_id", in);
        System.out.println("Lectura de Prenda Pantalón...");

        try {
            if (rs.next()) {
                datPantalon = new Pantalon();

                datPantalon.setIdPrenda(rs.getInt("idPrenda"));
                datPantalon.setNombre(rs.getString("nombre"));
                datPantalon.setStockPrenda(rs.getInt("stockPrenda"));
                datPantalon.setAlertaMinStock(rs.getInt("alertaMinStock"));
                datPantalon.setColor(rs.getString("color"));
                datPantalon.setMaterial(Material.valueOf(rs.getString("material")));
                datPantalon.setTipoPantalon(TipoPantalon.valueOf(rs.getString("tipo_pantalon")));
                datPantalon.setLargoPierna(rs.getDouble("largo_pierna"));
                datPantalon.setCintura(rs.getDouble("cintura"));
                datPantalon.setElasticidad(rs.getBoolean("elasticidad"));
                
                datPantalon.setPrecioUnidad(rs.getDouble("precioUnidad"));
                datPantalon.setPrecioMayor(rs.getDouble("precioMayor"));
                datPantalon.setPrecioDocena(rs.getDouble("precioDocena"));
                System.out.println("SE OBTUVO LA PRENDA PANTALÓN CORRECTAMENTE.");
            }
        } catch (SQLException ex) {
            System.out.println("ERROR al obtener por ID: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }
        return datPantalon;
    }

    @Override
    public ArrayList<Pantalon> listarTodos() {
        ArrayList<Pantalon> lista = null;

        rs = DBManager.getInstance().ejecutarProcedimientoLectura("mostrar_pantalones", null);
        System.out.println("Lectura de prendas pantalón...");

        try {
            while (rs.next()) {
                if (lista == null) lista = new ArrayList<>();
                Pantalon p = new Pantalon();

                p.setIdPrenda(rs.getInt("idPrenda"));
                p.setNombre(rs.getString("nombre"));
                p.setStockPrenda(rs.getInt("stockPrenda"));
                p.setAlertaMinStock(rs.getInt("alertaMinStock"));
                p.setColor(rs.getString("color"));
                p.setMaterial(Material.valueOf(rs.getString("material")));
                p.setTipoPantalon(TipoPantalon.valueOf(rs.getString("tipo_pantalon")));
                p.setLargoPierna(rs.getDouble("largo_pierna"));
                p.setCintura(rs.getDouble("cintura"));
                p.setElasticidad(rs.getBoolean("elasticidad"));
                p.setActivo(rs.getBoolean("activo"));
                p.setPrecioUnidad(rs.getDouble("precioUnidad"));
                p.setPrecioMayor(rs.getDouble("precioMayor"));
                p.setPrecioDocena(rs.getDouble("precioDocena"));
                lista.add(p);
            }
            System.out.println("SE LISTÓ TODAS LAS PRENDAS PANTALÓN CORRECTAMENTE.");
        } catch (SQLException ex) {
            System.out.println("ERROR al listar todas las prendas pantalón: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }

        return lista;
    }
    
    @Override
    public ArrayList<Pantalon> filtrarPantalones(
            String nombreLike,
            String colorLike,
            String materialLike,
            String tipoPantalonLike,
            Boolean elasticidad,
            Double precioMin,
            Double precioMax,
            Double largoMin,
            Double largoMax,
            Double cinturaMin,
            Double cinturaMax,
            Boolean soloActivos
    ) {
        ArrayList<Pantalon> lista = null;

        Map<Integer, Object> in = new HashMap<>();
        // Orden EXACTO como en el SP filtrar_pantalones
        in.put(1, nombreLike);
        in.put(2, colorLike);
        in.put(3, materialLike);
        in.put(4, tipoPantalonLike);
        in.put(5, (elasticidad == null ? null : (elasticidad ? 1 : 0)));
        in.put(6, precioMin);
        in.put(7, precioMax);
        in.put(8, largoMin);
        in.put(9, largoMax);
        in.put(10, cinturaMin);
        in.put(11, cinturaMax);
        in.put(12, (soloActivos == null ? null : (soloActivos ? 1 : 0)));

        rs = DBManager.getInstance().ejecutarProcedimientoLectura("filtrar_pantalones", in);
        System.out.println("Filtrado LIKE de pantalones...");

        try {
            while (rs.next()) {
                if (lista == null) {
                    lista = new ArrayList<>();
                }
                Pantalon pa = new Pantalon();
                pa.setIdPrenda(rs.getInt("idPrenda"));
                pa.setNombre(rs.getString("nombre"));
                pa.setStockPrenda(rs.getInt("stockPrenda"));
                pa.setAlertaMinStock(rs.getInt("alertaMinStock"));
                pa.setColor(rs.getString("color"));
                pa.setMaterial(pe.edu.pucp.weardrop.prendas.Material.valueOf(rs.getString("material")));
                pa.setPrecioUnidad(rs.getDouble("precioUnidad"));
                pa.setPrecioMayor(rs.getDouble("precioMayor"));
                pa.setPrecioDocena(rs.getDouble("precioDocena"));
                pa.setActivo(rs.getBoolean("activo"));

                pa.setTipoPantalon(pe.edu.pucp.weardrop.prendas.TipoPantalon.valueOf(rs.getString("tipo_pantalon")));
                pa.setLargoPierna(rs.getDouble("largo_pierna"));
                pa.setCintura(rs.getDouble("cintura"));
                pa.setElasticidad(rs.getBoolean("elasticidad"));

                lista.add(pa);
            }
            System.out.println("SE LISTARON PANTALONES (filtrar_pantalones) CORRECTAMENTE.");
        } catch (java.sql.SQLException ex) {
            System.out.println("ERROR al filtrar pantalones: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }
        return (lista == null) ? new ArrayList<>() : lista;
    }
    
}

