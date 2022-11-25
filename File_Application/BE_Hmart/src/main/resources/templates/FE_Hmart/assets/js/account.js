let hostSg = "http://localhost:8080/hfn/Account";
const appSg = angular.module("myAccount", []);

function readURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();

        reader.onload = function(e) {
            $('#avatarProfile').attr('src', e.target.result);
        }

        reader.readAsDataURL(input.files[0]);
    }
}

$("#imgInpProfile").change(function() {
    readURL(this);
});

//Xu li product tai trang Single-product
appSg.controller("account", function($scope, $http, $window) {

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

    var user = JSON.parse(localStorage.getItem("user"));

    $scope.load_profile = function() {
        if (user == null || user == undefined) {
            window.location.href = "login.html";
            alert("Please login with your account!");
        } else {
            var url = `${hostSg}/${user.username}`;
            $http.get(url).then(resp => {
                $scope.account = resp.data;
                console.log("Sucess", resp);
            }).catch(error => {
                console.log("Error", error);
            });
        }
    };

    $scope.update_profile = function() {
        var item = angular.copy($scope.account);
        $scope.confirm;
        if($scope.confirm == item.password){
            if (image != null) {
                var name = image.name;
            } else {
                var name = $scope.account.image;
            }
            var url = `${hostSg}/updateProfile/${name}`;
            console.log("Hinh: ",name);
            $http.put(url, item).then(resp => {
                $scope.account = resp.data;
                $scope.upload();
                alert("Cập Nhật Thành Công!");
            }).catch(error => {
                console.log("Error", resp);
                alert("Cập Nhật Thất Bại!");
            });
        }else{
            alert("The Confirm Password Is Not Correct!")
        }
    };

    var image;
    $scope.upload = function() {
        if (image != null) {
            var url = `${hostSg}/upload`;
            var form = new FormData();
            form.append("file", image);
            $http.put(url, form, {
                transformRequest: angular.identity,
                headers: { 'Content-type': undefined }
            }).then(resp => {
                console.log("Success", resp);
                $window.location.reload();
            }).catch(error => {
                console.log("Error", resp);
            });
        }
    }

    $scope.fileUp = function(file) {
        image = file[0];
    }

    $scope.load_profile();
});