package ddl.create;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class _09_CreateView_Materialized {

    /*
        Materialized View - The materialized view is like a snapshot of the table data. While
        creation of Materialized View, if the table contain 5 records for example, then only
        those 5 records will be shown in Materialized even if the table is updated with more
        records.
    */
    public static void main(String[] args) throws ClassNotFoundException {

        Class.forName("oracle.jdbc.driver.OracleDriver");
        try(Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/XEPDB1", "JAGA", "ALLOWME")) {
            Statement statement = connection.createStatement();
            statement.executeUpdate("Create Materialized View Vw_Mv_Mobile as Select * From Mobile");
            System.out.println("Vw_Mv_Mobile Materialized View created.");
        } catch (SQLException sqlException) {
            throw new RuntimeException(sqlException);
        }
    }
}
