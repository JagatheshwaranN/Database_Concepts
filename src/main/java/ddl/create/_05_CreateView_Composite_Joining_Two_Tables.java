package ddl.create;

import java.sql.*;

public class _05_CreateView_Composite_Joining_Two_Tables {

    public static void main(String[] args) throws ClassNotFoundException {

        Class.forName("oracle.jdbc.driver.OracleDriver");
        try(Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/XEPDB1","JAGA", "ALLOWME")){
            Statement statement = connection.createStatement();
            statement.executeUpdate("Create View Vw_Empl_Deprt_Dtls As Select E.EmpNo, E.EmpName, E.Salary, E.DeptNo, D.DeptName From Employee E, Department D Where E.DeptNo = D.DeptNo");
            System.out.println("Empl_Deprt_Dtls View created.");
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
