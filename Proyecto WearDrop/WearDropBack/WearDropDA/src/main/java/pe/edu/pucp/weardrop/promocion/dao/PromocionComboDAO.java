/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.weardrop.promocion.dao;

import java.util.ArrayList;
import pe.edu.pucp.weardrop.clasificacionropa.Vigencia;
import pe.edu.pucp.weardrop.dao.IDAO;
import pe.edu.pucp.weardrop.prendas.Prenda;
import pe.edu.pucp.weardrop.promocionesdescuentos.PromocionCombo;

/**
 *
 * @author leona
 */
public interface PromocionComboDAO extends IDAO<PromocionCombo>{
    public ArrayList<PromocionCombo> listarActivos();
        public int insertarPrendaYCombo(PromocionCombo prom, ArrayList<Prenda> prendas,Vigencia vig);

}
