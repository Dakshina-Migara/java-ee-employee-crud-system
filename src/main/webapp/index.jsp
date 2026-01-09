<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Employee Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        .card { margin-top: 20px; }
    </style>
</head>
<body>

<div class="container-fluid mt-4">
    <div class="row">

        <!-- SAVE EMPLOYEE -->
        <div class="col-md-4">
            <div class="card shadow">
                <div class="card-header bg-primary text-white">Save Employee</div>
                <div class="card-body">
                    <input id="empNic" class="form-control mb-2" placeholder="NIC">
                    <input id="empName" class="form-control mb-2" placeholder="Name">
                    <input id="empAge" type="number" class="form-control mb-2" placeholder="Age">
                    <input id="empSalary" type="number" class="form-control mb-3" placeholder="Salary">
                    <button class="btn btn-success w-100" onclick="saveEmployee()">Save</button>
                </div>
            </div>
        </div>

        <!-- SEARCH + TABLE -->
        <div class="col-md-8">
            <div class="card shadow">
                <div class="card-header bg-dark text-white">Employee Details</div>
                <div class="card-body">

                    <!-- SEARCH BAR -->
                    <div class="row mb-3">
                        <div class="col-md-8">
                            <input id="searchNic" class="form-control" placeholder="Search by NIC">
                        </div>
                        <div class="col-md-4">
                            <button class="btn btn-primary w-100" onclick="searchEmployee()">Search</button>
                        </div>
                    </div>

                    <!-- TABLE -->
                    <table class="table table-bordered table-striped">
                        <thead class="table-secondary">
                        <tr>
                            <th>Name</th>
                            <th>NIC</th>
                            <th>Age</th>
                            <th>Salary</th>
                            <th>Action</th>
                        </tr>
                        </thead>
                        <tbody id="employeeTableBody"></tbody>
                    </table>

                </div>
            </div>
        </div>

    </div>
</div>

<!-- SEARCH MODAL -->
<div class="modal fade" id="viewModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-info text-white">
                <h5 class="modal-title">Employee Details</h5>
                <button class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <p><b>NIC:</b> <span id="viewEmpNic"></span></p>
                <p><b>Name:</b> <span id="viewEmpName"></span></p>
                <p><b>Age:</b> <span id="viewEmpAge"></span></p>
                <p><b>Salary:</b> <span id="viewEmpSalary"></span></p>
            </div>
        </div>
    </div>
</div>

<!-- UPDATE MODAL -->
<div class="modal fade" id="updateModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-warning">Update Employee</div>
            <div class="modal-body">
                <input id="updateNic" class="form-control mb-2" readonly>
                <input id="updateName" class="form-control mb-2">
                <input id="updateAge" type="number" class="form-control mb-2">
                <input id="updateSalary" type="number" class="form-control">
            </div>
            <div class="modal-footer">
                <button class="btn btn-warning" onclick="updateEmployee()">Update</button>
            </div>
        </div>
    </div>
</div>

<!-- DELETE MODAL -->
<div class="modal fade" id="deleteModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-danger text-white">Delete Employee</div>
            <div class="modal-body">
                Are you sure you want to delete <b id="deleteNic"></b>?
            </div>
            <div class="modal-footer">
                <button class="btn btn-danger" onclick="deleteEmployee()">Delete</button>
            </div>
        </div>
    </div>
</div>

<!-- JS -->
<script>
    getAllEmployee();

    function saveEmployee() {
        const emp = {
            nic: empNic.value,
            name: empName.value,
            age: +empAge.value,
            salary: +empSalary.value
        };
        fetch("http://localhost:8080/practice_ee_war_exploded/employee", {
            method: "POST",
            headers: {"Content-Type": "application/json"},
            body: JSON.stringify(emp)
        }).then(() => getAllEmployee());
    }

    function getAllEmployee() {
        fetch("http://localhost:8080/practice_ee_war_exploded/employee")
            .then(r => r.json())
            .then(data => {
                employeeTableBody.innerHTML = "";
                data.forEach(emp => {
                    employeeTableBody.innerHTML += `
                    <tr>
                        <td>\${emp.name}</td>
                        <td>\${emp.nic}</td>
                        <td>\${emp.age}</td>
                        <td>\${emp.salary}</td>
                        <td>
                            <button class="btn btn-warning btn-sm" onclick="openUpdateModal('\${emp.nic}','\${emp.name}',\${emp.age},\${emp.salary})">Update</button>
                            <button class="btn btn-danger btn-sm" onclick="openDeleteModal('\${emp.nic}')">Delete</button>
                        </td>
                    </tr>`;
                });
            });
    }

    function searchEmployee() {
        const nic = searchNic.value.trim();
        if (!nic) { alert("Please enter NIC"); return; }

        fetch("http://localhost:8080/practice_ee_war_exploded/employee?nic=" + nic)
            .then(r => r.json())
            .then(data => {
                if (!Array.isArray(data) || data.length === 0) { alert("No employee found"); return; }
                const emp = data[0];
                viewEmpNic.textContent = emp.nic;
                viewEmpName.textContent = emp.name;
                viewEmpAge.textContent = emp.age;
                viewEmpSalary.textContent = emp.salary;
                new bootstrap.Modal(viewModal).show();
            });
    }

    // Open Update Modal
    function openUpdateModal(nic, name, age, salary) {
        document.getElementById("updateNic").value = nic;
        document.getElementById("updateName").value = name;
        document.getElementById("updateAge").value = age;
        document.getElementById("updateSalary").value = salary;
        new bootstrap.Modal(document.getElementById("updateModal")).show();
    }

    // Open Delete Modal
    function openDeleteModal(nic) {
        document.getElementById("deleteNic").textContent = nic;
        new bootstrap.Modal(document.getElementById("deleteModal")).show();
    }


    function updateEmployee() {
        const emp = {
            nic: document.getElementById("updateNic").value,
            name: document.getElementById("updateName").value,
            age: parseInt(document.getElementById("updateAge").value),
            salary: parseFloat(document.getElementById("updateSalary").value)
        };

        fetch("/practice_ee_war_exploded/employee", {
            method: "PUT",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(emp)
        })
            .then(res => res.json())
            .then(data => {
                alert("Employee updated successfully!");
                getAllEmployee(); // refresh table
                bootstrap.Modal.getInstance(document.getElementById("updateModal")).hide();
            })
            .catch(err => console.log("Update error:", err));
    }

    function deleteEmployee() {
        const nic = document.getElementById("deleteNic").textContent;

        fetch("/practice_ee_war_exploded/employee?nic=" + nic, {
            method: "DELETE"
        })
            .then(res => res.json())
            .then(data => {
                alert("Employee deleted successfully!");
                getAllEmployee(); // refresh table
                bootstrap.Modal.getInstance(document.getElementById("deleteModal")).hide();
            })
            .catch(err => console.log("Delete error:", err));
    }


</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
