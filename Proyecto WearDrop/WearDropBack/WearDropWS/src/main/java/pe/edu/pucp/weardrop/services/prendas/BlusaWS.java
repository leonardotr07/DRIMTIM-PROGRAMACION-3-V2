package pe.edu.pucp.weardrop.services.prendas;

import jakarta.jws.*;
import java.util.ArrayList;
import java.util.List;
import pe.edu.pucp.weardrop.prendas.Blusa;
import pe.edu.pucp.weardrop.prendas.boi.BlusaBOI;
import pe.edu.pucp.weardrop.prendas.bo.BlusaBOImpl;

@WebService(serviceName = "BlusaWS")
public class BlusaWS {
    private final BlusaBOI bo = new BlusaBOImpl();

    @WebMethod(operationName = "insertarBlusa")
    public int insertarBlusa(@WebParam(name="blusa") Blusa blusa){
        try { return bo.insertar(blusa); } catch (Exception e){ System.out.println(e.getMessage()); return 0; }
    }

    @WebMethod(operationName = "modificarBlusa")
    public int modificarBlusa(@WebParam(name="blusa") Blusa blusa){
        try { return bo.modificar(blusa); } catch (Exception e){ System.out.println(e.getMessage()); return 0; }
    }

    @WebMethod(operationName = "eliminarBlusa")
    public int eliminarBlusa(@WebParam(name="idBlusa") int idBlusa){
        try { return bo.eliminar(idBlusa); } catch (Exception e){ System.out.println(e.getMessage()); return 0; }
    }

    @WebMethod(operationName = "obtenerBlusaPorId")
    public Blusa obtenerBlusaPorId(@WebParam(name="idBlusa") int idBlusa){
        try { return bo.obtenerXId(idBlusa); } catch (Exception e){ System.out.println(e.getMessage()); return null; }
    }

    @WebMethod(operationName = "listarBlusas")
    public List<Blusa> listarBlusas(){
        try { return bo.listarTodos(); } catch (Exception e){ System.out.println(e.getMessage()); return new ArrayList<>(); }
    }

    @WebMethod(operationName = "filtrarBlusas")
    public List<Blusa> filtrarBlusas(
            @WebParam(name="nombreLike")   String nombreLike,
            @WebParam(name="colorLike")    String colorLike,
            @WebParam(name="materialLike") String materialLike,
            @WebParam(name="tipoBlusaLike") String tipoBlusaLike,
            @WebParam(name="tipoMangaLike") String tipoMangaLike,
            @WebParam(name="precioMin")    Double precioMin,
            @WebParam(name="precioMax")    Double precioMax,
            @WebParam(name="soloActivos")  Boolean soloActivos){
        try { return bo.filtrarBlusas(nombreLike, colorLike, materialLike, tipoBlusaLike, tipoMangaLike, precioMin, precioMax, soloActivos); }
        catch (Exception e){ System.out.println(e.getMessage()); return new ArrayList<>(); }
    }
}

