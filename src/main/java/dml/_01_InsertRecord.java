package dml;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class _01_InsertRecord {

    public static void main(String[] args) throws ClassNotFoundException {

        Class.forName("oracle.jdbc.driver.OracleDriver");
        try(Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/XEPDB1","JAGA","ALLOWME")){
            Statement statement = connection.createStatement();
            int updateCount = statement.executeUpdate("Insert Into Groceries (Grcs_No, Grcs_Name, Grcs_Qty, Grcs_Price) values(101, 'Noodles', '2No', 150)");
            System.out.println("Number of rows created : "+updateCount);
        } catch (SQLException sqlException) {
            throw new RuntimeException(sqlException);
        }
    }
}
