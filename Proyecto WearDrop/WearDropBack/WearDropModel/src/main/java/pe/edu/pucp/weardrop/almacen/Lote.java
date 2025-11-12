/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.almacen;

import java.util.ArrayList;
import pe.edu.pucp.weardrop.prendas.Prenda;

/**
 *
 * @author Leonardo
 */
public class Lote {
    //Atributo
    private int idLote;
    private String descripcion;
    private boolean activo; //Si es que la tienda considera este registro o si es cancelado.
    
    //Relaciones
    private final ArrayList<Prenda> prendas;
    private Almacen datAlmacen;
    
    public Lote(){
        this.prendas=new ArrayList<>();
    }
    
    //Constructor con parámetro
    public Lote(int idLote){
        this.idLote=idLote;
        prendas=new ArrayList<>();
    }
    //Constructor Copia para Almacen y MovimientoAlmacen
    public Lote(Lote datLote){
        this.idLote=datLote.idLote;
        this.descripcion=datLote.descripcion;
        this.prendas=new ArrayList<>(datLote.prendas);
        this.datAlmacen=new Almacen(datLote.datAlmacen);
    }
    //El método mostrarLote por ahora solo se limitará a mostrar los ID's 
    //de Almacen y MovAlmacen. (Objetos de la clase de Prueba)
    public void mostrarLote(){
        System.out.println("IdLote: "+this.idLote);
        System.out.println("IdAlmacen: "+this.datAlmacen.getId());
        System.out.println("Activo: "+this.activo);
        if(descripcion!=null) 
            System.out.println("Descripcion: "+this.descripcion);
    }
    //Getters y Setters
    
    //No lo voy a tocar por siacaso
    //Queria respetar encapsulamiento... Pero no se hasta que punto es necesario
    public Almacen getDatAlmacen() {    
        return new Almacen(datAlmacen);
    }

    public void setDatAlmacen(Almacen datAlmacen) {
        if(datAlmacen!=null) this.datAlmacen=new Almacen(datAlmacen);
    }

    public int getIdLote() {
        return idLote;
    }

    public void setIdLote(int idLote) {
        this.idLote = idLote;
    }

    public boolean isActivo() {
        return activo;
    }

    public void setActivo(boolean activo) {
        this.activo = activo;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
    
    
}
