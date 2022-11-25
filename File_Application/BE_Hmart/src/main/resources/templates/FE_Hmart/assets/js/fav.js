let hostFv = "http://localhost:8080/hfn/favour";
const appFv = angular.module("myFav", []);

//Xu li menu
appFv.controller("favourite", function($scope, $http, $window) {
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

    $scope.load_list_cate();

    //Luu id category len session
    $scope.saveIdCategory = function(id) {
        if (id == 'null') {
            sessionStorage.setItem("idCategory", null);
        } else {
            sessionStorage.setItem("idCategory", id);
        }
        $window.location.href = 'shop-4-column.html';
    }

    //Luu id product len session va chuyen huong den trang single-product
    $scope.saveIdProduct = function(id) {
        sessionStorage.setItem("idProduct", id);
        $window.location.href = 'single-product.html';
    }

    var user = JSON.parse(localStorage.getItem("user"));
    //Load add fav list
    $scope.load_list_fav = function() {
        if (user == null || user == undefined) {
            window.location.href = "login.html";
            alert("Please login with your account!");
        } else {
            var url = `${hostFv}/user/${user.username}`;
            $http.get(url).then(resp => {
                $scope.list_fav = resp.data;
                console.log("List Fav Sucess", resp);
            }).catch(error => {
                console.log("List Fav Error", error);
            });
        }
    };

    //Xoa fav khoi list
    $scope.deleteFav = function(id) {
        var url = `${hostFv}/delete/${id}`;
        $http.get(url).then(resp => {
            console.log("Del Fav Sucess", resp);
            alert("Delete Successfully!");
            $window.location.reload();
        }).catch(error => {
            console.log("Del Fav Error", error);
        });
    };

    $scope.load_list_fav();

    //Load du lieu cua cart
    $scope.cart = {
        items: [],
        add(id) {
            var item = this.items.find(item => item.id == id);
            if (item) {
                item.quantity++;
                if (item.quantity > item.productQty) {
                    item.quantity = item.productQty;
                    alert("The products just left " + item.productQty + "!");
                } else {
                    this.saveToLocalStorage();
                    alert("Add to cart successfully!");
                }
            } else {
                $http.get(`http://localhost:8080/hfn/item/${id}`).then(resp => {
                    resp.data.quantity = 1;
                    $scope.productMessage = resp.data;
                    this.items.push(resp.data);
                    this.saveToLocalStorage();
                    alert("Add to cart successfully!");
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

        gamt_of(_id) {},

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
});