/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.weardrop.almacen.boi;

import java.util.ArrayList;
import pe.edu.pucp.weardrop.almacen.MovimientoAlmacen;
import pe.edu.pucp.weardrop.almacen.MovimientoAlmacen_X_Lote;
import pe.edu.pucp.weardrop.bo.BusinessObject;

/**
 *
 * @author Leonardo
 */
public interface MovimientoAlmacen_X_Lote_BOI extends BusinessObject<MovimientoAlmacen_X_Lote>{
    ArrayList<MovimientoAlmacen_X_Lote> listarActivos();
    ArrayList<MovimientoAlmacen_X_Lote> listarMovXLoteActivosPorAlmacen(int idAlmacen);
}
