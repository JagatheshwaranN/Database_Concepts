package ddl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class _01_TruncateTable {

    public static void main(String[] args) throws ClassNotFoundException {

        Class.forName("oracle.jdbc.driver.OracleDriver");
        try(Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/XEPDB1","JAGA", "ALLOWME")) {
            Statement statement = connection.createStatement();
            statement.executeUpdate("Truncate Table Groceries");
            System.out.println("Groceries Table truncated");
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
