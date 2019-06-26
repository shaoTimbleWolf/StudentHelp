<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link href="/js/kindeditor-4.1.10/themes/default/default.css"
	type="text/css" rel="stylesheet">
<script type="text/javascript" charset="utf-8"
	src="/js/kindeditor-4.1.10/kindeditor-all-min.js"></script>
<script type="text/javascript" charset="utf-8"
	src="/js/kindeditor-4.1.10/lang/zh_CN.js"></script>

<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />

<link href="/video/css/video-js.min.css" rel="stylesheet">
<script src="video/js/video.min.js"></script>
<style type="text/css">
#input-video, #result {
	margin: 15px;
}

#video {
	display: none;
}

video::-webkit-media-controls {
	display: none !important;
}
</style>
<script>
	videojs.options.flash.swf = "/video/js/video-js.swf";
</script>
<div>
	<form id="itemAddForm" class="itemForm" method="post">
		<table cellpadding="5">

			<tr>
				<td>视频标题:</td>
				<td><input id="title" class="easyui-textbox" type="text"
					name="title" data-options="required:true" style="width: 280px;"></input></td>
			</tr>
			<tr>
				<td>适用年级:</td>
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
				<td>所属科目:</td>
				<td><select id="select-course" name="course"
					style="width: 200px;">
						<option value="语文">语文</option>
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
				<td>所属知识点:</td>
				<td><input id="knowledge" class="easyui-textbox" type="text"
					name="knowledge" data-options="required:true" style="width: 280px;"></input></td>
			</tr>

		</table>
		<input type="hidden" name="itemParams" />
	</form>
	<form id="itemAddForm" class="itemForm" method="post">
		<div>
			<input id="input-video" type="hidden" accept="video/*" />
			<div id="result"></div>
			<div id="wrap-video">
				<video data-setup='{"videoWidth":600,"videoHeight":400}' id="video"
					class="video-js" controls preload="auto" poster="">
					<p class="vjs-no-js">
						To view this video please enable JavaScript, and consider
						upgrading to a web browser that <a
							href="http://videojs.com/html5-video-support/" target="_blank">supports
							HTML5 video</a>
					</p>
				</video>
			</div>
		</div>
		<input type="hidden" name="itemParams" />
	</form>
	<hr width="80%">
	<br>

	<from action="" enctype="multipart/form-data" method="post"> <a>
		<span>视频上传：</span> <input type="file" id="fileUp" width="800px" height="600px"
		accept="video/ogg,video/mp4">
	</a> </from>
	<input type="submit" id="upload-video" value="提交视频">

</div>


<script src="/video/js/jquery.min.js"></script>
<script type="text/javascript">
	$("input").on("change", function(e) {
		var files = e.target.files || e.dataTransfer.files;
		$("#result").text("请稍后……");
		if (files) {
			file = files[0];
			var URL = window.URL || window.webkitURL;
			var videoURL = URL.createObjectURL(file);
			var myPlayer = videojs("video");
			var info = "<p>名称：" + file.name + "</p>";
			info += "<p>大小：" + file.size + "kb" + "</p>";
			info += "<p>类型：" + file.type + "</p>";
			myPlayer.src(videoURL); //重置video的src
			myPlayer.load(videoURL);
			myPlayer.width($(window).width());
			$("#video").show();
			myPlayer.play();
			var timeInterval = setInterval(function() {
				if (myPlayer.duration() != 0) {
					info += "<p>时长：" + myPlayer.duration() + "秒</p>";
					$("#result").html(info);
					clearInterval(timeInterval);
				}
			}, 1000);
		} else {
			alert("不支持");
		}
	});

	var fileM = document.querySelector("#fileUp");
	$("#upload-video").on("click",function() {
		saveVideo();
	});
	
	function saveVideo(){
		//获取文件对象，files是文件选取控件的属性，存储的是文件选取控件选取的文件对象，类型是一个数组
		var fileObj = fileM.files[0];
		//创建formdata对象，formData用来存储表单的数据，表单数据时以键值对形式存储的。
		var formData = new FormData();
		formData.append('file', fileObj);
		
		$.ajax({
			url : "/video/save",
			type : "post",
			dataType : "json",
			data : formData,
			async : false,
			cache : false,
			contentType : false,
			processData : false,
			success : function(data) {
				if (data.status == 200) {
					saveVideoFrom(data);
				} else {
					alert("提交试题视频失败!");
				}
			},
		});
				
	};
	
	function saveVideoFrom(data){
		//var videoname = $("#videoname").val();
		//var videograde = $("#videograde").val();
		//var videocourse = $("#videocourse").val();
		//var videoknowledge = $("#videoknowledge").val();
		console.log(data.data.id)
		var params={id:data.data.id,
					videoname:$("#title").val(),
					videograde:$("#selece-grade").val(),
					videocourse:$("#select-course").val(),
					videoknowledge:$("#knowledge").val()}
		$.ajax({
			url : "/video/update",
			type : "post",
			dataType : "json",
			data : params,
			success : function(data) {
				if (data.status == 200) {
					alert('提交试题视频信息成功!');
				} else {
					alert("提交试题视频信息失败!");
				}
			},
				
		});
	};
	
</script>