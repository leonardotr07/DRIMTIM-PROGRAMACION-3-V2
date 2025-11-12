package pe.edu.pucp.weardrop.services.prendas;

import jakarta.jws.*;
import java.util.ArrayList;
import java.util.List;
import pe.edu.pucp.weardrop.prendas.Polo;
import pe.edu.pucp.weardrop.prendas.boi.PoloBOI;
import pe.edu.pucp.weardrop.prendas.bo.PoloBOImpl;

@WebService(serviceName = "PoloWS")
public class PoloWS {
    private final PoloBOI bo = new PoloBOImpl();

    @WebMethod(operationName = "insertarPolo")
    public int insertarPolo(@WebParam(name="polo") Polo polo){
        try { return bo.insertar(polo); } catch (Exception e){ System.out.println(e.getMessage()); return 0; }
    }

    @WebMethod(operationName = "modificarPolo")
    public int modificarPolo(@WebParam(name="polo") Polo polo){
        try { return bo.modificar(polo); } catch (Exception e){ System.out.println(e.getMessage()); return 0; }
    }

    @WebMethod(operationName = "eliminarPolo")
    public int eliminarPolo(@WebParam(name="idPolo") int idPolo){
        try { return bo.eliminar(idPolo); } catch (Exception e){ System.out.println(e.getMessage()); return 0; }
    }

    @WebMethod(operationName = "obtenerPoloPorId")
    public Polo obtenerPoloPorId(@WebParam(name="idPolo") int idPolo){
        try { return bo.obtenerXId(idPolo); } catch (Exception e){ System.out.println(e.getMessage()); return null; }
    }

    @WebMethod(operationName = "listarPolos")
    public List<Polo> listarPolos(){
        try { return bo.listarTodos(); } catch (Exception e){ System.out.println(e.getMessage()); return new ArrayList<>(); }
    }

    @WebMethod(operationName = "filtrarPolos")
    public List<Polo> filtrarPolos(
            @WebParam(name="nombreLike")    String nombreLike,
            @WebParam(name="colorLike")     String colorLike,
            @WebParam(name="materialLike")  String materialLike,
            @WebParam(name="tipoCuelloLike") String tipoCuelloLike,
            @WebParam(name="tipoMangaLike")  String tipoMangaLike,
            @WebParam(name="precioMin")     Double precioMin,
            @WebParam(name="precioMax")     Double precioMax,
            @WebParam(name="soloActivos")   Boolean soloActivos){
        try { return bo.filtrarPolos(nombreLike, colorLike, materialLike, tipoCuelloLike, tipoMangaLike, precioMin, precioMax, soloActivos); }
        catch (Exception e){ System.out.println(e.getMessage()); return new ArrayList<>(); }
    }
}

