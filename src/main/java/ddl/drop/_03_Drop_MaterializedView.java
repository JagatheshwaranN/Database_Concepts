package ddl.drop;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class _03_Drop_MaterializedView {

    public static void main(String[] args) throws ClassNotFoundException {

        createMaterializedView();
        Class.forName("oracle.jdbc.driver.OracleDriver");
        try (Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/XEPDB1", "JAGA", "ALLOWME")) {
            Statement statement = connection.createStatement();
            statement.executeUpdate("Drop Materialized View Vw_Mv_Mob");
            System.out.println("Vw_Mv_Mob Materialized View dropped.");
        } catch (SQLException sqlException) {
            throw new RuntimeException(sqlException);
        }
    }

    private static void createMaterializedView() throws ClassNotFoundException {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        try (Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/XEPDB1", "JAGA", "ALLOWME")) {
            Statement statement = connection.createStatement();
            statement.executeUpdate("Create Materialized View Vw_Mv_Mob As Select * From Mobile");
            System.out.println("Vw_Mv_Mob Materialized View created.");
        } catch (SQLException sqlException) {
            throw new RuntimeException(sqlException);
        }
    }
}
