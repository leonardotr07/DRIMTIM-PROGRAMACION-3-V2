/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.weardrop.descuento.boi;

import java.util.ArrayList;
import pe.edu.pucp.weardrop.bo.BusinessObject;
import pe.edu.pucp.weardrop.clasificacionropa.Vigencia;
import pe.edu.pucp.weardrop.prendas.Prenda;
import pe.edu.pucp.weardrop.promocionesdescuentos.DescuentoPorcentaje;

/**
 *
 * @author leona
 */
public interface DescuentoPorcentajeBOI extends BusinessObject<DescuentoPorcentaje>{
     public ArrayList<DescuentoPorcentaje> listarActivos()throws Exception ;
    public int insertar_PrendaDescuento(DescuentoPorcentaje descuento, ArrayList<Prenda> prendas, Vigencia vig)throws Exception ;
}
