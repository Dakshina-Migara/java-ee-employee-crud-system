package com.example.practiceee.service.impl;

import com.example.practiceee.db.DBConnection;
import com.example.practiceee.dto.EmployeeDto;
import com.example.practiceee.service.EmployeeService;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.List;

public class EmployeeServiceImpl implements EmployeeService {

    // ================= SAVE EMPLOYEE =================
    @Override
    public EmployeeDto saveEmployee(EmployeeDto employeeDto) {
        String sql = "INSERT INTO employee(employee_nic, employee_name, employee_age, employee_salary) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {

            pst.setString(1, employeeDto.getNic());
            pst.setString(2, employeeDto.getName());
            pst.setInt(3, employeeDto.getAge());
            pst.setDouble(4, employeeDto.getSalary());

            int affected = pst.executeUpdate();
            return affected > 0 ? employeeDto : null;

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    // ================= UPDATE EMPLOYEE =================
    @Override
    public boolean updateEmployee(EmployeeDto employeeDto) {
        String sql = "UPDATE employee SET employee_name=?, employee_age=?, employee_salary=? WHERE employee_nic=?";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {

            pst.setString(1, employeeDto.getName());
            pst.setInt(2, employeeDto.getAge());
            pst.setDouble(3, employeeDto.getSalary());
            pst.setString(4, employeeDto.getNic());

            int affected = pst.executeUpdate();
            return affected > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // ================= DELETE EMPLOYEE =================
    @Override
    public boolean deleteEmployee(String nic) {
        String sql = "DELETE FROM employee WHERE employee_nic=?";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {

            pst.setString(1, nic);
            int affected = pst.executeUpdate();
            return affected > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // ================= GET ALL EMPLOYEES =================
    @Override
    public List<EmployeeDto> getAllEmployees() {
        String sql = "SELECT * FROM employee";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement pst = conn.prepareStatement(sql);
             var rs = pst.executeQuery()) {

            List<EmployeeDto> employees = new java.util.ArrayList<>();
            while (rs.next()) {
                EmployeeDto emp = new EmployeeDto();
                emp.setNic(rs.getString("employee_nic"));
                emp.setName(rs.getString("employee_name"));
                emp.setAge(rs.getInt("employee_age"));
                emp.setSalary(rs.getDouble("employee_salary"));
                employees.add(emp);
            }
            return employees;

        } catch (Exception e) {
            e.printStackTrace();
            return List.of();
        }
    }

    // ================= SEARCH EMPLOYEE =================
    @Override
    public List<EmployeeDto> searchEmployees(String nic) {
        String sql = "SELECT * FROM employee WHERE employee_nic LIKE ?";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {

            pst.setString(1, "%" + nic + "%"); // partial match
            try (var rs = pst.executeQuery()) {
                List<EmployeeDto> employees = new java.util.ArrayList<>();
                while (rs.next()) {
                    EmployeeDto emp = new EmployeeDto();
                    emp.setNic(rs.getString("employee_nic"));
                    emp.setName(rs.getString("employee_name"));
                    emp.setAge(rs.getInt("employee_age"));
                    emp.setSalary(rs.getDouble("employee_salary"));
                    employees.add(emp);
                }
                return employees;
            }

        } catch (Exception e) {
            e.printStackTrace();
            return List.of();
        }
    }
}
