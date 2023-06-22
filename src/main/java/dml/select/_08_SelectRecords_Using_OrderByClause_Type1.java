package dml.select;

import java.sql.*;

public class _08_SelectRecords_Using_OrderByClause_Type1 {

    public static void main(String[] args) throws ClassNotFoundException {

        Class.forName("oracle.jdbc.driver.OracleDriver");
        try(Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/XEPDB1", "JAGA", "ALLOWME")){
            Statement statement = connection.createStatement();
            ResultSet resultSet1 = statement.executeQuery("Select Ename, Sal From Emp Order By Sal ASC");
            while(resultSet1.next()){
                System.out.println(resultSet1.getString(1)+" | "+resultSet1.getInt(2));
            }
            System.out.println("=====================================");
            ResultSet resultSet2 = statement.executeQuery("Select Ename, Sal From Emp Order By 2 DESC");
            while(resultSet2.next()){
                System.out.println(resultSet2.getString(1)+" | "+resultSet2.getInt(2));
            }
        } catch (SQLException sqlException) {
            throw new RuntimeException(sqlException);
        }
    }
}
