package ddl.drop;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class _02_DropView {

    public static void main(String[] args) throws ClassNotFoundException {

        createView();
        Class.forName("oracle.jdbc.driver.OracleDriver");
        try (Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/XEPDB1", "JAGA", "ALLOWME")) {
            Statement statement = connection.createStatement();
            statement.executeUpdate("Drop View Vw_Emp_Detail");
            System.out.println("Vw_Emp_Detail View dropped.");
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    private static void createView() throws ClassNotFoundException {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        try (Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/XEPDB1", "JAGA", "ALLOWME")) {
            Statement statement = connection.createStatement();
            statement.executeUpdate("Create View Vw_Emp_Detail As Select * From Emp where Designation = 'Dev Lead'");
            System.out.println("Vw_Emp_Detail View created.");
        } catch (SQLException sqlException) {
            throw new RuntimeException(sqlException);
        }
    }
}
