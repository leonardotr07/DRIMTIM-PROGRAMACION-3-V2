/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.weardrop.almacen.boi;

import java.util.ArrayList;
import java.util.List;
import pe.edu.pucp.weardrop.almacen.MovimientoAlmacen;
import pe.edu.pucp.weardrop.bo.BusinessObject;

/**
 *
 * @author Leonardo
 */
public interface MovimientoAlmacenBOI extends BusinessObject<MovimientoAlmacen>{
    ArrayList<MovimientoAlmacen> listarActivos();

    public List<MovimientoAlmacen> listarMovimientosActivosPorAlmacen(int idAlmacen);
}
