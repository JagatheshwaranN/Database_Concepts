package dml.select;

import java.sql.*;

public class SelectRecord {

    public static void main(String[] args) throws ClassNotFoundException {

        Class.forName("oracle.jdbc.driver.OracleDriver");
        try (Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/XEPDB1", "JAGA", "ALLOWME")) {
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("Select * From Groceries Where Grcs_No = 101");
            while (resultSet.next()) {
                System.out.println(resultSet.getInt(1) + " | " + resultSet.getString(2) + " | " + resultSet.getString(3) + " | " + resultSet.getInt(4));
            }
        } catch (SQLException sqe) {
            throw new RuntimeException(sqe);
        }
    }
}
