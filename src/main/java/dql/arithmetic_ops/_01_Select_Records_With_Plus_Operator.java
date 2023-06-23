package dql.arithmetic_ops;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;

public class _01_Select_Records_With_Plus_Operator {

    public static void main(String[] args) throws ClassNotFoundException {

        Class.forName("oracle.jdbc.driver.OracleDriver");
        try(Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/XEPDB1", "JAGA", "ALLOWME")){
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("Select EmpNo, Ename, Sal, Designation, Sal+1000 As Allowance from Emp");
            while (resultSet.next()){
                System.out.println(resultSet.getInt(1)+" | "+resultSet.getString(2)+" | "+
                        resultSet.getInt(3) + " | "+resultSet.getString(4)+" | "+resultSet.getInt(5));
            }
        } catch (SQLException sqlException) {
            throw new RuntimeException(sqlException);
        }
    }
}
