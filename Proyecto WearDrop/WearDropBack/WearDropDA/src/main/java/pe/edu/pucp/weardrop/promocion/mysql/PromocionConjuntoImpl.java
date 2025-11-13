/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.promocion.mysql;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import pe.edu.pucp.weardrop.clasificacionropa.Vigencia;
import pe.edu.pucp.weardrop.config.DBManager;
import pe.edu.pucp.weardrop.prendas.Material;
import pe.edu.pucp.weardrop.prendas.Polo;
import pe.edu.pucp.weardrop.prendas.Prenda;
import pe.edu.pucp.weardrop.prendas.TipoCuello;
import pe.edu.pucp.weardrop.prendas.TipoManga;
import pe.edu.pucp.weardrop.promocion.dao.PromocionConjuntoDAO;
import pe.edu.pucp.weardrop.promocionesdescuentos.PromocionCombo;
import pe.edu.pucp.weardrop.promocionesdescuentos.PromocionConjunto;
import pe.edu.pucp.weardrop.vigencia.dao.VigenciaDAO;
import pe.edu.pucp.weardrop.vigencia.mysql.VigenciaImpl;

/**
 *
 * @author leona
 */
public class PromocionConjuntoImpl implements PromocionConjuntoDAO{

    
    private Connection con;
    private CallableStatement cs;
    
    private ResultSet rs; 

    @Override
    public int insertar(PromocionConjunto datPromocionConjunto) {
        Map<Integer, Object> parametrosEntrada=new HashMap<>();
        Map<Integer, Object> parametrosSalida=new HashMap<>();
        
        parametrosSalida.put(1, Types.INTEGER);
        parametrosEntrada.put(2, datPromocionConjunto.getNombre());
        parametrosEntrada.put(3, datPromocionConjunto.getPorcentajePromocion());
        parametrosEntrada.put(4, datPromocionConjunto.getVigencia().getIdVigencia());
        
        DBManager.getInstance().ejecutarProcedimiento("insertar_promocionconjunto", parametrosEntrada, parametrosSalida);
        
        //Retornamos el parametro de salida
        datPromocionConjunto.setIdPromocion((int)parametrosSalida.get(1));
        
        if(datPromocionConjunto.getIdPromocion()>0) System.out.println("Se ha registrado la promocion.");
        else System.out.println("Ocurrio un error en el registro de la  promocion.");
        
        return datPromocionConjunto.getIdPromocion();  
    }
    
    @Override
    public int modificar(PromocionConjunto datPromocion) {
         Map<Integer,Object> parametrosEntrada = new HashMap<>();
        
        parametrosEntrada.put(1, datPromocion.getIdPromocion());
        parametrosEntrada.put(2, datPromocion.getNombre());
        parametrosEntrada.put(3, datPromocion.getPorcentajePromocion());
        parametrosEntrada.put(4, datPromocion.getVigencia().getIdVigencia());  
        int resultado=DBManager.getInstance().ejecutarProcedimiento("modificar_promocionconjunto", parametrosEntrada, null);
        if(resultado>0) System.out.println("Se ha modificado la promocion.");
        else System.out.println("Ocurrio un error en la modificacion de la promocion.");
        return resultado;
    }

    @Override
    public int eliminar(int idObjeto) {
        Map<Integer, Object> parametrosEntrada=new HashMap<>();
        
        parametrosEntrada.put(1, idObjeto);
        
        int resultado=DBManager.getInstance().ejecutarProcedimiento("eliminar_promocionconjunto", parametrosEntrada, null);
        
        if(resultado>0) System.out.println("Se ha eliminado la promocion.");
        else System.out.println("Ocurrio un error al eliminar la promocion.");
        
        return resultado;
    }

    @Override
    public PromocionConjunto obtenerPorId(int idObjeto) {
        PromocionConjunto datProm = null; //No se pudo obtener por ID
        
        Map<Integer, Object> parametrosEntrada=new HashMap<>();
        parametrosEntrada.put(1, idObjeto);
        rs=DBManager.getInstance().ejecutarProcedimientoLectura("obtener_promocionconjunto_X_id", parametrosEntrada);
        
        try{
            //El profe habia puesto un while... Pero no lo veo necesario en este caso...
            //Pero es una opción también y funciona.
            if(rs.next()){
                datProm=new PromocionConjunto();
                
                
                datProm.setIdPromocion(rs.getInt("idPromocion"));
                datProm.setNombre(rs.getString("nombre"));
                datProm.setPorcentajePromocion(rs.getInt("porcentajePromocion"));
                Vigencia vig=new Vigencia();
                VigenciaDAO daoVig=new VigenciaImpl();
                vig=daoVig.obtenerPorId(rs.getInt("idVigencia"));                
                datProm.setVigencia(vig);
                datProm.setActivo(rs.getBoolean("activo"));
                datProm.setEsAutomatico(rs.getBoolean("esAutomatico"));
                
                System.out.println("SE OBTUVO LA PROMOCION CORRECTAMENTE.");
            }
        }catch(SQLException ex){
            System.out.println("ERROR al obtener por ID: "+ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();
        }
        return datProm;
    }

    @Override
    public ArrayList<PromocionConjunto> listarTodos() {
        
        ArrayList<PromocionConjunto> listaProm=null;
        rs=DBManager.getInstance().ejecutarProcedimientoLectura("mostrar_promocionesconjunto", null);
        System.out.println("Lectura de promocion...");
            try{
            while(rs.next()){
                if(listaProm==null) listaProm=new ArrayList<>();
                PromocionConjunto datProm = new PromocionConjunto();
                
                datProm.setIdPromocion(rs.getInt("idPromocion"));
                datProm.setNombre(rs.getString("nombre"));
                datProm.setPorcentajePromocion(rs.getFloat("porcentajePromocion"));
                Vigencia vig=new Vigencia();
                VigenciaDAO daoVig=new VigenciaImpl();
                vig=daoVig.obtenerPorId(rs.getInt("idVigencia"));                
                datProm.setVigencia(vig);
                datProm.setActivo(rs.getBoolean("activo"));
                datProm.setEsAutomatico(rs.getBoolean("esAutomatico"));
                listaProm.add(datProm);
            }
            System.out.println("SE LISTO TODAS LAS PROMOCIONES CORRECTAMENTE.");
        }catch(SQLException ex){
            System.out.println("ERROR al listar todas las promociones: "+ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();
        }
        return listaProm;
    }

    @Override
    public ArrayList<PromocionConjunto> listarActivos() {
        ArrayList<PromocionConjunto> listaProm=null;
        rs=DBManager.getInstance().ejecutarProcedimientoLectura("mostrar_promocionesconjunto_activo", null);
        System.out.println("Lectura de promocion...");
            try{
            while(rs.next()){
                if(listaProm==null) listaProm=new ArrayList<>();
                PromocionConjunto datProm = new PromocionConjunto();
                
                datProm.setIdPromocion(rs.getInt("idPromocion"));
                datProm.setNombre(rs.getString("nombre"));
                datProm.setPorcentajePromocion(rs.getFloat("porcentajePromocion"));
                Vigencia vig=new Vigencia();
                VigenciaDAO daoVig=new VigenciaImpl();
                vig=daoVig.obtenerPorId(rs.getInt("idVigencia"));                
                datProm.setVigencia(vig);
                datProm.setActivo(rs.getBoolean("activo"));
                datProm.setEsAutomatico(rs.getBoolean("esAutomatico"));
                listaProm.add(datProm);
            }
            System.out.println("SE LISTO TODAS LAS PROMOCIONES CORRECTAMENTE.");
        }catch(SQLException ex){
            System.out.println("ERROR al listar todas las promociones: "+ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();
        }
        return listaProm;
    }

    @Override
    public int insertarPrendaYConjunto(PromocionConjunto prom, ArrayList<Prenda> prendas,Vigencia vig) {
        PromocionConjuntoDAO daoProm;
        daoProm=new PromocionConjuntoImpl(); 
        VigenciaDAO daoVig;
        daoVig=new VigenciaImpl();
                int resultado=-1;

        daoVig.insertar(vig);
        prom.setVigencia(vig);
        int idProm=daoProm.insertar(prom);
        for(Prenda pren : prendas){
             Map<Integer, Object> parametrosEntrada=new HashMap<>();
             parametrosEntrada.put(1, pren.getIdPrenda());
             parametrosEntrada.put(2,idProm);
              resultado=DBManager.getInstance().ejecutarProcedimiento("insertar_prendapromocion", parametrosEntrada, null);
             if(resultado>0) System.out.println("Se ha insertado correctamente.");
             else System.out.println("Ocurrio un error en la inserción.");
        }
        return resultado;
    }
}

    

