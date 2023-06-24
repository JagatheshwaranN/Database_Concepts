package dql.aggregate_functions;

import java.sql.*;

public class _04_Select_Record_Using_Count_function {

    static ResultSet resultSet;

    public static void main(String[] args) throws ClassNotFoundException {

        Class.forName("oracle.jdbc.driver.OracleDriver");
        try(Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/XEPDB1", "JAGA", "ALLOWME")){
            Statement statement = connection.createStatement();
            resultSet = statement.executeQuery("Select Count(*) From Emp");
            while (resultSet.next()){
                System.out.println(resultSet.getInt(1));
            }
            System.out.println("=============================================");
            resultSet = statement.executeQuery("Select Count(Distinct Ename) From Emp");
            while (resultSet.next()){
                System.out.println(resultSet.getInt(1));
            }
            System.out.println("=============================================");
            resultSet = statement.executeQuery("Select Count(All Sal) From Emp");
            while (resultSet.next()){
                System.out.println(resultSet.getInt(1));
            }
        } catch (SQLException sqlException) {
            throw new RuntimeException(sqlException);
        }
    }
}
