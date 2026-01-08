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

@WebServlet("/employees")
public class EmployeeServlet extends HttpServlet {

    private final EmployeeService employeeService = new EmployeeServiceImpl();
    private Gson gson = new Gson();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            StringBuilder sb = new StringBuilder();
            try (BufferedReader reader = request.getReader()) {
                String line;
                while ((line = reader.readLine()) != null) {
                    sb.append(line);
                }
            }
            EmployeeDto employee = gson.fromJson(sb.toString(), EmployeeDto.class);
            employeeService.saveEmployee(employee);
            response.getWriter().write("{\"status\":\"success\",\"message\":\"Employee saved successfully\"}");

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"status\":\"error\",\"message\":\"Failed to save employee\"}");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

}
