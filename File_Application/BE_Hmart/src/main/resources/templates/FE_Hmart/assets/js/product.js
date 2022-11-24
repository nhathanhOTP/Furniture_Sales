let hostPr = "http://localhost:8080/hfn/product";
const appPr = angular.module("myProduct", []);
var username = "tpph0503";
//Xu li menu
appPr.controller("product",
    function($scope, $http, $window, $timeout) {
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

        //Xu li product tai trang Shop-4-Column
        //Load du lieu cua tat ca product vao list
        $scope.load_list_product = function() {
            var idCate = sessionStorage.getItem("idCategory");
            if (idCate == null || idCate == 'null' || idCate == undefined) {
                var url = `${hostPr}/getAll`;
            } else {
                var url = `${hostPr}/cate/${idCate}`;
            }

            $http.get(url).then(resp => {
                $scope.list_product = resp.data;
                console.log("List Product Sucess", resp);
            }).catch(error => {
                console.log("List Product Error", error);
            });
        };

        //Luu id product len session va chuyen huong den trang single-product
        $scope.saveIdProduct = function(id) {
            sessionStorage.setItem("idProduct", id);
            $window.location.href = 'single-product.html';
        }

        $scope.load_list_idProFav = function() {
            $http.get(`http://localhost:8080/hfn/favour/checkExist/${username}`).then(resp => {
                $scope.list_idProFav = resp.data;
                console.log("list idPr ", resp.data);
            }).catch(error => {
                console.log("Load list id Product favour ", error);
            });
        }

        $scope.checkExist = function(idPr) {
            $scope.list_idProFav.forEach(e => {
                if (e == idPr) {
                    return false;
                }
            });
            return true;
        }

        //var username = localStorage.getItem("user");

        //Add to favourite list
        $scope.addToFav = function(idPr) {
            var user = JSON.parse(localStorage.getItem("user"));
            if (user == null || user == undefined) {
                alert("Please login with your account!");
                window.location.href = "login.html";
            } else {
                var item = {
                    account: {
                        username: user.username
                    },
                    product: {
                        id: idPr
                    }
                };
                $http.post(`http://localhost:8080/hfn/favour/add`, item).then(resp => {
                    $scope.productMessage = resp.data;
                    $scope.load_list_idProFav();
                    console.log("Add Fav Sucess", resp);
                }).catch(error => {
                    console.log("Add Fav Error", error);
                });
            }
        }

        $scope.load_list_idProFav();
        $timeout(function() {
            $scope.load_list_product();
        }, 1000);


        $scope.clearWhenInCart = function() {
            $scope.cart.clear();
            $window.location.href = 'empty-cart.html';
        }

        $scope.checkQuantity = false;
        //Load du lieu cua cart
        $scope.cart = {
            items: [],
            add(id) {
                var item = this.items.find(item => item.id == id);
                if (item) {
                    item.quantity++;
                    console.log(item);
                    if (item.quantity > item.productQty) {
                        item.quantity = item.productQty;
                        $scope.checkQuantity = false;
                    } else {
                        this.saveToLocalStorage();
                        $scope.checkQuantity = true;
                    }
                } else {
                    $http.get(`http://localhost:8080/hfn/item/${id}`).then(resp => {
                        resp.data.quantity = 1;
                        $scope.productMessage = resp.data;
                        this.items.push(resp.data);
                        this.saveToLocalStorage();
                        $scope.checkQuantity = true;
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
    }
);