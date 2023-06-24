package dql.aggregate_functions;

import java.sql.*;

public class _06_Select_Record_Using_ListAgg_function {

    public static void main(String[] args) throws ClassNotFoundException {

        Class.forName("oracle.jdbc.driver.OracleDriver");
        try(Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/XEPDB1", "JAGA", "ALLOWME")){
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("Select Designation, LISTAGG(Ename,',') WithIn Group (Order By Ename) As Employees From Emp Group By Designation Order By Designation");
            while (resultSet.next()){
                System.out.println(resultSet.getString(1)+" | "+ resultSet.getString(2));
            }
        } catch (SQLException sqlException) {
            throw new RuntimeException(sqlException);
        }
    }
}
