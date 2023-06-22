package dml.select;

import java.sql.*;

public class _09_SelectRecords_Using_OrderByClause_Type2 {

    public static void main(String[] args) throws ClassNotFoundException {

        Class.forName("oracle.jdbc.driver.OracleDriver");
        try(Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/XEPDB1", "JAGA", "ALLOWME")){
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("Select * From Emp Order By Sal, Designation");
            while(resultSet.next()){
                System.out.println(resultSet.getInt(1)+" | "+resultSet.getString(2)+" | "+
                        resultSet.getInt(3) + " | "+resultSet.getString(4));
            }
            System.out.println("=====================================");
            ResultSet resultSet2 = statement.executeQuery("Select * From Emp Order By 3, 4 Desc");
            while(resultSet2.next()){
                System.out.println(resultSet2.getInt(1)+" | "+resultSet2.getString(2)+" | "+
                        resultSet2.getInt(3) + " | "+resultSet2.getString(4));
            }
        } catch (SQLException sqlException) {
            throw new RuntimeException(sqlException);
        }
    }
}
