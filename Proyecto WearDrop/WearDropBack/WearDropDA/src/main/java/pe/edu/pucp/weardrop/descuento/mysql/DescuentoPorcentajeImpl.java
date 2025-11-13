/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.descuento.mysql;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import pe.edu.pucp.weardrop.clasificacionropa.Vigencia;
import pe.edu.pucp.weardrop.config.DBManager;
import pe.edu.pucp.weardrop.dao.IDAO;
import pe.edu.pucp.weardrop.descuento.dao.DescuentoPorcentajeDAO;
import pe.edu.pucp.weardrop.prendas.Prenda;
import pe.edu.pucp.weardrop.promocionesdescuentos.DescuentoPorcentaje;
import pe.edu.pucp.weardrop.promocionesdescuentos.PromocionConjunto;
import pe.edu.pucp.weardrop.vigencia.dao.VigenciaDAO;
import pe.edu.pucp.weardrop.vigencia.mysql.VigenciaImpl;

/**
 *
 * @author leona
 */
public class DescuentoPorcentajeImpl implements DescuentoPorcentajeDAO{
    private ResultSet rs;     

    @Override
    public int insertar(DescuentoPorcentaje datDescuento) {
        Map<Integer, Object> parametrosEntrada=new HashMap<>();
        Map<Integer, Object> parametrosSalida=new HashMap<>();
        
        parametrosSalida.put(1, Types.INTEGER);
        parametrosEntrada.put(2, datDescuento.getNombre());
        parametrosEntrada.put(3, datDescuento.getPorcentaje());
        parametrosEntrada.put(4, datDescuento.getVigencia().getIdVigencia());
        
        DBManager.getInstance().ejecutarProcedimiento("insertar_descuentoporcentaje", parametrosEntrada, parametrosSalida);
        
        //Retornamos el parametro de salida
        datDescuento.setIdDescuento((int)parametrosSalida.get(1));
        
        if(datDescuento.getIdDescuento()>0) System.out.println("Se ha registrado el descuento.");
        else System.out.println("Ocurrio un error en el registro de el descuento.");
        
        return datDescuento.getIdDescuento();  
        
    }

    @Override
    public int modificar(DescuentoPorcentaje objeto) {
        Map<Integer,Object> parametrosEntrada = new HashMap<>();
        
        parametrosEntrada.put(1, objeto.getIdDescuento());
        parametrosEntrada.put(2,objeto.getNombre());
        parametrosEntrada.put(3,objeto.getPorcentaje());
        
        int resultado=DBManager.getInstance().ejecutarProcedimiento("modificar_descuentoporcentaje", parametrosEntrada, null);
        if(resultado>0) System.out.println("Se ha modificado el descuento.");
        else System.out.println("Ocurrio un error en la modificacion del descuento.");
        return resultado;    
    }

    @Override
    public int eliminar(int idObjeto) {
        Map<Integer, Object> parametrosEntrada=new HashMap<>();
        
        parametrosEntrada.put(1, idObjeto);
        
        int resultado=DBManager.getInstance().ejecutarProcedimiento("eliminar_descuentoPorcentaje", parametrosEntrada, null);
        
        if(resultado>0) System.out.println("Se ha eliminado el descuento.");
        else System.out.println("Ocurrio un error al eliminar el descuento.");
        
        return resultado;    }

    @Override
    public DescuentoPorcentaje obtenerPorId(int idObjeto) {
        DescuentoPorcentaje datDescuento = null; //No se pudo obtener por ID
        
        Map<Integer, Object> parametrosEntrada=new HashMap<>();
        parametrosEntrada.put(1, idObjeto);
        rs=DBManager.getInstance().ejecutarProcedimientoLectura("obtener_descuentoporcentaje_X_id", parametrosEntrada);
        
        try{
            //El profe habia puesto un while... Pero no lo veo necesario en este caso...
            //Pero es una opción también y funciona.
            if(rs.next()){
                datDescuento=new DescuentoPorcentaje();
                
                
                datDescuento.setIdDescuento(rs.getInt("idDescuento"));
                datDescuento.setNombre(rs.getString("nombre"));
                datDescuento.setPorcentaje(rs.getInt("porcentaje"));
                Vigencia vig=new Vigencia();
                VigenciaDAO daoVig=new VigenciaImpl();
                vig=daoVig.obtenerPorId(rs.getInt("idVigencia"));                
                datDescuento.setVigencia(vig);
                datDescuento.setActivo(rs.getBoolean("activo"));
                datDescuento.setEsAutomatico(rs.getBoolean("esAutomatico"));
                
                System.out.println("SE OBTUVO EL DESCUENTO CORRECTAMENTE.");
            }
        }catch(SQLException ex){
            System.out.println("ERROR al obtener por ID: "+ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();
        }
        return datDescuento;
    }

    @Override
    public ArrayList<DescuentoPorcentaje> listarTodos() {
        ArrayList<DescuentoPorcentaje> listaDesc=null;
        rs=DBManager.getInstance().ejecutarProcedimientoLectura("mostrar_descuentoporcentaje", null);
        System.out.println("Lectura de descuento...");
            try{
            while(rs.next()){
                if(listaDesc==null) listaDesc=new ArrayList<>();
                DescuentoPorcentaje datDesc = new DescuentoPorcentaje();
                
                datDesc.setIdDescuento(rs.getInt("idDescuento"));
                datDesc.setNombre(rs.getString("nombre"));
                datDesc.setPorcentaje(rs.getFloat("porcentaje"));
                Vigencia vig=new Vigencia();
                VigenciaDAO daoVig=new VigenciaImpl();
                vig=daoVig.obtenerPorId(rs.getInt("idVigencia"));                
                datDesc.setVigencia(vig);
                datDesc.setActivo(rs.getBoolean("activo"));
                datDesc.setEsAutomatico(rs.getBoolean("esAutomatico"));
                listaDesc.add(datDesc);
            }
            System.out.println("SE LISTO TODAS LOS DESCUENTOS CORRECTAMENTE.");
        }catch(SQLException ex){
            System.out.println("ERROR al listar todas los descuentos: "+ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();
        }
        return listaDesc;
    }

    @Override
    public ArrayList<DescuentoPorcentaje> listarActivos() {
        ArrayList<DescuentoPorcentaje> listaDesc=null;
        rs=DBManager.getInstance().ejecutarProcedimientoLectura("mostrar_descuentoporcentaje_activos", null);
        System.out.println("Lectura de descuento...");
            try{
            while(rs.next()){
                if(listaDesc==null) listaDesc=new ArrayList<>();
                DescuentoPorcentaje datDesc = new DescuentoPorcentaje();
                
                datDesc.setIdDescuento(rs.getInt("idDescuento"));
                datDesc.setNombre(rs.getString("nombre"));
                datDesc.setPorcentaje(rs.getFloat("porcentaje"));
                Vigencia vig=new Vigencia();
                VigenciaDAO daoVig=new VigenciaImpl();
                vig=daoVig.obtenerPorId(rs.getInt("idVigencia"));                
                datDesc.setVigencia(vig);
                datDesc.setActivo(rs.getBoolean("activo"));
                datDesc.setEsAutomatico(rs.getBoolean("esAutomatico"));
                listaDesc.add(datDesc);
            }
            System.out.println("SE LISTO TODAS LOS DESCUENTOS CORRECTAMENTE.");
        }catch(SQLException ex){
            System.out.println("ERROR al listar todas los descuentos: "+ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();
        }
        return listaDesc;
    }

    @Override
    public int insertar_PrendaDescuento(DescuentoPorcentaje descuento, ArrayList<Prenda> prendas, Vigencia vig) {
        DescuentoPorcentajeDAO daoDesc;
        daoDesc=new DescuentoPorcentajeImpl();
        VigenciaDAO daoVig;
        daoVig=new VigenciaImpl();
        daoVig.insertar(vig);
                int resultado=-1;

        descuento.setVigencia(vig);
        int idDesc=daoDesc.insertar(descuento);
        for(Prenda pren : prendas){
            Map<Integer, Object> parametrosEntrada=new HashMap<>();
             parametrosEntrada.put(1, pren.getIdPrenda());
             parametrosEntrada.put(2,idDesc);
             resultado=DBManager.getInstance().ejecutarProcedimiento("insertar_prendadescuento", parametrosEntrada, null);
             if(resultado>0) System.out.println("Se ha insertado correctamente.");
             else System.out.println("Ocurrio un error en la inserción.");
        }
        return resultado;
    }
    
}
