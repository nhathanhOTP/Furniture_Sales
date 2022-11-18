let hostPr = "http://localhost:8080/hfn/product";
const appPr = angular.module("myProduct", []);

//Xu li menu
appPr.controller("product",
    function($scope, $http, $window) {
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
            if (idCate == null || idCate == 'null') {
                var url = `${hostPr}/getAll`;
            } else {
                var url = `${hostPr}/cate/${idCate}`;
            }

            $http.get(url).then(resp => {
                $scope.list_product = resp.data;
                // $scope.list_product.forEach(e => {
                //     if (e.available == true) {
                //         e.remove();
                //     }
                // });
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

        var username = "tpph0503";

        //Add to favourite list
        $scope.addToFav = function(idPr) {
            var item = {
                account: {
                    username: username
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
        }

        $scope.load_list_product();
        $scope.clearWhenInCart = function() {
            $scope.cart.clear();
            $window.location.href = 'empty-cart.html';
        }

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

//Xu li product tai trang Single-product
appPr.controller("detail", function($scope, $http, $window) {
    //Lay ma id product tu session
    var id = sessionStorage.getItem("idProduct");

    //Load du lieu cua product dua theo id da lay vao scope
    $scope.load_product = function() {
        var idPr = sessionStorage.getItem("idProduct");
        if (idPr == null || idPr == 'null') {
            $window.location.href = 'shop-4-column.html';
        } else {
            var url = `${hostPr}/${id}`;
            $http.get(url).then(resp => {
                $scope.product = resp.data;
                $scope.load_product_cate($scope.product.category.id);
                console.log("Product Sucess", resp);
            }).catch(error => {
                console.log("Product Error", error);
            });
        }
    };

    //Load du lieu danh sach cac product cung the loai
    $scope.load_product_cate = function(id) {
        var url = `${hostPr}/cate/${id}`;
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