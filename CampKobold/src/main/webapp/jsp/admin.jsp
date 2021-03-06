<%-- 
    Document   : admin
    Created on : May 10, 2016, 3:46:27 PM
    Author     : Brandon
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Kobold Camp Asset Management</title>
        <!-- Bootstrap core CSS -->
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">

        <!-- Custom styles for this template -->
        <link href="${pageContext.request.contextPath}/css/responsive.css" rel="stylesheet">

        <!-- SWC Icon -->
        <link rel="shortcut icon" href="${pageContext.request.contextPath}/img/trees.png">
    </head>
    <body>
        <div class="container">
            <div class="content">
                <img src="${pageContext.request.contextPath}/img/trees.png" 
                     alt="tree_logo" 
                     style="padding-right: 5px" 
                     height="30" 
                     width="30" 
                     align="left">
                <h2>Kobold Camp</h2>
            </div>
            <nav class="navbar navbar-default">
                <div class="container-fluid">
                    <!-- Brand and toggle get grouped for better mobile display -->
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                            <span class="sr-only">Toggle navigation</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        <div class="navbar-brand" style="pointer-events: none; background-color: lightslategray; color: white">Equipment Rental</div>
                    </div>

                    <!-- Collect the nav links, forms, and other content for toggling -->
                    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                        <ul class="nav navbar-nav">                   
                            <!--render navbar links based on roles-->
                            <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
                            <li><a href="${pageContext.request.contextPath}/rentals">Rentals</a></li>
                                <sec:authorize access="hasRole('ROLE_EMPLOYEE')">
                                <li><a href="${pageContext.request.contextPath}/assets">Assets</a></li>
                                </sec:authorize>
                                <sec:authorize access="hasRole('ROLE_EMPLOYEE')">
                                <li><a href="${pageContext.request.contextPath}/members">Members</a></li>
                                </sec:authorize>
                                <sec:authorize access="hasRole('ROLE_ADMIN')">
                                <li class="active"><a href="${pageContext.request.contextPath}/admin">Admin</a></li>
                                </sec:authorize>
                                <sec:authorize access="hasRole('ROLE_USER')">
                                <li><a href="${pageContext.request.contextPath}/profile">Profile</a></li>
                                </sec:authorize>
                        </ul>
                        <div class="signout navbar-form navbar-right">
                            <button class="btn" style="pointer-events: none; background-color: lightslategray; color: white">
                                <sec:authentication property="principal.username"/>
                            </button>
                            <a href="${pageContext.request.contextPath}/j_spring_security_logout"> 
                                <button type="submit" id="logOut" class="btn btn-danger gradient">Log Out</button>
                            </a>
                        </div>
                    </div><!-- /.navbar-collapse -->
                </div><!-- /.container-fluid -->
            </nav>
        </div>
        <div class="container">
            <h4>Kobold Camp Admin</h4>
            <div class="row">
                <div class="col-md-6">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <div class="col-sm-4">
                                <label></label>
                                <input type="text" id="search-admin-member-id" class="form-control" placeholder="Member Id">
                            </div>
                            <div class="col-sm-4">
                                <label></label>
                                <input type="text" id="search-admin-member-lastname" class="form-control" placeholder="Last Name">
                            </div>
                            <div class="col-sm-4"> 
                                <br>
                                <button type="submit" id="search-admin-button" class="btn btn-primary">Search</button>
                            </div>
                        </div>
                    </form>
                    <table class="table table-responsive table-striped" style="border: 1px solid lightgray">
                        <tr style="background-color: lightslategray; color: white">
                            <th>ID</th>
                            <th>Name</th>
                            <th>Type</th>
                            <th>Remove</th>
                            <th>Password</th>
                        </tr>
                        <tbody id="adminRows">
                            <c:forEach var="user" items="${users}">
                                <tr> 
                                    <td>${user.userId}</td>
                                    <td>${user.firstName} ${user.lastName}</td>
                                    <td>${user.userProfile.memberId}</td>
                                    <s:url value="deleteUserNoAjax" var="delete_url">
                                        <s:param name="userId" value="${user.userId}"/>
                                    </s:url>

                                    <s:url value="resetPasswordNoAjax" var="resetPassword_url">
                                        <s:param name="userId" value="${user.userId}"/>
                                    </s:url>
                                    <td><a href="${delete_url}">Delete</a></td>
                                    <td><a href="${resetPassword_url}">Reset Password</a></td>
                                </tr>
                            </c:forEach>

                        </tbody>
                    </table>
                </div>

                <div class="col-md-6">
                    <form class="form-horizontal">
                        <br>
                        <h4>Add Equipment</h4>
                        <div class="form-group">
                            <label for="add-category" class="col-sm-3 control-label">Category:</label>
                            <div class="col-sm-5">
                                <select class="form-control" id="add-category">
                                    <option value="" selected>Category</option>
                                    <option value="1">Backpacks</option>
                                    <option value="2">Sleeping Bags</option>
                                    <option value="3">Camping Stoves</option>
                                    <option value="4">Paddling Gear</option>
                                    <option value="5">Tents</option>
                                </select> 
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="add-brand" class="col-sm-3 control-label">Brand:</label>
                            <div class="col-sm-7">
                                <input type="text" class="form-control" id="add-brand" placeholder="Brand">
                            </div>

                        </div>
                        <div class="form-group">
                            <label for="add-description" class="col-sm-3 control-label">Description:</label>
                            <div class="col-sm-7">
                                <textarea type="text" class="form-control" id="add-description" placeholder="Description"></textarea>
                            </div>
                        </div>

                        <div class="col-sm-offset-2 col-sm-10">
                        </div>
                        <div class="form-group">
                            <div class="col-sm-offset-3 col-sm-8">
                                <button type="submit" class="btn btn-primary" id="add-equipment-button">Add Equipment</button>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-offset-3 col-sm-8" id="validationErrors" style="color: red;">
                            </div>
                        </div>
                    </form>

                </div>

            </div>
            <jsp:include page="footer.jsp"/>
        </div>
        <!-- Placed at the end of the document so the pages load faster -->
        <script src="${pageContext.request.contextPath}/js/jquery-1.11.3.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/asset.js"></script>
        <script src="${pageContext.request.contextPath}/js/admin.js"></script>
    </body>
</html>
