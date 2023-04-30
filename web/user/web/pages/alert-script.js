


 

function alert() {
    swal({
        title: "Order Placed",
        text: "",
        icon: "success",
        buttons: {
            confirm: "Okay"
        },
        closeOnClickOutside: false
         }).then(function () {
 
        window.location.href = "home.jsp"; // Redirect to home page
    });
}
