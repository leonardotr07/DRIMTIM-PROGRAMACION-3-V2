/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.weardrop.comprastienda.boi;

import java.util.ArrayList;
import pe.edu.pucp.weardrop.bo.BusinessObject;
import pe.edu.pucp.weardrop.comprastienda.Proveedor;

/**
 *
 * @author matia
 */
public interface ProveedorBOI extends BusinessObject<Proveedor>{
    
    
    void validar_modificar (Proveedor objeto) throws Exception;
    ArrayList<Proveedor> listarActivos();
    
}
