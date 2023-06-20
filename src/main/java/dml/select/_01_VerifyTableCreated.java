package dml.select;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class _01_VerifyTableCreated {

    public static void main(String[] args) throws ClassNotFoundException {

        Class.forName("oracle.jdbc.driver.OracleDriver"); // From JDBC 4.2v, this line is optional
        try (Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/XEPDB1", "JAGA", "ALLOWME")) {
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("SELECT Column_Name, Data_Type, Data_Length, Nullable From User_Tab_Columns Where Table_Name = 'GROCERIES'");
            while (resultSet.next()) {
                System.out.println(resultSet.getString(1) + " | " + resultSet.getString(2) + " | " + resultSet.getInt(3) + " | " + resultSet.getString(4));
            }
        }catch(SQLException sqlException){
            sqlException.printStackTrace();
        }
    }
}
