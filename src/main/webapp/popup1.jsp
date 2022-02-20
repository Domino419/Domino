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
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" name="viewport" content="width=device-width" initial-scale="1">
<title>JSP 게시판 웹 사이트</title>

    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="icon" type="image/png" href="favicon.png">
    <link rel="stylesheet" href="style.css">
    <title>JSP 게시판 웹 사이트</title>
</head>

<body>
    <h1 class="main-title">Kanban Board</h1>
    <div class="drag-container">
        <ul class="drag-list">
            <!-- Backlog Column -->
            <li class="drag-column backlog-column">
                <span class="header">
                    <h1>Backlog</h1>
                </span>
                <!-- Backlog Content -->
                <div id="backlog-content" class="custom-scroll">
                    <ul class="drag-item-list" id="backlog-list" ondrop="drop(event)" ondragover="allowDrop(event)" ondragenter="dragEnter(0)"></ul>
                </div>
                <!-- Add Button Group -->
                <div class="add-btn-group">
                    <div class="add-btn" onclick="showInputBox(0)">
                        <span class="plus-sign">+</span>
                        <span>Add Item</span>
                    </div>
                    <div class="add-btn solid" onclick="hideInputBox(0)">
                        <span>Save Item</span>
                    </div>
                </div>
                <div class="add-container">
                    <div class="add-item" contenteditable="true"></div>
                </div>
            </li>
            <!-- Progress Column -->
            <li class="drag-column progress-column">
                <span class="header">
                    <h1>In Progress</h1>
                </span>
                <!-- Progress Content -->
                <div id="progress-content" class="custom-scroll">
                    <ul class="drag-item-list" id="progress-list" ondrop="drop(event)" ondragover="allowDrop(event)" ondragenter="dragEnter(1)"></ul>
                </div>
                <!-- Add Button Group -->
                <div class="add-btn-group">
                    <div class="add-btn" onclick="showInputBox(1)">
                        <span class="plus-sign">+</span>
                        <span>Add Item</span>
                    </div>
                    <div class="add-btn solid" onclick="hideInputBox(1)">
                        <span>Save Item</span>
                    </div>
                </div>
                <div class="add-container">
                    <div class="add-item" contenteditable="true"></div>
                </div>
            </li>
            <!-- Complete Column -->
            <li class="drag-column complete-column">
                <span class="header">
                    <h1>Complete</h1>
                </span>
                <!-- Complete Content -->
                <div id="complete-content" class="custom-scroll">
                    <ul class="drag-item-list" id="complete-list" ondrop="drop(event)" ondragover="allowDrop(event)" ondragenter="dragEnter(2)"></ul>
                </div>
                <!-- Add Button Group -->
                <div class="add-btn-group">
                    <div class="add-btn" onclick="showInputBox(2)">
                        <span class="plus-sign">+</span>
                        <span>Add Item</span>
                    </div>
                    <div class="add-btn solid" onclick="hideInputBox(2)">
                        <span>Save Item</span>
                    </div>
                </div>
                <div class="add-container">
                    <div class="add-item" contenteditable="true"></div>
                </div>
            </li>
            <!-- On Hold Column -->
            <li class="drag-column on-hold-column">
                <span class="header">
                    <h1>On Hold</h1>
                </span>
                <!-- On Hold Content -->
                <div id="on-hold-content" class="custom-scroll">
                    <ul class="drag-item-list" id="on-hold-list" ondrop="drop(event)" ondragover="allowDrop(event)" ondragenter="dragEnter(3)"></ul>
                </div>
                <!-- Add Button Group -->
                <div class="add-btn-group">
                    <div class="add-btn" onclick="showInputBox(3)">
                        <span class="plus-sign">+</span>
                        <span>Add Item</span>
                    </div>
                    <div class="add-btn solid" onclick="hideInputBox(3)">
                        <span>Save Item</span>
                    </div>
                </div>
                <div class="add-container">
                    <div class="add-item" contenteditable="true"></div>
                </div>
            </li>
        </ul>
    </div>
    <!-- Script -->
    <script src="C:\workspaces\Jsptest\src\main\webapp\js"></script>
</body>
</html>
