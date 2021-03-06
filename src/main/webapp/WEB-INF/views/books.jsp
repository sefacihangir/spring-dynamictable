<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="my" uri="https://springtutor.wordpress.com"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>


<c:set var="pageTitle" value="Books catalog" />

<c:url value="/books/getBooks" var="urlPagination" />
<c:url value="/resources/images/search-icon24.png" var="urlSearchIcon" />
<c:url value="/books/edit" var="urlEdit" />
<c:url value="/books/delete" var="urlDelete" />

<div class="oceanDynamicTable">
	<c:if test="${not empty tableMessage}">
		<div class="${tableMessage.cssClass}">${tableMessage.text}</div>
	</c:if>
	<table ocean-dataUrl="${urlPagination}"
		ocean-collectionSize="${books.size()}"
		ocean-orderBy="price asc,rating desc" ocean-paginationSize="5"
		ocean-paginationLabelNext="Next" ocean-paginationLabelPrev="Prev"
		ocean-paginationLabelNew="New Book"
		ocean-searchIcon="${urlSearchIcon}" ocean-noDataMessage="No data">
		<thead>
			<tr>
				<th ocean-search-property="id">No</th>
				<th ocean-search-property="title">Title</th>
				<th ocean-search-property="releaseDate">Released</th>
				<th ocean-search-property="price" ocean-type="number">Price</th>
				<th ocean-search-property="rating" ocean-type="number">Rating</th>
				<th ocean-search-property="numberOfReviewers" ocean-type="number">Reviewers</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="book" items="${books}" varStatus="count">
				<tr>
					<td>${book.id}</td>
					<td ocean-link="${book.id}">${book.title}</td>
					<td><fmt:formatDate pattern="dd.MM.yyyy"
							value="${book.releaseDate}" /></td>
					<td class="num"><fmt:formatNumber type="currency"
							currencyCode="USD" currencySymbol="$" maxIntegerDigits="9"
							maxFractionDigits="2" value="${book.price}" /></td>
					<td class="num"><fmt:formatNumber type="number"
							maxIntegerDigits="1" maxFractionDigits="2" minFractionDigits="2"
							value="${book.rating}" /></td>
					<td class="num"><fmt:formatNumber type="number"
							value="${book.numberOfReviewers}" /></td>
				</tr>
			</c:forEach>
			<c:if test="${books.size() > 0 }">
				<tr>
					<td></td>
					<td></td>
					<td align="right"><strong>Total:</strong></td>
					<td class="aggr"><fmt:formatNumber type="currency"
							currencyCode="USD" currencySymbol="$" maxIntegerDigits="9"
							maxFractionDigits="2" value="${averagePrice}" /></td>
					<td class="aggr"><fmt:formatNumber type="number"
							maxIntegerDigits="1" maxFractionDigits="2" minFractionDigits="2"
							value="${averageRating}" /></td>
					<td class="aggr"><fmt:formatNumber type="number"
							value="${sumReviewers}" /></td>
				<tr>
			</c:if>
		</tbody>
	</table>
</div>
<c:if test="${not empty book}">
	<div class="oceanDynamicForm" ocean-title-edit="Edit book"
		ocean-title-new="New book">
		<c:if test="${not empty formMessage}">
			<div class="${formMessage.cssClass}">${formMessage.text}</div>
		</c:if>
		<form:form modelAttribute="book" method="post">
			<form:hidden path="id" />
			<fieldset>
				<legend>Book info</legend>
				<form:label path="title">Title</form:label>
				<form:input path="title"/>
				<form:errors path="title" cssClass="validationError" />
				<br>
				<form:label path="description">Description</form:label>
				<form:textarea path="description" rows="10" />
				<form:errors path="description" cssClass="validationError" />
				<br>
				<form:label path="releaseDate">Release Date</form:label>
				<form:input path="releaseDate" />
				<form:errors path="releaseDate" cssClass="validationError" />	
				<br>
				<form:label path="price">Price</form:label>
				<form:input path="price" />
				<form:errors path="price" cssClass="validationError" />
				<br>
				<form:label path="rating">Rating</form:label>
				<form:input path="rating" />
				<form:errors path="rating" cssClass="validationError" />
				<br>
				<form:label path="numberOfReviewers">Reviewers Number</form:label>
				<form:input path="numberOfReviewers" />
				<form:errors path="numberOfReviewers" cssClass="validationError" />
			</fieldset>
			<button type="submit" class="button" formaction="${urlEdit}">Save</button>
			<button type="reset" class="button">Reset</button>
			<button type="submit" class="button deleteButton"
				formaction="${urlDelete}"
				ocean-message="Do you really want to delete this object?">Delete</button>
		</form:form>
	</div>
</c:if>