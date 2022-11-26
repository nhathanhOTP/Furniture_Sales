let hostPr = "http://localhost:8080/hfn/product";
const appPr = angular.module("myProduct", []);

function setCookie(cname, cvalue, exdays) {
    const d = new Date();
    d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
    let expires = "expires=" + d.toUTCString();
    document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
}

function getCookie(cname) {
    let name = cname + "=";
    let ca = document.cookie.split(';');
    for (let i = 0; i < ca.length; i++) {
        let c = ca[i];
        while (c.charAt(0) == ' ') { c = c.substring(1); }
        if (c.indexOf(name) == 0) {
            return c.substring(name.length, c.length);
        }
    }
    return "";
}

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

        $scope.logout= function(){
            localStorage.setItem("user",null);
            alert("Logout Successfully!");
            $window.location.reload();
        }

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

        $scope.user = JSON.parse(localStorage.getItem("user"));
        //Add to favourite list
        $scope.addToFav = function(idPr, name, image) {
            if ($scope.user == null || $scope.user == undefined) {
                $scope.checkAddFV = false;
                alert("Please login with your account!");
                window.location.href = "login.html";
            } else {
                $http.get(`http://localhost:8080/hfn/favour/checkExist/${idPr}`).then(resp => {
                    $scope.rs = resp.data;
                    console.log("list idPr ", resp.data);
                    if ($scope.rs == true) {
                        $scope.checkAddFV = true;
                        var item = {
                            account: {
                                username: $scope.user.username
                            },
                            product: {
                                id: idPr
                            }
                        };
                        $http.post(`http://localhost:8080/hfn/favour/add`, item).then(resp => {
                            $scope.productMessage = resp.data;
                            console.log("Add Fav Sucess", resp);
                        }).catch(error => {
                            console.log("Add Fav Error", error);
                        });
                    } else {
                        $scope.productImage = image;
                        $scope.productName = name;
                        $scope.checkAddFV = false;
                    }
                }).catch(error => {
                    console.log("list idPr ", error);
                });

            }

        }

        $scope.load_list_product();

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

        $scope.searchData = function() {
            if ($scope.search != undefined) {
                $http.get(`${host_NhaThanh}/search/products/${$scope.search}`).then(resp => {
                    $scope.list_product = resp.data;
                    if (resp.data == '' || resp.data != null || resp.data != undefined) {
                        setCookie("search", $scope.list_product[0].category.id, 10);
                    }
                });
            }
        }
        $scope.suggest = function() {
            var value = getCookie("search");
            if (value != undefined || value != '') {
                $http.get(`${host_NhaThanh}/hfn/product/cate/${value}`).then(resp => {
                    $scope.suggestForUser = resp.data;
                    for (let i = 0; i < $scope.suggestForUser.length; i++) {
                        if (i == 8) {
                            var index = $scope.bdays.indexOf($scope.suggestForUser[i]);
                            $scope.suggestForUser.splice(index, 1);
                        }
                    }
                });
            }
        };
        $scope.suggest();

    }
);