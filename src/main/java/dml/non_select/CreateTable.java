package dml.non_select;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class CreateTable {
    public static void main(String[] args) throws ClassNotFoundException, SQLException {

        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/XEPDB1", "JAGA", "ALLOWME");
        Statement st = conn.createStatement();
        st.executeUpdate("Create Table Groceries(Grcs_No number(4,0), Grcs_Name varchar2(20), Grcs_Qty varchar2(10), Grcs_Price number(7,2))");
        System.out.println("Groceries Table created.");
        conn.close();
    }
}
