package dql.select;

import java.sql.*;

public class _08_SelectRecord_From_MaterializedView {

    public static void main(String[] args) throws ClassNotFoundException {

        Class.forName("oracle.jdbc.driver.OracleDriver");
        try(Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/XEPDB1", "JAGA", "ALLOWME")){
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("Select * From Vw_Mv_Mobile");
            while(resultSet.next()){
                System.out.println(resultSet.getString(1) + " | " + resultSet.getString(2));
            }
        } catch (SQLException sqlException) {
            throw new RuntimeException(sqlException);
        }
    }
}
