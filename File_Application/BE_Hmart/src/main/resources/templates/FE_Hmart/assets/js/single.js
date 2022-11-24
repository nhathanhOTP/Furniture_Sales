let hostSg = "http://localhost:8080/hfn/product";
const appSg = angular.module("myDetail", []);
let hostNhaThanh = "http://localhost:8080";

function getImages() {

}
//Xu li product tai trang Single-product
appSg.controller("detail", function($scope, $http, $window) {

    //Xu li menu
    //Load du lieu cua tat ca category vao list
    $scope.load_list_cate = function() {
        var url = `http://localhost:8080/hfn/categories/getAll`;
        $http.get(url).then(resp => {
            $scope.list_cate = resp.data;
            console.log("List Cate Sucess", resp);
        }).catch(error => {
            console.log("List Cate Error", error);
        });
    };

    //Luu id category len session
    $scope.saveIdCategory = function(id) {
        if (id == 'null') {
            sessionStorage.setItem("idCategory", null);
        } else {
            sessionStorage.setItem("idCategory", id);
        }
        $window.location.href = 'shop-4-column.html';
    }

    $scope.load_list_cate();

    //Lay ma id product tu session
    var id = sessionStorage.getItem("idProduct");

    //Load du lieu cua product dua theo id da lay vao scope
    $scope.load_product = function() {
        var idPr = sessionStorage.getItem("idProduct");
        if (idPr == null || idPr == 'null') {
            $window.location.href = 'shop-4-column.html';
        } else {
            var url = `${hostSg}/${id}`;
            $http.get(url).then(resp => {
                $scope.product = resp.data;
                $scope.load_product_cate($scope.product.category.id);
                console.log("Product Sucess", resp);
                $http.get(`${hostNhaThanh}/get/sub/images/${$scope.product.image}`).then(resp => {
                    $scope.subImage = resp.data;
                });
            }).catch(error => {
                console.log("Product Error", error);
            });
        }
    };

    //Load du lieu danh sach cac product cung the loai
    $scope.load_product_cate = function(id) {
        var url = `${hostSg}/cate/${id}`;
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
    $scope.productQty = 1;
    //Load du lieu cua cart
    $scope.cart = {
        items: [],
        add(id) {
            var item = this.items.find(item => item.id == id);
            if (item) {
                item.quantity++;
                this.saveToLocalStorage();
            } else {
                $http.get(`http://localhost:8080/hfn/item/${id}`).then(resp => {
                    resp.data.quantity = 1;
                    $scope.productMessage = resp.data;
                    this.items.push(resp.data);
                    this.saveToLocalStorage();
                })
            }
        },
        addWithQty(id) {
            var item = this.items.find(item => item.id == id);
            if (item) {
                item.quantity += $scope.productQty;
                if (item.quantity > item.productQty) {
                    item.quantity = item.productQty;
                    alert("The product is only " + item.productQty);
                } else {
                    this.saveToLocalStorage();
                    alert("Add Sucessfull!");
                }
            } else {
                $http.get(`http://localhost:8080/hfn/item/${id}`).then(resp => {
                    resp.data.quantity = $scope.productQty;
                    $scope.productMessage = resp.data;

                    this.items.push(resp.data);
                    this.saveToLocalStorage();
                    alert("Add Sucessfull!");
                });
            }

        },
        update(id, quantity) {
            var item = this.items.find(item => item.id == id);
            item.quantity = quantity;
            this.saveToLocalStorage();
        },

        remove(id) {
            var index = this.items.findIndex(item => item.id == id);
            this.items.splice(index, 1);
            this.saveToLocalStorage();
        },

        clear() {
            this.items = [];
            this.saveToLocalStorage();
        },

        gamt_of(id) {},

        get count() {
            return this.items
                .map(item => item.quantity)
                .reduce((total, quantity) => total += quantity, 0);
        },

        get amount() {
            return this.items
                .map(item => item.quantity * item.price)
                .reduce((total, quantity) => total += quantity, 0);
        },

        saveToLocalStorage() {
            var json = JSON.stringify(angular.copy(this.items));
            localStorage.setItem("cart", json);
        },

        loadFormLocalStorage() {
            var json = localStorage.getItem("cart");
            this.items = json ? JSON.parse(json) : [];
            console.log(this.items);
        }
    };

    $scope.cart.loadFormLocalStorage();

    //Method cut value colors
    $scope.cutValueColors = function(value) {
        var ds = [];
        var start = 0;
        var chart = "";
        if (value != undefined) {
            for (var i = 0; i < value.length; i++) {
                if (value.charAt(i) == '+') {
                    chart = value.substring(start, i++);
                    ds.push(chart.trim());
                    start = i;
                }
            }
        }
        return ds;
    }
});