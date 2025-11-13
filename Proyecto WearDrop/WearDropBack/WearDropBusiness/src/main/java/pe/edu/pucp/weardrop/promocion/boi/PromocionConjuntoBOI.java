/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.weardrop.promocion.boi;

import java.util.ArrayList;
import pe.edu.pucp.weardrop.bo.BusinessObject;
import pe.edu.pucp.weardrop.clasificacionropa.Vigencia;
import pe.edu.pucp.weardrop.prendas.Prenda;
import pe.edu.pucp.weardrop.promocionesdescuentos.PromocionConjunto;

/**
 *
 * @author leona
 */
public interface PromocionConjuntoBOI extends BusinessObject<PromocionConjunto>{
     public ArrayList<PromocionConjunto> listarActivos() throws Exception;
    public int insertar_PrendaYConjunto(PromocionConjunto descuento, ArrayList<Prenda> prendas, Vigencia vig)throws Exception;
}
