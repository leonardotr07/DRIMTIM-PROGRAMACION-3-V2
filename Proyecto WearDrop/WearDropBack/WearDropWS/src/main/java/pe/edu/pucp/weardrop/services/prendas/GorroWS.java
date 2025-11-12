package pe.edu.pucp.weardrop.services.prendas;

import jakarta.jws.*;
import java.util.ArrayList;
import java.util.List;
import pe.edu.pucp.weardrop.prendas.Gorro;
import pe.edu.pucp.weardrop.prendas.boi.GorroBOI;
import pe.edu.pucp.weardrop.prendas.bo.GorroBOImpl;

@WebService(serviceName = "GorroWS")
public class GorroWS {
    private final GorroBOI bo = new GorroBOImpl();

    @WebMethod(operationName = "insertarGorro")
    public int insertarGorro(@WebParam(name="gorro") Gorro gorro){
        try { return bo.insertar(gorro); } catch (Exception e){ System.out.println(e.getMessage()); return 0; }
    }

    @WebMethod(operationName = "modificarGorro")
    public int modificarGorro(@WebParam(name="gorro") Gorro gorro){
        try { return bo.modificar(gorro); } catch (Exception e){ System.out.println(e.getMessage()); return 0; }
    }

    @WebMethod(operationName = "eliminarGorro")
    public int eliminarGorro(@WebParam(name="idGorro") int idGorro){
        try { return bo.eliminar(idGorro); } catch (Exception e){ System.out.println(e.getMessage()); return 0; }
    }

    @WebMethod(operationName = "obtenerGorroPorId")
    public Gorro obtenerGorroPorId(@WebParam(name="idGorro") int idGorro){
        try { return bo.obtenerXId(idGorro); } catch (Exception e){ System.out.println(e.getMessage()); return null; }
    }

    @WebMethod(operationName = "listarGorros")
    public List<Gorro> listarGorros(){
        try { return bo.listarTodos(); } catch (Exception e){ System.out.println(e.getMessage()); return new ArrayList<>(); }
    }

    @WebMethod(operationName = "filtrarGorros")
    public List<Gorro> filtrarGorros(
            @WebParam(name="nombreLike")    String nombreLike,
            @WebParam(name="colorLike")     String colorLike,
            @WebParam(name="materialLike")  String materialLike,
            @WebParam(name="tipoGorraLike") String tipoGorraLike,
            @WebParam(name="tallaAjustable") Boolean tallaAjustable,
            @WebParam(name="impermeable")    Boolean impermeable,
            @WebParam(name="precioMin")     Double precioMin,
            @WebParam(name="precioMax")     Double precioMax,
            @WebParam(name="soloActivos")   Boolean soloActivos){
        try { return bo.filtrarGorros(nombreLike, colorLike, materialLike, tipoGorraLike, tallaAjustable, impermeable, precioMin, precioMax, soloActivos); }
        catch (Exception e){ System.out.println(e.getMessage()); return new ArrayList<>(); }
    }
}

