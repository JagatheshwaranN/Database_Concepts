package dql.arithmetic_ops;

import java.sql.*;

public class _03_Select_Records_With_Mul_Operator {

    public static void main(String[] args) throws ClassNotFoundException {

        Class.forName("oracle.jdbc.driver.OracleDriver");
        try(Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/XEPDB1", "JAGA", "ALLOWME")){
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("Select EmpNo, Ename, Sal, Designation, Sal * 2 As Bonus from Emp");
            while (resultSet.next()){
                System.out.println(resultSet.getInt(1)+" | "+resultSet.getString(2)+" | "+
                        resultSet.getInt(3) + " | "+resultSet.getString(4)+" | "+resultSet.getInt(5));
            }
        } catch (SQLException sqlException) {
            throw new RuntimeException(sqlException);
        }
    }
}
