let hostPr = "http://localhost:8080/hfn/product";
let hostOd = "http://localhost:8080/hfn/order";
const appOd = angular.module("myOrder", []);

appOd.controller("order", function($scope, $http, $window) {

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

    var username = "tpph0503";
    //Load du lieu cua account vao form info
    $scope.load_account = function() {
        var url = `http://localhost:8080/hfn/Account/${username}`;
        $http.get(url).then(resp => {
            $scope.account_info = resp.data;
            console.log("Load Account Sucess", resp);
        }).catch(error => {
            console.log("Load Account Error", error);
        });
    };
    $scope.load_account();

    $scope.order_info = {};

    //Luu du lieu order_info vao backend
    $scope.save_order = function() {
        var url = `${hostOd}/save`;
        $scope.order_info.account = $scope.account_info;
        var order = $scope.order_info;
        $http.post(url, order).then(resp => {
            console.log("Save Order Sucess", resp);
            //Remove quantity of products

            $scope.save_orderDetail(resp.data);
        }).catch(error => {
            console.log("Save Order Error", error);
            alert('Error! Please try again later!');
        });
    };

    //Post du lieu cart vao backend de luu vao Order Detail
    $scope.save_orderDetail = function(orderId) {
        var url = `http://localhost:8080/hfn/OrderDetail/save/${orderId}`;
        var item = $scope.cart.items;
        $http.post(url, item).then(resp => {
            console.log("Save OrderDetail Sucess", resp);
            alert('Succesfull!');
            $scope.cart.clear();
            $window.location.href = 'thank-you-page.html';
        }).catch(error => {
            console.log("Save OrderDetail Error", error);
            alert('Error! Please try again later!');
        });
    };

    //Load du lieu cua cart
    var modalCart = document.getElementById("Modal-Cart");
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

    $scope.load_list_cate();
    $scope.cart.loadFormLocalStorage();

    // File by Nha Thanh
    $http.get("/File_Local/JSON/local.json").then(function(d) {
        $scope.local = d.data;
        console.log($scope.local);
    });
    var tp, quan, phuong, duong;
    // Method use for distrist combobox
    $scope.getCty = function(value) {
        $scope.districts = $scope.local[value].districts;
        $scope.ctyId = value;

        $scope.wards = [];
        $scope.streets = [];
        tp = "TP " + $scope.local[value].name;
        $scope.order_info.address = tp;
    };
    // // Method use for cty combobox
    $scope.getDistricts = function(value) {
        disId = value;
        $scope.loadWard_Streets($scope.ctyId, disId);


    };

    $scope.loadWard_Streets = function(cty, dis) {
        $scope.wards = $scope.local[cty].districts[dis].wards;
        $scope.streets = $scope.local[cty].districts[dis].streets;
        quan = ", " + $scope.districts[dis].name; + ", ";
        $scope.order_info.address = tp + quan;
    }
    $scope.getWard = function(value1, value2) {
        phuong = value1 + " " + value2;
        $scope.order_info.address = tp + quan + ", " + phuong;
    }
    $scope.getStreet = function(value1, value2) {
        duong = value1 + " " + value2;
        $scope.order_info.address = tp + quan + ", " + phuong + ", " + duong + ".";
    }

});