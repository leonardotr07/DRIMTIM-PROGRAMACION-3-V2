/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.weardrop.almacen.dao;

import java.util.ArrayList;
import pe.edu.pucp.weardrop.almacen.Lote;
import pe.edu.pucp.weardrop.dao.IDAO;

/**
 *
 * @author Leonardo
 */
public interface LoteDAO extends IDAO<Lote>{
    ArrayList<Lote> listarActivos();
    ArrayList<Lote> listarLotesActivosPorAlmacen(int idAlmacen);
}
