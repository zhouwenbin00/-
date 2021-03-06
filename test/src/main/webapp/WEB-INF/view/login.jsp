<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>图书管理系统-登陆</title>
    <script src="js/jquery-easyui-1.7.0/jquery.min.js"></script>
    <script src="js/jquery-easyui-1.7.0/jquery.easyui.min.js"></script>
    <link rel="stylesheet" href="js/jquery-easyui-1.7.0/themes/default/easyui.css">
    <link rel="stylesheet" href="js/jquery-easyui-1.7.0/themes/icon.css">
    <script src="js/jquery-easyui-1.7.0/locale/easyui-lang-zh_CN.js"></script>
    <link rel="stylesheet" href="css/lms.css">
</head>
<body>
<div id="layoutID" class="easyui-layout" data-options="fit:true" style="background: #E9F1FC;height: 100%">
    <!-- 北-->
    <div data-options="region:'north',border:true"
         style="height:80px;background: #8ABDF2;color: #005EAD;">
        <!-- 大标题-->
        <div style="position: absolute;left: 100px;padding: auto 0px;"><h1>图书管理系统</h1></div>
    </div>
    <!-- 中-->
    <div data-options="region:'center',border:false" style="background:url('images/login-image.jpg')  repeat ;">
        <!-- 登陆面板-->
        <div id="login_windows" class="easyui-window" title="用户登陆"
             style="width:390px;height:350px;background:#fafafa;padding: 20px;background:url('images/form-bg.png');"
             data-options="">
            <!-- from表单-->
            <form id="ff" method="post" style="margin-top: 100px">
                <div style="margin-bottom:10px;">
                    <input class="easyui-textbox" id="logname" style="width:100%;height:30px;padding:12px"
                           data-options="prompt:'用户',iconCls:'icon-man',iconWidth:38,iconAlign:'left'   ">
                </div>
                <div style="margin-bottom:20px">
                    <input class="easyui-textbox" id="logpass" type="password"
                           style="width:100%;height:30px;padding:12px"
                           data-options="prompt:'密码',iconCls:'icon-lock',iconWidth:38,iconAlign:'left'">
                </div>
                <div style="margin-bottom:20px">
                    <input type="checkbox" checked="checked" id="logrem">
                    <span>记住密码</span>
                </div>
                <div>
                    <a href="javascript:;" onclick="dologin()" class="easyui-linkbutton"
                       data-options="iconCls:'icon-ok'" style="padding:5px 0px;width:100%;">
                        <span style="font-size:14px;">登录</span>
                    </a>
                </div>
            </form>
        </div>
    </div>
    <!-- 底部-->
    <div data-options="region:'south',border:false" style="height:50px;background: #E9F1FC;text-align:center;line-height:50px;">
        <span style="color:#999999;">出于安全考虑，一旦您访问过那些需要您提供凭证信息的应用时，请操作完成之后关闭浏览器。</span>
    </div>
</div>
<script>
    $(function(){
        //cookie数据保存格式是key=value;key=value;形式，loginInfo为保存在cookie中的key值，具体看controller代码
        var str = getCookie("loginInfo");
        str = str.substring(1,str.length-1);
        var username = str.split(",")[0];
        var password = str.split(",")[1];
        console.log(str);
        //自动填充用户名和密码
        $("#logname").textbox("setValue",username);
        $("#logpass").textbox("setValue",password);
        //获取cookie
        function getCookie(cname) {
            var name = cname + "=";
            var ca = document.cookie.split(';');
            for(var i=0; i<ca.length; i++) {
                var c = ca[i];
                while (c.charAt(0)==' ') c = c.substring(1);
                if (c.indexOf(name) != -1) return c.substring(name.length, c.length);
            }
            return "";
        }
    });
    <!-- 登陆窗口的设置-->
    $('#login_windows').window({
        collapsible: false,
        minimizable: false,
        maximizable: false,
        closable: false,//关闭按钮
        draggable: true, /*拖拽*/
        resizable: false,//可改变大小
        closed: false,//可关闭
        left: 800,
        top: 150
    })
    function dologin(){
        var logname= $('#logname').val();
        var logpass= $('#logpass').val();
        var logrem= $('#logrem').val();
        if (logname==""||logpass==""){
            $.messager.alert('提示','请输入用户名和密码!');
            return;
        }
        $.post("toLogin",{username:logname,password:logpass,remember:logrem},function (date) {
            if (date.code=="200") {
                location.href = "index";
            }else {
                $.messager.alert('提示','用户名或者密码错误!');
            }
        });
    }
</script>
</body>
</html>