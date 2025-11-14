/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.weardrop.comprastienda.bo;

import java.util.ArrayList;
import pe.edu.pucp.weardrop.comprastienda.CondicionPago;
import pe.edu.pucp.weardrop.comprastienda.Proveedor;
import pe.edu.pucp.weardrop.comprastienda.boi.ProveedorBOI;
import pe.edu.pucp.weardrop.comprastienda.dao.CondicionPagoDAO;
import pe.edu.pucp.weardrop.comprastienda.dao.ProveedorDAO;
import pe.edu.pucp.weardrop.comprastienda.mysql.CondicionPagoImpl;
import pe.edu.pucp.weardrop.comprastienda.mysql.ProveedorImpl;

/**
 *
 * @author matia
 */
public class ProveedorBOImpl implements ProveedorBOI {

    private final ProveedorDAO daoProveedor;
    private final CondicionPagoDAO daoCondicionPago;

    public ProveedorBOImpl() {

        daoProveedor = new ProveedorImpl();
        daoCondicionPago = new CondicionPagoImpl();

    }

    @Override
    public int insertar(Proveedor objeto) throws Exception {

        //nos aseguramos que  al insertar siempre este activo todo
        objeto.setActivo(true);
        ArrayList<CondicionPago> listaCondiciones = objeto.getCondiciones();
        for (CondicionPago condicion : listaCondiciones) {
            condicion.setVigente(true);
        }

        validar(objeto);

        //implementar un método para obtener los  subtotales de la venta 
        return daoProveedor.insertar(objeto);
    }

    @Override
    public int modificar(Proveedor objeto) throws Exception {

        //nos aseguramos que  al insertar siempre este activo todo
        objeto.setActivo(true);
        ArrayList<CondicionPago> listaCondiciones = objeto.getCondiciones();
        for (CondicionPago condicion : listaCondiciones) {
            condicion.setVigente(true);
        }

        validar_modificar(objeto);

        //implementar un método para obtener los  subtotales de la venta 
        return daoProveedor.modificar(objeto);

    }

    @Override
    public int eliminar(int idObjeto) throws Exception {

        return daoProveedor.eliminar(idObjeto);
    }

    @Override
    public Proveedor obtenerXId(int idObjeto)
            throws Exception {

        Proveedor proveedorBuscado
                = daoProveedor.obtenerPorId(idObjeto);
        
          ArrayList<CondicionPago> condiciones
                    = daoCondicionPago.listarPorIdProveedor(proveedorBuscado.getIdProveedor());
            if (condiciones == null) {
                condiciones = new ArrayList<>();
            }
        proveedorBuscado.setCondiciones(condiciones);

        return proveedorBuscado;

    }

    @Override
    public ArrayList<Proveedor> listarTodos() throws Exception {

        ArrayList<Proveedor> listaProveedores
                = daoProveedor.listarTodos();
        for (Proveedor prov : listaProveedores) {

            ArrayList<CondicionPago> condiciones
                    = daoCondicionPago.listarPorIdProveedor(prov.getIdProveedor());
            if (condiciones == null) {
                condiciones = new ArrayList<>();
            }
            prov.setCondiciones(condiciones);

        }

        return listaProveedores;

    }

    @Override
    public void validar(Proveedor objeto) throws Exception {

        Long ruc_val = objeto.getRUC();
        if (ruc_val == null) {
            throw new Exception("En el proveedor:"
                    + " El campo de RUC esta vacío");
        }

        if (objeto.getNombre() == null) {
            throw new Exception("En el proveedor:"
                    + " El campo de nombre esta vacío");
        }
        if (objeto.getNombre().length() > 70) {
            throw new Exception("En el proveedor:"
                    + " El campo nombre sobre paso los"
                    + " 70 caracteres");
        }

        //probablemente cambiar a string
        Integer telefono_val = objeto.getTelefono();
        if (telefono_val == null) {
            throw new Exception("En el proveedor:"
                    + " El campo telefno es nulo.");
        }

        if (objeto.getDireccion() != null
                && objeto.getDireccion().length() > 150) {

            throw new Exception("En el proveedor:"
                    + " El campo direccion sobre paso los"
                    + " 150 caracteres");
        }

        int i = 1;
        
        Integer numDia_val;

        for (CondicionPago condicion_val
                : objeto.getCondiciones()) {

            if (condicion_val.getDescripcion() == null) {
                throw new Exception("En la condicion "
                        + "ingresada número " + i
                        + " : El campo de descripcion"
                        + " es nulo");
            }
            if (condicion_val.getDescripcion().length() > 120) {
                throw new Exception("En la condicion "
                        + "ingresada número " + i
                        + " : El campo de descripcion"
                        + " superó los 120 caracteres");
            }

            numDia_val = condicion_val.getNumDias();

            if (numDia_val == null) {
                throw new Exception("En la condicion "
                        + "ingresada número " + i
                        + " : El campo de numero de dias"
                        + " es nulo");
            }
            i++;
        }
        

    }

    @Override
    public void validar_modificar(Proveedor objeto)
            throws Exception {

        Integer idProvee = objeto.getIdProveedor();
        if (idProvee == null) {
            throw new Exception("El proveedor: "
                    + "El campo del idProveedor esta vacío");
        }

        validar(objeto);

    }

    @Override
    public ArrayList<Proveedor> listarActivos() {
        ArrayList<Proveedor> listaProveedores
                = daoProveedor.listarActivos();
        for (Proveedor prov : listaProveedores) {

            ArrayList<CondicionPago> condiciones
                    = daoCondicionPago.listarPorIdProveedor(prov.getIdProveedor());
            if (condiciones == null) {
                condiciones = new ArrayList<>();
            }
            prov.setCondiciones(condiciones);

        }
        return listaProveedores;
    }

}
