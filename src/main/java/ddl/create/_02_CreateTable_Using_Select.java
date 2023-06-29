package ddl.create;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class _02_CreateTable_Using_Select {

    static Statement statement;
    public static void main(String[] args) throws ClassNotFoundException {

        Class.forName("oracle.jdbc.driver.OracleDriver"); // From JDBC 4.2v, this line is optional
        try (Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/XEPDB1", "JAGA", "ALLOWME")) {
            statement = connection.createStatement();
            statement.executeUpdate("Create Table Emp_Reference As Select * From Emp");
            System.out.println("Emp_Reference Table created.");
        }catch (SQLException sqlException){
            sqlException.printStackTrace();
        }
        finally {
            try {
                Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/XEPDB1", "JAGA", "ALLOWME");
                statement = connection.createStatement();
                statement.executeUpdate("Drop Table Emp_Reference");
                System.out.println("Emp_Reference Table dropped.");
            } catch (SQLException sqlException) {
                sqlException.printStackTrace();
            }
        }
    }
}
