/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.weardrop.almacen.dao;

import java.util.ArrayList;
import pe.edu.pucp.weardrop.almacen.MovimientoAlmacen;
import pe.edu.pucp.weardrop.dao.IDAO;

/**
 *
 * @author Leonardo
 */
public interface MovimientoAlmacenDAO extends IDAO<MovimientoAlmacen>{
    ArrayList<MovimientoAlmacen>listarActivos();
    ArrayList<MovimientoAlmacen> listarMovimientosActivosPorAlmacen(int idAlmacen);
}
