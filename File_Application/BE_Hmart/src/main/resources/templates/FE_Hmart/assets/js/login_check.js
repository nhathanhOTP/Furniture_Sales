const app = angular.module("admin", []);
var host_NhaThanh = "http://localhost:8080";
//Login
app.controller("login", function($scope, $http) {
    $scope.loadAll = function() {
        $http.get(`${host_NhaThanh}/hfn/Account/getAll`).then(resp => {
            console.log(resp.data);
        })
    }
    $scope.loadAll();
    $scope.login = function(user) {
        $http.get(`${host_NhaThanh}/hfn/Account/${user.username}`).then(resp => {
            var data = resp.data;
            console.log(user);
            if (data.username === user.username) {
                if (data.password != user.password) {
                    alert("Password not correct try again!");
                } else {
                    alert("Login successfully!");
                    data.password = "**********";
                    localStorage.setItem("user", JSON.stringify(data));
                    $scope.user = data;
                    window.location.href = "shop-4-column.html";
                }
            } else {
                alert("Your account not correct, try again!");
            }
        })
    }
});