/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Dao;

import Model.Categoria;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
//import java.util.logging.Level;
//import java.util.logging.Logger;

/**
 *
 * @author JK Gzenna
 */
public class CategoriaDao {
 
        public static ArrayList<Categoria> listar() {
        
            try {
                String sql="{call sp_listarCategoriaSuperior()}";
                Connection c=Conexion.conectar();
                CallableStatement sentencia=(CallableStatement) c.prepareCall(sql);
                ResultSet resultado=sentencia.executeQuery();
                ArrayList<Categoria> lista=new ArrayList<>();
                    while (resultado.next()) {
                    Categoria cat=new Categoria();
                    cat.setCodigo(resultado.getInt("codigo"));
                    cat.setNombre(resultado.getString("nombre"));
                    lista.add(cat);
                        }   
                        return lista;
            } catch (SQLException ex) {
                return null;
            }
        } 
            public static ArrayList<Categoria> listarSubCategorias(int catSuperior) {
        
            try {
                String sql="{call sp_listarSubCategoria(?)}";
                Connection c=Conexion.conectar();
                CallableStatement sentencia=(CallableStatement) c.prepareCall(sql);
                sentencia.setInt(1, catSuperior);
                ResultSet resultado=sentencia.executeQuery();
                ArrayList<Categoria> lista=new ArrayList<>();
                    while (resultado.next()) {
                    Categoria cat=new Categoria();
                    cat.setCodigo(resultado.getInt("codigo"));
                    cat.setNombre(resultado.getString("nombre"));
                    lista.add(cat);
                        }   
                        return lista;
            } catch (SQLException ex) {
                return null;
            }
        }     
    }
    

