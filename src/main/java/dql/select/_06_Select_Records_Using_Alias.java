package dql.select;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;

public class _06_Select_Records_Using_Alias {

    public static void main(String[] args) throws ClassNotFoundException {

        Class.forName("oracle.jdbc.driver.OracleDriver");
        try(Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/XEPDB1", "JAGA", "ALLOWME")){
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("Select employee.ename, employee.sal From Emp employee");
            while (resultSet.next()){
                System.out.println(resultSet.getString(1)+" | "+
                        resultSet.getInt(2));
            }
        }catch (SQLException sqlException){
            sqlException.printStackTrace();
        }
    }
}
