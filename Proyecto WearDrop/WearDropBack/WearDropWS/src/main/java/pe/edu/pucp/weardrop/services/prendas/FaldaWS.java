package pe.edu.pucp.weardrop.services.prendas;

import jakarta.jws.*;
import java.util.ArrayList;
import java.util.List;
import pe.edu.pucp.weardrop.prendas.Falda;
import pe.edu.pucp.weardrop.prendas.boi.FaldaBOI;
import pe.edu.pucp.weardrop.prendas.bo.FaldaBOImpl;

@WebService(serviceName = "FaldaWS")
public class FaldaWS {
    private final FaldaBOI bo = new FaldaBOImpl();

    @WebMethod(operationName = "insertarFalda")
    public int insertarFalda(@WebParam(name="falda") Falda falda){
        try { return bo.insertar(falda); } catch (Exception e){ System.out.println(e.getMessage()); return 0; }
    }

    @WebMethod(operationName = "modificarFalda")
    public int modificarFalda(@WebParam(name="falda") Falda falda){
        try { return bo.modificar(falda); } catch (Exception e){ System.out.println(e.getMessage()); return 0; }
    }

    @WebMethod(operationName = "eliminarFalda")
    public int eliminarFalda(@WebParam(name="idFalda") int idFalda){
        try { return bo.eliminar(idFalda); } catch (Exception e){ System.out.println(e.getMessage()); return 0; }
    }

    @WebMethod(operationName = "obtenerFaldaPorId")
    public Falda obtenerFaldaPorId(@WebParam(name="idFalda") int idFalda){
        try { return bo.obtenerXId(idFalda); } catch (Exception e){ System.out.println(e.getMessage()); return null; }
    }

    @WebMethod(operationName = "listarFaldas")
    public List<Falda> listarFaldas(){
        try { return bo.listarTodos(); } catch (Exception e){ System.out.println(e.getMessage()); return new ArrayList<>(); }
    }

    @WebMethod(operationName = "filtrarFaldas")
    public List<Falda> filtrarFaldas(
            @WebParam(name="nombreLike")    String nombreLike,
            @WebParam(name="colorLike")     String colorLike,
            @WebParam(name="materialLike")  String materialLike,
            @WebParam(name="tipoFaldaLike") String tipoFaldaLike,
            @WebParam(name="conForro")      Boolean conForro,
            @WebParam(name="conVolantes")   Boolean conVolantes,
            @WebParam(name="precioMin")     Double precioMin,
            @WebParam(name="precioMax")     Double precioMax,
            @WebParam(name="largoMin")      Double largoMin,
            @WebParam(name="largoMax")      Double largoMax,
            @WebParam(name="soloActivos")   Boolean soloActivos){
        try { return bo.filtrarFaldas(nombreLike, colorLike, materialLike, tipoFaldaLike, conForro, conVolantes, precioMin, precioMax, largoMin, largoMax, soloActivos); }
        catch (Exception e){ System.out.println(e.getMessage()); return new ArrayList<>(); }
    }
}

