/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.weardrop.comprastienda.dao;
import java.util.ArrayList;
import pe.edu.pucp.weardrop.comprastienda.Proveedor;
import pe.edu.pucp.weardrop.dao.IDAO;

/**
 *
 * @author matia
 */
public interface ProveedorDAO extends IDAO<Proveedor>{

//´Por el momento esta interfaz solo va a hacer un CRUD de
// los proveedores, pero cuando ya podamos manejar las compras
// se actualizará para tener más funciones :)
    ArrayList<Proveedor> listarActivos();
}
