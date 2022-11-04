let host = "http://localhost:8080/hfn/product";
const app = angular.module("myProduct", []);

//Xu li product tai trang Shop-4-Column
app.controller("menu", function($scope, $http, $window) {

    //Load du lieu cua tat ca product vao list
    $scope.load_list_product = function() {
        var url = `${host}/all`;
        $http.get(url).then(resp => {
            $scope.list_product = resp.data;
            console.log("List Sucess", resp);
        }).catch(error => {
            console.log("List Error", error);
        });
    };

    //Luu id product len session va chuyen huong den trang single-product
    $scope.saveIdProduct = function(id) {
        sessionStorage.setItem("idProduct", id);
        $window.location.href = 'single-product.html';
    }

    $scope.load_list_product();
});

//Xu li product tai trang Single-product
app.controller("detail", function($scope, $http, $window) {
    //Lay ma id product tu session
    var id = sessionStorage.getItem("idProduct");

    //Load du lieu cua product dua theo id da lay vao scope
    $scope.load_product = function() {
        var url = `${host}/${id}`;
        $http.get(url).then(resp => {
            $scope.product = resp.data;
            $scope.load_product_cate($scope.product.category.id);
            console.log("Product Sucess", resp);
        }).catch(error => {
            console.log("Product Error", error);
        });
    };

    //Load du lieu danh sach cac product cung the loai
    $scope.load_product_cate = function(id) {
        var url = `${host}/cate/${id}`;
        $http.get(url).then(resp => {
            $scope.list_product_cate = resp.data;
            console.log("Product Cate Sucess", resp);
        }).catch(error => {
            console.log("Product Cate Error", error);
        });
    };

    //Luu id product len session va chuyen huong den trang single-product
    $scope.saveIdProduct = function(id) {
        sessionStorage.setItem("idProduct", id);
        $window.location.href = 'single-product.html';
    }

    $scope.load_product();
});