/**
 * Created by Administrator on 2017/3/29 0029.
 */
//验证用户注册
function checkUser(){
    var regUserName = document.getElementsByName("regUserName")[0].value;
    var regPassword = document.getElementsByName("regPassword")[0].value;
    var confirmPassword = document.getElementsByName("confirmPassword")[0].value;

    /*
    if(regUserName == "") {
        alert("用户名不能为空");
        document.getElementsByName("regUserName")[0].focus();
        return false;
    }
    if(regPassword == "") {
        alert("密码不能为空");
        document.getElementsByName("regPassword")[1].focus();
        return false;
    }
    */

    if(regPassword != confirmPassword) {
        alert("两次输入密码不同");
        document.getElementsByName("confirmPassword")[0].focus();
        return false;
    }
}
