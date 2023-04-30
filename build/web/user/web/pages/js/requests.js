/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */
let  category = null;
const story = "#story";
const horror = "#horror";
const education = "#education";
const novel = "#novel";
const gk = "#gk";
const comic = "#comic";
const  checkOut = "checkout";


$(story).click(function () {
    category = "story";
    window.location.href = "shop.jsp?category=" + category;

});

$(horror).click(function () {
    category = "horror";
    window.location.href = "shop.jsp?category=" + category;

});

$(education).click(function () {
    category = "education";
    window.location.href = "shop.jsp?category=" + category;

});

$(novel).click(function () {
    category = "novel";
    window.location.href = "shop.jsp?category=" + category;

});

$(gk).click(function () {
    category = "gk";
    window.location.href = "shop.jsp?category=" + category;

});

$(comic).click(function () {
    category = "comic";
    window.location.href = "shop.jsp?category=" + category;

});




function addToCart(bookId, elementId) {

    $.post("homeAPIs.jsp", {bookid: bookId, code: 10})
            .done(function (data) {
                console.log(data);

            })
            .fail(function (xhr, status, error) {
                console.error("Error saving book:", error);

            });
    document.getElementById(elementId).innerHTML = "added ";
}//addToCart method


function removeFromCart(elementId) {

    bookId = elementId.match(/\d+(\.\d+)?/g);
    bookId = parseInt(bookId);
    $.post("homeAPIs.jsp", {bookid: bookId, code: 20})
            .done(function (data) {
                removeDiv = "#div" + bookId;
                $(removeDiv).hide();
                updateTotalAmount();

            })
            .fail(function (xhr, status, error) {
                console.error("Error deleting book:", error);
            });


    count = "count" + bookId;
    document.getElementById(count).innerHTML = parseInt(document.getElementById(count).innerHTML) + 1;
    totalItemsId = "total";
    summaryId = "summary";
    count = "count" + bookId;
    countValue = document.getElementById(count).innerHTML;
    totalItems = document.getElementById(totalItemsId).innerHTML;
    document.getElementById(totalItemsId).innerHTML = parseInt(totalItems) + 1 - parseInt(countValue);
    document.getElementById(summaryId).innerHTML = parseInt(totalItems) + 1 - parseInt(countValue);

}//removefromcart method




function addItem(elementId) {

    bookId = elementId.match(/\d+(\.\d+)?/g);
    bookId = parseInt(bookId);
    $.post("homeAPIs.jsp", {bookid: bookId, code: 30})
            .done(function (data) {
                updateTotalAmount();

            })
            .fail(function (xhr, status, error) {
                console.error("Error adding item:", error);
            });

    count = "count" + bookId;
    document.getElementById(count).innerHTML = parseInt(document.getElementById(count).innerHTML) + 1;
    totalItemsId = "total";
    summaryId = "summary";
    totalItems = document.getElementById(totalItemsId).innerHTML;
    document.getElementById(totalItemsId).innerHTML = parseInt(totalItems) + 1;
    document.getElementById(summaryId).innerHTML = parseInt(totalItems) + 1;


}//addItem method


function removeItem(elementId) {


    bookId = elementId.match(/\d+(\.\d+)?/g);
    bookId = parseInt(bookId);
    count = "count" + bookId;
    items = parseInt(document.getElementById(count).innerHTML);
    if (items > 1) {
        $.post("homeAPIs.jsp", {bookid: bookId, code: 40})
                .done(function (data) {
                    updateTotalAmount();

                })
                .fail(function (xhr, status, error) {
                    console.error("Error removing item:", error);
                });

        document.getElementById(count).innerHTML = items - 1;
        totalItems = document.getElementById(totalItemsId).innerHTML;
        document.getElementById(totalItemsId).innerHTML = parseInt(totalItems) - 1;
        summaryId = "summary";
        document.getElementById(summaryId).innerHTML = parseInt(totalItems) - 1;


    }



}//removeItem method




function updateTotalAmount() {
    var xhr = new XMLHttpRequest();
    xhr.open('GET', 'homeAPIs.jsp?code=50', true);

    xhr.onload = function () {
        if (xhr.status === 200) {
            var response = xhr.responseText;

            var totalAmount = parseInt(response);
            var summaryId1 = "summaryprice1";
            var summaryId2 = "summaryprice2";
            document.getElementById(summaryId1).innerHTML = totalAmount;
            document.getElementById(summaryId2).innerHTML = totalAmount;

        } else {
            console.error('Error fetching data');
        }
    };

    xhr.send();
}//update total amount


function updateSales() {
    $.post("homeAPIs.jsp", {code: 60})
            .done(function (data) {
                if (data) {
                    alert();
                   
 

                }

            })
            .fail(function (xhr, status, error) {
                console.error("Error removing item:", error);
            });
}


$(document).ready(function () {
    summary = "#summary";
    totalItems = $(summary).html();
    if (totalItems < 1) {
        document.getElementById(checkOut).disabled = true;
    }
});


setInterval(function () {
    summary = "#summary";
    totalItems = $(summary).html();
    if (totalItems < 1) {
        document.getElementById(checkOut).disabled = true;
    }
}, 200);