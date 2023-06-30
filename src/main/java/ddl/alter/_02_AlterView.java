package ddl.alter;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class _02_AlterView {

    public static void main(String[] args) throws ClassNotFoundException {

        Class.forName("oracle.jdbc.driver.OracleDriver");
        try(Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/XEPDB1", "JAGA", "ALLOWME")){
            Statement statement = connection.createStatement();
            statement.executeUpdate("Create Or Replace View Vw_Emp_Info As Select * From Emp where Designation = 'Tester'");
            System.out.println("Vw_Emp_Info View altered");
        } catch (SQLException sqlException) {
            throw new RuntimeException(sqlException);
        }
    }
}
