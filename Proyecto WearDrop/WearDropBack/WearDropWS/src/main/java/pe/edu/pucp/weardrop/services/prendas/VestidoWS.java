package pe.edu.pucp.weardrop.services.prendas;

import jakarta.jws.*;
import java.util.ArrayList;
import java.util.List;
import pe.edu.pucp.weardrop.prendas.Vestido;
import pe.edu.pucp.weardrop.prendas.boi.VestidoBOI;
import pe.edu.pucp.weardrop.prendas.bo.VestidoBOImpl;

@WebService(serviceName = "VestidoWS")
public class VestidoWS {
    private final VestidoBOI bo = new VestidoBOImpl();

    @WebMethod(operationName = "insertarVestido")
    public int insertarVestido(@WebParam(name="vestido") Vestido vestido){
        try { return bo.insertar(vestido); } catch (Exception e){ System.out.println(e.getMessage()); return 0; }
    }

    @WebMethod(operationName = "modificarVestido")
    public int modificarVestido(@WebParam(name="vestido") Vestido vestido){
        try { return bo.modificar(vestido); } catch (Exception e){ System.out.println(e.getMessage()); return 0; }
    }

    @WebMethod(operationName = "eliminarVestido")
    public int eliminarVestido(@WebParam(name="idVestido") int idVestido){
        try { return bo.eliminar(idVestido); } catch (Exception e){ System.out.println(e.getMessage()); return 0; }
    }

    @WebMethod(operationName = "obtenerVestidoPorId")
    public Vestido obtenerVestidoPorId(@WebParam(name="idVestido") int idVestido){
        try { return bo.obtenerXId(idVestido); } catch (Exception e){ System.out.println(e.getMessage()); return null; }
    }

    @WebMethod(operationName = "listarVestidos")
    public List<Vestido> listarVestidos(){
        try { return bo.listarTodos(); } catch (Exception e){ System.out.println(e.getMessage()); return new ArrayList<>(); }
    }

    @WebMethod(operationName = "filtrarVestidos")
    public List<Vestido> filtrarVestidos(
            @WebParam(name="nombreLike")     String nombreLike,
            @WebParam(name="colorLike")      String colorLike,
            @WebParam(name="materialLike")   String materialLike,
            @WebParam(name="tipoVestidoLike") String tipoVestidoLike,
            @WebParam(name="tipoMangaLike")   String tipoMangaLike,
            @WebParam(name="precioMin")      Double precioMin,
            @WebParam(name="precioMax")      Double precioMax,
            @WebParam(name="soloActivos")    Boolean soloActivos){
        try { return bo.filtrarVestidos(nombreLike, colorLike, materialLike, tipoVestidoLike, tipoMangaLike, precioMin, precioMax, soloActivos); }
        catch (Exception e){ System.out.println(e.getMessage()); return new ArrayList<>(); }
    }
}

