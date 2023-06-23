package ddl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class _02_AlterTable {

    public static void main(String[] args) throws ClassNotFoundException {

        /*
            Alter Table has 2 options as below,

            1. Modify existing column details
               Example - Alter Table Groceries Modify (Grcs_No number(5,0), Grcs_Name varchar2(25), Grcs_Qty varchar2(5), Grcs_Price number(7,2));

            2. Add new column
               Example - Alter Table Groceries Add (Grcs_No number(5,0), Grcs_Name varchar2(25), Grcs_Qty varchar2(5), Grcs_Price number(7,2), Grcs_Type varchar2(20));
        */

        Class.forName("oracle.jdbc.driver.OracleDriver");
        try(Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/XEPDB1", "JAGA", "ALLOWME")){
            Statement statement = connection.createStatement();
            statement.executeUpdate("Alter Table Groceries Modify (Grcs_No number(5,0), Grcs_Name varchar2(25), Grcs_Qty varchar2(5), Grcs_Price number(7,2))");
            System.out.println("Groceries Table altered.");
        } catch (SQLException sqlException) {
            throw new RuntimeException(sqlException);
        }

    }
}
