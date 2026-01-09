package com.example.practiceee.servlet;

import com.example.practiceee.dto.EmployeeDto;
import com.example.practiceee.service.EmployeeService;
import com.example.practiceee.service.impl.EmployeeServiceImpl;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.List;

@WebServlet("/employee")
public class EmployeeServlet extends HttpServlet {

    private final EmployeeService employeeService = new EmployeeServiceImpl();
    private final Gson gson = new Gson();

    // ================= SAVE EMPLOYEE =================
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            StringBuilder sb = new StringBuilder();
            BufferedReader reader = request.getReader();
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }

            EmployeeDto employee = gson.fromJson(sb.toString(), EmployeeDto.class);
            EmployeeDto savedEmployee = employeeService.saveEmployee(employee);

            if (savedEmployee != null) {
                response.getWriter().write(
                        "{\"status\":\"success\",\"message\":\"Employee saved successfully\"}"
                );
            } else {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write(
                        "{\"status\":\"error\",\"message\":\"Failed to save employee\"}"
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"status\":\"error\",\"message\":\"Server error\"}");
        }
    }

    // ================= GET ALL + SEARCH =================
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            String nic = request.getParameter("nic");
            List<EmployeeDto> employees;

            if (nic == null || nic.trim().isEmpty()) {
                employees = employeeService.getAllEmployees();
            } else {
                employees = employeeService.searchEmployees(nic.trim());
            }

            response.getWriter().write(gson.toJson(employees));

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"status\":\"error\",\"message\":\"Server error\"}");
        }
    }

    // ================= UPDATE EMPLOYEE =================
    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            StringBuilder sb = new StringBuilder();
            BufferedReader reader = request.getReader();
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }

            EmployeeDto employee = gson.fromJson(sb.toString(), EmployeeDto.class);
            boolean updated = employeeService.updateEmployee(employee);

            if (updated) {
                response.getWriter().write("{\"status\":\"success\",\"message\":\"Employee updated successfully\"}");
            } else {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"status\":\"error\",\"message\":\"Failed to update employee\"}");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"status\":\"error\",\"message\":\"Server error\"}");
        }
    }


}
