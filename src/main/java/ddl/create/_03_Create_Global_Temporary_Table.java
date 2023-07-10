package ddl.create;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class _03_Create_Global_Temporary_Table {

    static Statement statement;

    public static void main(String[] args) throws ClassNotFoundException {

        Class.forName("oracle.jdbc.driver.OracleDriver");
        try(Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/XEPDB1", "JAGA", "ALLOWME")){
            statement = connection.createStatement();
            statement.executeUpdate("Create Global Temporary Table MobileTab(Tab_Id Number(10) NOT NULL, Tab_Brand Varchar2(20) NOT NULL, Tab_Model Varchar2(20) NOT NULL)");
            System.out.println("Global Temporary MobileTab Table Created.");
        } catch (SQLException sqlException) {
            throw new RuntimeException(sqlException);
        }
        finally {
            try {
                Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/XEPDB1", "JAGA", "ALLOWME");
                statement = connection.createStatement();
                statement.executeUpdate("Drop Table MobileTab");
                System.out.println("Global Temporary MobileTab Table dropped.");
            } catch (SQLException sqlException) {
                sqlException.printStackTrace();
            }
        }
    }
}
