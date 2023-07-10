package ddl.create;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class _04_Create_Private_Temporary_Table {

    static Statement statement;

    public static void main(String[] args) throws ClassNotFoundException {

        Class.forName("oracle.jdbc.driver.OracleDriver");
        try(Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/XEPDB1", "JAGA", "ALLOWME")){
            statement = connection.createStatement();
            statement.executeUpdate("CREATE PRIVATE TEMPORARY TABLE ora$ptt_Mobile_Tab (Tab_Id Number(5), Tab_Desc Varchar2(20)) ON COMMIT DROP DEFINITION");
            System.out.println("Private Temporary MobileTab Table Created.");
        } catch (SQLException sqlException) {
            throw new RuntimeException(sqlException);
        }
    }
}
