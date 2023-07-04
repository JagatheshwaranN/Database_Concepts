package ddl.create;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class _06_CreateView_Force {

    /*
        Force View - The view created forcefully without the existence of the table.
    */
    public static void main(String[] args) throws ClassNotFoundException {

        Class.forName("oracle.jdbc.driver.OracleDriver");
        try(Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/XEPDB1", "JAGA", "ALLOWME")) {
            Statement statement = connection.createStatement();
            statement.executeUpdate("Create Force View Vw_Cars as Select * From Cars");
            System.out.println("Vw_Cars Force View created.");
        } catch (SQLException sqlException) {
            throw new RuntimeException(sqlException);
        }
    }
}
