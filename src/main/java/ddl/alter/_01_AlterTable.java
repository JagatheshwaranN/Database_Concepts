package ddl.alter;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class _01_AlterTable {

    static Statement statement;

    public static void main(String[] args) throws ClassNotFoundException {

        createTable();
        Class.forName("oracle.jdbc.driver.OracleDriver");
        try(Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/XEPDB1", "JAGA", "ALLOWME")){
            statement = connection.createStatement();

            statement.executeUpdate("Alter Table Movie Modify (Name varchar2(25), Director varchar2(25), Crew number(5))");
            System.out.println("Movie Table altered with modify function.");

            statement.executeUpdate("Alter Table Movie Add (Production varchar2(25))");
            System.out.println("Movie Table altered with add function.");

            statement.executeUpdate("Alter Table Movie Drop Column Production");
            System.out.println("Movie Table altered with drop function.");

            statement.executeUpdate("Alter Table Movie Rename Column Name To MovieName");
            System.out.println("Movie Table Column altered with Rename function.");

            statement.executeUpdate("Alter Table Movie Rename To Movies");
            System.out.println("Movie Table altered with Rename function.");

        } catch (SQLException sqlException) {
            throw new RuntimeException(sqlException);
        }
        finally {
            try {
            Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/XEPDB1", "JAGA", "ALLOWME");
            statement = connection.createStatement();
            statement.executeUpdate("Drop Table Movies");
            System.out.println("Movies Table dropped.");
            } catch (SQLException sqlException) {
                sqlException.printStackTrace();
            }
        }
    }

    private static void createTable() throws ClassNotFoundException {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        try (Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/XEPDB1", "JAGA", "ALLOWME")) {
            Statement statement = connection.createStatement();
            statement.executeUpdate("Create Table Movie(Name varchar2(20), Director varchar2(20), Crew number(2))");
            System.out.println("Movie Table created.");
        } catch (SQLException sqlException) {
            throw new RuntimeException(sqlException);
        }
    }
}
