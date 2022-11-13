let hostList = "http://localhost:8080/hfn/order";
const appList = angular.module("myList", []);

//Xu li menu
appList.controller("list", function($scope, $http, $window) {
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

    //Load du lieu cua tat ca order vao list theo username
    $scope.load_admin_list_order = function() {
        var url = `${hostList}/getAll`;
        $http.get(url).then(resp => {
            $scope.admin_list_order = resp.data;
            console.log("List Order Sucess", resp);
        }).catch(error => {
            console.log("List Order Error", error);
        });
    };
    $scope.load_admin_list_order();

    //Load du lieu cua tat ca order vao list theo username
    var username = 'tpph0503';
    $scope.load_list_order = function() {
        var url = `${hostList}/user/${username}`;
        $http.get(url).then(resp => {
            $scope.list_order = resp.data;
            console.log("List Order Sucess", resp);
        }).catch(error => {
            console.log("List Order Error", error);
        });
    };
    $scope.load_list_order();

    $scope.load_orderDetail = function(id) {
        var url = `${hostList}/detail/${id}`;
        $http.get(url).then(resp => {
            $scope.order = resp.data;
            console.log("Order Sucess", resp);
            $scope.load_list_orderDetail(id);
        }).catch(error => {
            console.log("Order Error", error);
        });
    }

    $scope.load_list_orderDetail = function(id) {
        var url = `${hostList}/listDetail/${id}`;
        $http.get(url).then(resp => {
            $scope.list_orderDetail = resp.data;
            console.log("List OrderDetail Sucess", resp);
        }).catch(error => {
            console.log("List OrderDetail Error", error);
        });
    };

    $scope.updateStatusCancel = function(id) {
        var url = `${hostList}/update/${id}`;
        var status = 4;
        $http.put(url, status).then(resp => {
            $scope.order = resp.data;
            console.log("Update Sucess", resp);
            $scope.load_list_order();
            alert("Cancel sucessfull!");
        }).catch(error => {
            console.log("Update Error", error);
        });
    };

    $scope.updateStatusDone = function(id) {
        var url = `${hostList}/update/${id}`;
        var status = 3;
        $http.put(url, status).then(resp => {
            $scope.order = resp.data;
            console.log("Update Sucess", resp);
            $scope.load_list_order();
            alert("Cancel sucessfull!");
        }).catch(error => {
            console.log("Update Error", error);
        });
    };

    $scope.updateStatusConfirm = function(id) {
        var url = `${hostList}/update/${id}`;
        var status = 2;
        $http.put(url, status).then(resp => {
            $scope.order = resp.data;
            console.log("Update Sucess", resp);
            $scope.load_list_order();
            alert("Cancel sucessfull!");
        }).catch(error => {
            console.log("Update Error", error);
        });
    };

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
});