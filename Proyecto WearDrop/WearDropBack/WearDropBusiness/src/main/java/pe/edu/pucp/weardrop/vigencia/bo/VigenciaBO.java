/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.weardrop.vigencia.bo;

import java.util.ArrayList;
import pe.edu.pucp.weardrop.bo.BusinessObject;
import pe.edu.pucp.weardrop.clasificacionropa.Vigencia;

/**
 *
 * @author leona
 */
public interface VigenciaBO extends BusinessObject<Vigencia>{
            public ArrayList<Vigencia> listarActivos() ;

}
