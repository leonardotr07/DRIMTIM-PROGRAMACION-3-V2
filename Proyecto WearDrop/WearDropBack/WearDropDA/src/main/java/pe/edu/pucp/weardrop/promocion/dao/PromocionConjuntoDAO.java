/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.weardrop.promocion.dao;

import java.util.ArrayList;
import pe.edu.pucp.weardrop.clasificacionropa.Vigencia;
import pe.edu.pucp.weardrop.dao.IDAO;
import pe.edu.pucp.weardrop.prendas.Prenda;
import pe.edu.pucp.weardrop.promocionesdescuentos.PromocionConjunto;

/**
 *
 * @author leona
 */
public interface PromocionConjuntoDAO extends IDAO<PromocionConjunto>{
    public ArrayList<PromocionConjunto> listarActivos();
    public int insertarPrendaYConjunto(PromocionConjunto prom, ArrayList<Prenda> prendas,Vigencia vig);
}
