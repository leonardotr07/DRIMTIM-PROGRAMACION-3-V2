/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.weardrop.descuento.dao;

import java.util.ArrayList;
import pe.edu.pucp.weardrop.clasificacionropa.Vigencia;
import pe.edu.pucp.weardrop.dao.IDAO;
import pe.edu.pucp.weardrop.prendas.Prenda;
import pe.edu.pucp.weardrop.promocionesdescuentos.DescuentoMonto;

/**
 *
 * @author leona
 */
public interface DescuentoMontoDAO extends IDAO<DescuentoMonto>{
    public ArrayList<DescuentoMonto> listarActivos();
    public int insertar_PrendaDescuento(DescuentoMonto descuento, ArrayList<Prenda> prendas, Vigencia vig);
    
    
}
