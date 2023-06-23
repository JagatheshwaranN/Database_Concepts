package ddl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class _01_CreateTable {
    public static void main(String[] args) throws ClassNotFoundException {

        Class.forName("oracle.jdbc.driver.OracleDriver"); // From JDBC 4.2v, this line is optional
        try (Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/XEPDB1", "JAGA", "ALLOWME")) {
            Statement statement = connection.createStatement();
            statement.executeUpdate("Create Table Groceries(Grcs_No number(4,0), Grcs_Name varchar2(20), Grcs_Qty varchar2(10), Grcs_Price number(7,2))");
            System.out.println("Groceries Table created.");
        }catch (SQLException sqlException){
            sqlException.printStackTrace();
        }
    }
}
