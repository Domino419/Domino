<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.ResultSet"%>

<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" initial-scale="1" > 
<link rel="stylesheet" href="css/bootstrap.css">
<title>JSP 게시판 웹 사이트</title>
<style type = "text/css">
    a, a:hover
    {
        color: #000000;
        text-decoration: none;
    }
</style>
</head>
<body>
	<%  
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	   }
	
	%>
	<div class="container py-5">
  <div class="row">

    <!-- Start lane -->
    <div class="col-12 col-lg-4">
      <div class="card mb-3">
        <div class="card-header bg-light">
          <h3 class="card-title h5 mb-1">
            Backlog
          </h3>
          <small class="mb-0 text-muted">
            Backlog
          </small>
        </div>
        <div class="card-body">
          <div class="tasks" id="backlog">
            <!-- Start task -->
            <div class="card mb-3 cursor-grab">
              <div class="card-body">
                <p class="mb-0">You can move these elements between the containers</p>
                <div class="text-right">
                  <small class="text-muted mb-1 d-inline-block">25%</small>
                </div>
                <div class="progress" style="height: 5px;">
                  <div class="progress-bar" role="progressbar" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                </div>
              </div>
            </div>
            <!-- End task -->
            <!-- Start task -->
            <div class="card mb-3 cursor-grab">
              <img class="card-img-top" src="https://source.unsplash.com/sECcwm6BN8w/400x200" alt="Bootstrap Kanban Board" />
              <div class="card-body">
                <span class="badge bg-primary text-white mb-2">On hold</span>
                <p class="mb-0">Moving them anywhere else isn't quite possible</p>
                <div class="text-right">
                  <small class="text-muted mb-1 d-inline-block">33%</small>
                </div>
                <div class="progress" style="height: 5px;">
                  <div class="progress-bar" role="progressbar" style="width: 33%;" aria-valuenow="33" aria-valuemin="0" aria-valuemax="100"></div>
                </div>
              </div>
            </div>
            <!-- End task -->
          </div>
          <div class="btn btn-primary btn-block">Add task</div>
        </div>
      </div>
    </div>
    <!-- End lane -->

    <!-- Start lane -->
    <div class="col-12 col-lg-4">
      <div class="card mb-3">
        <div class="card-header bg-light">
          <h3 class="card-title h5 mb-1">
            In Progress
          </h3>
          <small class="mb-0 text-muted">
            In Progress
          </small>
        </div>
        <div class="card-body">
          <div class="tasks" id="progress">
            <!-- Start task -->
            <div class="card mb-3 cursor-grab">
              <div class="card-body">
                <span class="badge bg-danger text-white mb-2">Bug</span>
                <p class="mb-0">Moving them anywhere else isn't quite possible</p>
                <div class="text-right">
                  <small class="text-muted mb-1 d-inline-block">45%</small>
                </div>
                <div class="progress" style="height: 5px;">
                  <div class="progress-bar" role="progressbar" style="width: 45%;" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100"></div>
                </div>
              </div>
            </div>
            <!-- End task -->
            <!-- Start task -->
            <div class="card mb-3 cursor-grab">
              <div class="card-body">
                <p class="mb-0">Anything can be moved around. That includes images, links or any other nested elements.</p>
                <div class="text-right">
                  <small class="text-muted mb-1 d-inline-block">75%</small>
                </div>
                <div class="progress" style="height: 5px;">
                  <div class="progress-bar" role="progressbar" style="width: 75%;" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100"></div>
                </div>
              </div>
            </div>
            <!-- End task -->
          </div>
          <div class="btn btn-primary btn-block">Add task</div>
        </div>
      </div>
    </div>
    <!-- End lane -->

    <!-- Start lane -->
    <div class="col-12 col-lg-4">
      <div class="card mb-3">
        <div class="card-header bg-light">
          <h3 class="card-title h5 mb-1">
            Completed
          </h3>
          <small class="mb-0 text-muted">
            Completed
          </small>
        </div>
        <div class="card-body">
          <div class="tasks" id="completed">
            <!-- Start task -->
            <div class="card mb-3 cursor-grab">
              <img class="card-img-top" src="https://source.unsplash.com/zNRITe8NPqY/400x200" alt="Bootstrap Kanban Board" />
              <div class="card-body">
                <span class="badge bg-warning text-white mb-2">Enhancement</span>
                <p class="mb-0">Moving them anywhere else isn't quite possible</p>
                <div class="text-right">
                  <small class="text-muted mb-1 d-inline-block">95%</small>
                </div>
                <div class="progress" style="height: 5px;">
                  <div class="progress-bar" role="progressbar" style="width: 95%;" aria-valuenow="85" aria-valuemin="0" aria-valuemax="100"></div>
                </div>
              </div>
            </div>
            <!-- End task -->
            <!-- Start task -->
            <div class="card mb-3 cursor-grab">
              <div class="card-body">
                <p class="mb-0">You can move these elements between the containers</p>
                <div class="text-right">
                  <small class="text-muted mb-1 d-inline-block">80%</small>
                </div>
                <div class="progress" style="height: 5px;">
                  <div class="progress-bar" role="progressbar" style="width: 80%;" aria-valuenow="80" aria-valuemin="0" aria-valuemax="100"></div>
                </div>
              </div>
            </div>
            <!-- End task -->
          </div>
          <div class="btn btn-primary btn-block">Add task</div>
        </div>
      </div>
    </div>
    <!-- End lane -->

  </div>
</div>
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.js"></script>
</body>
</html>