package dml;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class _03_UpdateRecord {

    public static void main(String[] args) throws ClassNotFoundException {

        Class.forName("oracle.jdbc.driver.OracleDriver");
        try(Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/XEPDB1", "JAGA", "ALLOWME")){
            Statement statement = connection.createStatement();
            int updateCount = statement.executeUpdate("Update Groceries Set Grcs_No = 101 where Grcs_Name = 'Cookies'");
            System.out.println("Number of rows updated : "+updateCount);
        } catch (SQLException sqlException) {
            throw new RuntimeException(sqlException);
        }
    }
}
