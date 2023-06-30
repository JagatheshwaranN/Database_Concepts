package ddl.create;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class _04_CreateView_With_Condition {

    public static void main(String[] args) throws ClassNotFoundException {

        Class.forName("oracle.jdbc.driver.OracleDriver");
        try(Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/XEPDB1", "JAGA", "ALLOWME")){
            Statement statement = connection.createStatement();
            statement.executeUpdate("Create View Vw_Emp_Info As Select * From Emp where Designation = 'Developer'");
            System.out.println("Emp Info View created.");
        } catch (SQLException sqlException) {
            throw new RuntimeException(sqlException);
        }
    }
}
