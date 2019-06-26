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
				<td>试题标题:</td>
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
						<option >高三上</option>
						<option >高三下</option>
				</select></td>
			</tr>

			<tr id="select-tr">
				<td>科目:</td>
				<td><select id="select-course" name="course"
					style="width: 200px;">
						<option value="Chinese" name="Chinese">语文</option>
						<option value="数学" >数学</option>
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
				<td>试题描述:</td>
				<td><textarea
						style="width: 800px; height: 300px; visibility: hidden;"
						name="question"></textarea></td>
			</tr>
			<div style="margin: 20px 0"></div>

			<tr>
				<td>试题解析:</td>
				<td><textarea
						style="width: 800px; height: 300px; visibility: hidden;"
						name="answer"></textarea></td>
			</tr>
			<div style="margin: 20px 0"></div>

		</table>
		<input type="hidden" name="itemParams" />
	</form>
	<div style="padding: 5px">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			onclick="submitForm()">提交</a> <a href="javascript:void(0)"
			class="easyui-linkbutton" onclick="clearForm()">重置</a>
	</div>
</div>
<script type="text/javascript">
	
	var itemAddEditor=new Array();
	$(function() {
		
		//和form下的question组件绑定
		itemAddEditor[0] = KindEditorUtil
				.createEditor("#itemAddForm [name=question]");
		KindEditorUtil.init({
			fun : function(node) {
				KindEditorUtil.changeItemParam(node, "itemAddForm");
			}
		});
		
	});
	$(function(){
		//和form下的answer组件绑定
		itemAddEditor[1] = KindEditorUtil
				.createEditor("#itemAddForm [name=answer]");		
				
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
		
		itemAddEditor[0].sync();//将输入的内容同步到多行文本中
		itemAddEditor[1].sync();//将输入的内容同步到多行文本中

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
		$.post("/questions/save", $("#itemAddForm").serialize(), function(data) {
			if (data.status == 200) {
				$.messager.alert('提示', '新增试题成功!');
			} else {
				$.messager.alert("提示", "新增试题失败!");
			}
		});
	}

	function clearForm() {
		$('#itemAddForm').form('reset');
		itemAddEditor.html('');
	}
</script>
