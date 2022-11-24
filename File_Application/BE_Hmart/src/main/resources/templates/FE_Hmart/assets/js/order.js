let hostPr = "http://localhost:8080/hfn/product";
let hostOd = "http://localhost:8080/hfn/order";
const appOd = angular.module("myOrder", []);
var host_NhaThanh = "http://localhost:8080";
var voucher = false;

appOd.controller("order", function($scope, $http, $window) {
    $scope.theTime = {};
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

    //Load du lieu cua account vao form info
    $scope.load_account = function() {
        var user = JSON.parse(localStorage.getItem("user"));
        if (user == null || user == undefined) {
            window.location.href = "login.html";
        }
        var url = `http://localhost:8080/hfn/Account/${user.username}`;
        $http.get(url).then(resp => {
            $scope.account_info = resp.data;
            console.log("Load Account Sucess", resp);
        }).catch(error => {
            console.log("Load Account Error", error);
        });
    };
    $scope.load_account();

    $scope.order_info = {};
    $scope.idDiscount = '';
    //Luu du lieu order_info vao backend
    $scope.save_order = function() {
        var url = `${hostOd}/save`;
        $scope.order_info.account = $scope.account_info;
        $scope.order_info.amount = $scope.amountOrder;
        var order = $scope.order_info;

        //Save The time used of user if user use discount
        if (voucher == true) {
            $scope.setValueTheTimeUsedOfUser();
        }
        //-----------------------------------------------//
        $http.post(url, order).then(resp => {
            console.log("Save Order Sucess", resp);
            $scope.save_orderDetail(resp.data);
        }).catch(error => {
            console.log("Save Order Error", error);
            alert('Error! Please try again later!');
        });
    };
    //Set value for the time used of user
    $scope.setValueTheTimeUsedOfUser = function() {
        $http.get(`${host_NhaThanh}/getNumberOfUser/${$scope.theTime.username}`).then(resp => {
            $scope.theTime.amountDiscount = $scope.amountOrder;
            $scope.theTime.account = $scope.account_info;
            $scope.theTime.discount = $scope.voucher;
            $scope.saveTheTimeUsedOfUser();
        });
    };
    //Save the time used of user
    $scope.saveTheTimeUsedOfUser = function() {
        $http.post(`${host_NhaThanh}/create/theTime`, $scope.theTime).then(resp => {
            console.log(resp.data + " save use of user successfully!");
        }).catch(error => {
            console.log(error);
        });
    }


    //Post du lieu cart vao backend de luu vao Order Detail
    $scope.save_orderDetail = function(orderId) {
        var url = `http://localhost:8080/hfn/OrderDetail/save/${orderId}`;
        var item = $scope.cart.items;
        $http.post(url, item).then(resp => {
            console.log("Save OrderDetail Sucess", resp);
            alert('Order succesfull!');
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
        //Discount
    $scope.amountOrder = $scope.cart.amount;
    $scope.aplly = function() {
        if ($scope.codeDiscount !== undefined || $scope.codeDiscount !== '' || $scope.codeDiscount !== null) {
            $http.get(`${host_NhaThanh}/getDiscount/codeDiscount/${$scope.codeDiscount}`).then(resp => {
                $scope.voucher = resp.data;
                console.log($scope.voucher);
                console.log($scope.cart.items);
                var checkDiscountOfProduct = false;
                for (let i = 0; i < $scope.cart.items.length; i++) {
                    if ($scope.cart.items[i].id == $scope.voucher.product.id) {
                        checkDiscountOfProduct = true;
                        $scope.DiscountAmount = undefined;
                        voucher = false;
                    }
                }
                if (checkDiscountOfProduct == false) {
                    alert("Your order can't apply this discount!");
                    checkDiscountOfProduct = false;
                } else {
                    if (resp.data.idDiscount !== undefined) {
                        //Check the number of times used of user
                        //Get the number of times used of user
                        var username = $scope.account_info.username;
                        var idDiscount = $scope.voucher.idDiscount;
                        $http.get(`${host_NhaThanh}/getNumberOfUser/${username}/${idDiscount}`).then(resp => {
                            var numberUsed = resp.data;
                            if (numberUsed > $scope.voucher.conditions.numberOfUses) {
                                alert("The discount code is no longer working for you!");
                            } else {
                                voucher = true;
                                $scope.idDiscount = resp.data.idDiscount;
                                //Check the request quantity(quantity products)
                                if ($scope.voucher.conditions.quantity > $scope.cart.items.length) {
                                    alert("Orders must have a minimum of " + $scope.voucher.quantity + " products will apply!");
                                    //If amount order more than conditions of discount remind user
                                } else if ($scope.voucher.conditions.contents > $scope.amountOrder) {
                                    //Get the right price when using the promo code
                                    alert("Your order is not eligible to use this promo code! Minimum order " + $scope.voucher.conditions.contents + " will apply!");
                                } else {
                                    //Display discount form on Fontend
                                    $scope.discountForm = $scope.voucher.discountForm;
                                    //If value false discount cash product
                                    if ($scope.discountForm == false) {
                                        $scope.valueDiscount = $scope.voucher.valuedecrease;
                                        $scope.DiscountAmount = ($scope.cart.amount - $scope.valueDiscount);
                                        $scope.amountOrder = $scope.DiscountAmount;
                                    } else {
                                        //Original price x [(100 –  % Discount)/100]
                                        $scope.valueDiscount = $scope.voucher.valuedecrease;
                                        $scope.DiscountAmount = $scope.cart.amount * [(100 - $scope.valueDiscount) / 100];
                                        $scope.amountOrder = $scope.DiscountAmount;
                                    }
                                }
                            }
                        });

                    } else {
                        alert("Mã khuyến mãi không tồn tại thử lại sau!");
                        $scope.DiscountAmount = undefined;
                        voucher = false;
                    }
                }

                console.log(resp.data);
            }).catch(error => {
                console.log(error);
                voucher = false;
            })
        }
    }

});