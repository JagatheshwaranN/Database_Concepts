package dml.non_select;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class _06_DeleteAllRecords {

    public static void main(String[] args) throws ClassNotFoundException {

        Class.forName("oracle.jdbc.driver.OracleDriver");
        try(Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/XEPDB1", "JAGA", "ALLOWME")){
            Statement statement = connection.createStatement();
            int updateCount = statement.executeUpdate("Delete Groceries");
            System.out.println("Number of rows deleted : "+updateCount);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
