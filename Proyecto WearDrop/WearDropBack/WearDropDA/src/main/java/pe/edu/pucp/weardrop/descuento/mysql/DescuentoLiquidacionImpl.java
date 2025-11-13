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
import pe.edu.pucp.weardrop.descuento.dao.DescuentoLiquidacionDAO;
import pe.edu.pucp.weardrop.prendas.Prenda;
import pe.edu.pucp.weardrop.promocionesdescuentos.DescuentoLiquidacion;
import pe.edu.pucp.weardrop.promocionesdescuentos.DescuentoMonto;
import pe.edu.pucp.weardrop.vigencia.dao.VigenciaDAO;
import pe.edu.pucp.weardrop.vigencia.mysql.VigenciaImpl;

/**
 *
 * @author leona
 */
public class DescuentoLiquidacionImpl implements DescuentoLiquidacionDAO{
    private ResultSet rs;
    @Override
    public int insertar(DescuentoLiquidacion datDesc) {
        Map<Integer, Object> parametrosEntrada=new HashMap<>();
        Map<Integer, Object> parametrosSalida=new HashMap<>();
        
        parametrosSalida.put(1, Types.INTEGER);
        parametrosEntrada.put(2, datDesc.getNombre());
        parametrosEntrada.put(3, datDesc.getPorcentajeLiquidacion());
        parametrosEntrada.put(4,datDesc.getCondicionStockMin());
        parametrosEntrada.put(5, datDesc.getVigencia().getIdVigencia());
        
        DBManager.getInstance().ejecutarProcedimiento("insertar_descuentoliquidacion", parametrosEntrada, parametrosSalida);
        
        //Retornamos el parametro de salida
        datDesc.setIdDescuento((int)parametrosSalida.get(1));
        
        if(datDesc.getIdDescuento()>0) System.out.println("Se ha registrado el descuento.");
        else System.out.println("Ocurrio un error en el registro de el descuento.");
        
        return datDesc.getIdDescuento();  
    }

    @Override
    public int modificar(DescuentoLiquidacion objeto) {
        Map<Integer,Object> parametrosEntrada = new HashMap<>();
        
        parametrosEntrada.put(1, objeto.getIdDescuento());
        parametrosEntrada.put(2,objeto.getNombre());
        parametrosEntrada.put(3,objeto.getPorcentajeLiquidacion());
        parametrosEntrada.put(4,objeto.getCondicionStockMin());
        
        int resultado=DBManager.getInstance().ejecutarProcedimiento("modificar_descuentoliquidacion", parametrosEntrada, null);
        if(resultado>0) System.out.println("Se ha modificado el descuento.");
        else System.out.println("Ocurrio un error en la modificacion del descuento.");
        return resultado;    
    }

    @Override
    public int eliminar(int idObjeto) {
        Map<Integer, Object> parametrosEntrada=new HashMap<>();
        
        parametrosEntrada.put(1, idObjeto);
        
        int resultado=DBManager.getInstance().ejecutarProcedimiento("eliminar_descuentoliquidacion", parametrosEntrada, null);
        
        if(resultado>0) System.out.println("Se ha eliminado el descuento.");
        else System.out.println("Ocurrio un error al eliminar el descuento.");
        
        return resultado;     
    }

    @Override
    public DescuentoLiquidacion obtenerPorId(int idObjeto) {
        DescuentoLiquidacion datDescuento = null; //No se pudo obtener por ID
        
        Map<Integer, Object> parametrosEntrada=new HashMap<>();
        parametrosEntrada.put(1, idObjeto);
        rs=DBManager.getInstance().ejecutarProcedimientoLectura("obtener_descuentoliquidacion_X_id", parametrosEntrada);
        
        try{
            //El profe habia puesto un while... Pero no lo veo necesario en este caso...
            //Pero es una opción también y funciona.
            if(rs.next()){
                datDescuento=new DescuentoLiquidacion();
                
                
                datDescuento.setIdDescuento(rs.getInt("idDescuento"));
                datDescuento.setNombre(rs.getString("nombre"));
                datDescuento.setCondicionStockMin(rs.getInt("condicionStockMin"));
                datDescuento.setPorcentajeLiquidacion(rs.getFloat("porcentajeLiquidacion"));
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
    public ArrayList<DescuentoLiquidacion> listarTodos() {
        ArrayList<DescuentoLiquidacion> listaDesc=null;
        rs=DBManager.getInstance().ejecutarProcedimientoLectura("mostrar_descuentoliquidacion", null);
        System.out.println("Lectura de descuento...");
            try{
            while(rs.next()){
                if(listaDesc==null) listaDesc=new ArrayList<>();
                DescuentoLiquidacion datDescuento=new DescuentoLiquidacion();
               datDescuento.setIdDescuento(rs.getInt("idDescuento"));
                datDescuento.setNombre(rs.getString("nombre"));
                datDescuento.setCondicionStockMin(rs.getInt("condicionStockMin"));
                datDescuento.setPorcentajeLiquidacion(rs.getFloat("porcentajeLiquidacion"));
                Vigencia vig=new Vigencia();
                VigenciaDAO daoVig=new VigenciaImpl();
                vig=daoVig.obtenerPorId(rs.getInt("idVigencia"));                
                datDescuento.setVigencia(vig);
                datDescuento.setActivo(rs.getBoolean("activo"));
                datDescuento.setEsAutomatico(rs.getBoolean("esAutomatico"));
                listaDesc.add(datDescuento);
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
    public ArrayList<DescuentoLiquidacion> listarActivos() {
        ArrayList<DescuentoLiquidacion> listaDesc=null;
        rs=DBManager.getInstance().ejecutarProcedimientoLectura("mostrar_descuentoliquidacion_activo", null);
        System.out.println("Lectura de descuento...");
            try{
            while(rs.next()){
                if(listaDesc==null) listaDesc=new ArrayList<>();
                DescuentoLiquidacion datDescuento=new DescuentoLiquidacion();
               datDescuento.setIdDescuento(rs.getInt("idDescuento"));
                datDescuento.setNombre(rs.getString("nombre"));
                datDescuento.setCondicionStockMin(rs.getInt("condicionStockMin"));
                datDescuento.setPorcentajeLiquidacion(rs.getFloat("porcentajeLiquidacion"));
                Vigencia vig=new Vigencia();
                VigenciaDAO daoVig=new VigenciaImpl();
                vig=daoVig.obtenerPorId(rs.getInt("idVigencia"));                
                datDescuento.setVigencia(vig);
                datDescuento.setActivo(rs.getBoolean("activo"));
                datDescuento.setEsAutomatico(rs.getBoolean("esAutomatico"));
                listaDesc.add(datDescuento);
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
    public int  insertar_PrendaDescuento(DescuentoLiquidacion descuento, ArrayList<Prenda> prendas, Vigencia vig) {
        DescuentoLiquidacionDAO daoDesc;
        daoDesc=new DescuentoLiquidacionImpl();
        VigenciaDAO daoVig;
        daoVig=new VigenciaImpl();
                int resultado=-1;

        daoVig.insertar(vig);
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
