<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link href="/js/kindeditor-4.1.10/themes/default/default.css"
	type="text/css" rel="stylesheet">
<script type="text/javascript" charset="utf-8"
	src="/js/kindeditor-4.1.10/kindeditor-all-min.js"></script>
<script type="text/javascript" charset="utf-8"
	src="/js/kindeditor-4.1.10/lang/zh_CN.js"></script>

<div style="padding: 10px 10px 10px 10px">
	<form id="itemAddForm" class="itemForm" method="post">
		<table cellpadding="5">

			<tr>
				<td>视频标题：</td>
				<td><input id="title" class="easyui-textbox" type="text"
					name="title" data-options="required:true" style="width: 280px;"></input></td>
			</tr>
			<tr>
				<td>适用年级：</td>
				<td><select id="selece-grade" name="grade"
					style="width: 200px;">
						<option value="七年级上">七年级上</option>
						<option value="七年级下">七年级下</option>
						<option value="八年级上">八年级上</option>
						<option value="八年级下">八年级下</option>
						<option value="九年级上">九年级上</option>
						<option value="九年级下">九年级下</option>
						<option value="高一上">高一上</option>
						<option value="高一下">高一下</option>
						<option value="高二上">高二上</option>
						<option value="高二下">高二下</option>
						<option>高三上</option>
						<option>高三下</option>
				</select></td>
			</tr>

			<tr id="select-tr">
				<td>科目：</td>
				<td><select id="select-course" name="course"
					style="width: 200px;">
						<option value="Chinese" name="Chinese">语文</option>
						<option value="数学">数学</option>
						<option value="英语">英语</option>
						<option value="物理">物理</option>
						<option value="化学">化学</option>
						<option value="生物">生物</option>
						<option value="地理">地理</option>
						<option value="历史">历史</option>
						<option value="政治">政治</option>
				</select></td>

			</tr>
			<tr>
				<td>所属知识点：</td>
				<td><input id="knowledge" class="easyui-textbox" type="text"
					name="knowledge" data-options="required:true" style="width: 280px;"></input></td>
			</tr>
			<tr>
				<td>上传视频：</td>
				<td><label for="upload_video">上传视频</label> <input type="file"
					id="upload_video" class="take-video" accept="video/*"
					style="position: absolute; clip: rect(0, 0, 0, 0); width: 0px; height: 0px"></td>
			</tr>
		</table>
		<input type="hidden" name="itemParams" />
	</form>
	<div style="padding: 5px">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			onclick="submitForm()">提交</a> <a href="javascript:void(0)"
			class="easyui-linkbutton" onclick="clearForm()">重置</a>
	</div>
	<div id="content">
		<p class="_p">
			<span>视频标题</span>：<input id="title" type="text" class="form-control"
				placeholder="请输入视频名称">
		</p>
		<p class="_p">
			<span>选择视频： </span>
			<!--文件选择按钮-->
			<a class="list" href="javascript:;"> <input id="file" type="file"
				name="myfile" onchange="UpladFile();" /><span>选择视频</span>
			</a>
			<!--上传速度显示-->
			<span id="time"></span>
		</p>
		<!--显示消失-->
		<ul class="el-upload-list el-upload-list--text" style="display: none;">
			<li tabindex="0" class="el-upload-list__item is-success"><a
				class="el-upload-list__item-name"> <i class="el-icon-document"></i><span
					id="videoName">food.jpeg</span>
			</a> <label class="el-upload-list__item-status-label"> <i
					class="el-icon-upload-success el-icon-circle-check"></i>
			</label> <i class="el-icon-close" onclick="del();"></i> <i
				class="el-icon-close-tip"></i></li>
		</ul>

		<!--进度条-->
		<div class="el-progress el-progress--line" style="display: none;">
			<div class="el-progress-bar">
				<div class="el-progress-bar__outer" style="height: 6px;">
					<div class="el-progress-bar__inner" style="width: 0%;"></div>
				</div>
			</div>
			<div class="el-progress__text" style="font-size: 14.4px;">0%</div>
		</div>
		<p class="_p">
			<span>上传视频</span>：
			<button class="btn btn-primary" type="button" onclick="sub();">上传</button>
		</p>

		<!--预览框-->
		<div class="preview"></div>
	</div>
</div>
<script type="text/javascript">
	var itemAddEditor;
	$(function() {

		//和form下的question组件绑定
		itemAddEditor = KindEditorUtil
				.createEditor("#itemAddForm [name=question]");
		KindEditorUtil.init({
			fun : function(node) {
				KindEditorUtil.changeItemParam(node, "itemAddForm");
			}
		});

	});

	function submitForm() {
		//	表单校验
		if (!$('#itemAddForm').form('validate')) {
			$.messager.alert('提示', '表单还未填写完成!');
			return;
		}

		itemAddEditor.sync();//将输入的内容同步到多行文本中
		var paramJson = [];
		$("#itemAddForm .params li").each(function(i, e) {
			var trs = $(e).find("tr");
			var group = trs.eq(0).text();
			var ps = [];
			for (var i = 1; i < trs.length; i++) {
				var tr = trs.eq(i);
				ps.push({
					"k" : $.trim(tr.find("td").eq(0).find("span").val()),
					"v" : $.trim(tr.find("input").text())
				});
			}
			console.log(ps)
			paramJson.push({
				"group" : group,
				"params" : ps
			});
		});
		paramJson = JSON.stringify(paramJson);//将对象转化为json字符串

		$("#itemAddForm [name=itemParams]").val(paramJson);

		/*$.post/get(url,JSON,function(data){....})  
			?id=1&title="天龙八部&key=value...."
		 */

		//alert($("#itemAddForm").serialize());
		//$.post(url,params,回调函数)
		console.log($("#itemAddForm").serialize());
		$("#")
		$.post("/video/save", $("#itemAddForm").serialize(), function(data) {
			if (data.status == 200) {
				$.messager.alert('提示', '新增视频成功!');
			} else {
				$.messager.alert("提示", "新增视频失败!");
			}
		});
	}

	function clearForm() {
		$('#itemAddForm').form('reset');
		itemAddEditor.html('');
	}

    var xhr;//异步请求对象
    var ot; //时间
    var oloaded;//大小
    //上传文件方法
    function UpladFile() {
        var fileObj = document.getElementById("file").files[0]; // js 获取文件对象
        if(fileObj.name){
            $(".el-upload-list").css("display","block");
            $(".el-upload-list li").css("border","1px solid #20a0ff");
            $("#videoName").text(fileObj.name);
        }else{
            alert("请选择文件");
        }
    }
    /*点击取消*/
    function del(){
        $("#file").val('');
        $(".el-upload-list").css("display","none");
    }
    /*点击提交*/
    function sub(){
        var fileObj = document.getElementById("file").files[0]; // js 获取文件对象
        if(fileObj==undefined||fileObj==""){
            alert("请选择文件");
            return false;
        };
        var title = $.trim($("#title").val());
        if(title==''){
            alert("请填写视频标题");
            return false;
        }
        var url = "{php echo webUrl('goods/iframe.upload')}"; // 接收上传文件的后台地址 
        var form = new FormData(); // FormData 对象
        form.append("mf", fileObj); // 文件对象 
        form.append("title", title); // 标题
        xhr = new XMLHttpRequest(); // XMLHttpRequest 对象
        xhr.open("post", url, true); //post方式，url为服务器请求地址，true 该参数规定请求是否异步处理。
        xhr.onload = uploadComplete; //请求完成
        xhr.onerror = uploadFailed; //请求失败
        xhr.upload.onprogress = progressFunction; //【上传进度调用方法实现】
        xhr.upload.onloadstart = function() { //上传开始执行方法
            ot = new Date().getTime(); //设置上传开始时间
            oloaded = 0; //设置上传开始时，以上传的文件大小为0
        };
        xhr.send(form); //开始上传，发送form数据
    }
    
    //上传进度实现方法，上传过程中会频繁调用该方法
    function progressFunction(evt) { 
        // event.total是需要传输的总字节，event.loaded是已经传输的字节。如果event.lengthComputable不为真，则event.total等于0
        if(evt.lengthComputable) {
            $(".el-progress--line").css("display","block");
            /*进度条显示进度*/
            $(".el-progress-bar__inner").css("width", Math.round(evt.loaded / evt.total * 100) + "%");
            $(".el-progress__text").html(Math.round(evt.loaded / evt.total * 100)+"%");   
        }

        var time = document.getElementById("time");
        var nt = new Date().getTime(); //获取当前时间
        var pertime = (nt - ot) / 1000; //计算出上次调用该方法时到现在的时间差，单位为s
        ot = new Date().getTime(); //重新赋值时间，用于下次计算

        var perload = evt.loaded - oloaded; //计算该分段上传的文件大小，单位b 
        oloaded = evt.loaded; //重新赋值已上传文件大小，用以下次计算

        //上传速度计算
        var speed = perload / pertime; //单位b/s
        var bspeed = speed;
        var units = 'b/s'; //单位名称
        if(speed / 1024 > 1) {
            speed = speed / 1024;
            units = 'k/s';
        }
        if(speed / 1024 > 1) {
            speed = speed / 1024;
            units = 'M/s';
        }
        speed = speed.toFixed(1);
        //剩余时间
        var resttime = ((evt.total - evt.loaded) / bspeed).toFixed(1);
        time.innerHTML = '上传速度：' + speed + units + ',剩余时间：' + resttime + 's';
        if(bspeed == 0)
            time.innerHTML = '上传已取消';
    }
    //上传成功响应
    function uploadComplete(evt) {
        //服务断接收完文件返回的结果  注意返回的字符串要去掉双引号
        if(evt.target.responseText){
            var str = "../shiping/"+evt.target.responseText;
            alert("上传成功！");
            $(".preview").append("<video  controls='' autoplay='' name='media'><source src="+str+" type='video/mp4'></video>");
        }else{
            alert("上传失败");
        }
    }
    //上传失败
    function uploadFailed(evt) {
        alert("上传失败！");
    }
</script>
