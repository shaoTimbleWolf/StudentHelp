<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<table class="easyui-datagrid" id="videoList" title="试题列表"
	data-options="singleSelect:false,fitColumns:true,collapsible:true,pagination:true,url:'/video/query',method:'get',pageSize:20,toolbar:toolbar">
	<thead>
		<tr>
			<th data-options="field:'ck',checkbox:true"></th>
			<th data-options="field:'id',width:60">视频编号</th>
			<th data-options="field:'videoname',width:70">视频标题</th>
			<th data-options="field:'videograde',width:70">所属年级</th>
			<th data-options="field:'videocourse',width:70">所属科目</th>
			<th data-options="field:'videoknowledge',width:100">知识点</th>
			<th
				data-options="field:'status',width:60,align:'center',formatter:KindEditorUtil.formatItemStatus">状态</th>
			<th
				data-options="field:'createdtime',width:150,align:'center',formatter:KindEditorUtil.formatDateTime">创建日期</th>
			<th
				data-options="field:'updatetime',width:150,align:'center',formatter:KindEditorUtil.formatDateTime">更新日期</th>
		</tr>
	</thead>
</table>
<div id="itemEditWindow" class="easyui-window" title="编辑试题"
	data-options="modal:true,closed:true,iconCls:'icon-save',href:'/page/item-edit'"
	style="width: 80%; height: 80%; padding: 10px;"></div>
<script>
	function getSelectionsIds() {
		//利用Id选择器获取list对象
		var videoList = $("#videoList");
		/*[item,item,item,item]*/
		//获取选中的对象,用数组保存
		var sels = videoList.datagrid("getSelections");
		var ids = []; //定义数组
		for ( var i in sels) {
			ids.push(sels[i].id);
		}
		//将数组拼接成串 1,2,3,4,5
		ids = ids.join(",");
		return ids;
	}

	var toolbar = [
			{
				text : '新增',
				iconCls : 'icon-add',
				handler : function() {
					$(".tree-title:contains('新增视频')").parent().click();
				}
			},
			{
				text : '编辑',
				iconCls : 'icon-edit',
				handler : function() {
					//获取用户选中的数据
					var ids = getSelectionsIds();
					if (ids.length == 0) {
						$.messager.alert('提示', '必须选择一个商品才能编辑!');
						return;
					}
					if (ids.indexOf(',') > 0) {
						$.messager.alert('提示', '只能选择一个商品!');
						return;
					}

					$("#itemEditWindow").window(
							{
								onLoad : function() {
									//回显数据
									var data = $("#videoList").datagrid(
											"getSelections")[0];
									$("#itemeEditForm").form("load", data);

								}
							}).window("open");
				}
			},
			{
				text : '删除',
				iconCls : 'icon-cancel',
				handler : function() {
					//选中id  100,200,300,4500
					var ids = getSelectionsIds();
					if (ids.length == 0) {
						$.messager.alert('提示', '未选中商品!');
						return;
					}
					$.messager
							.confirm(
									'确认',
									'确定删除ID为 ' + ids + ' 的商品吗？',
									function(r) {
										if (r) {
											var params = {
												"ids" : ids
											};
											$
													.post(
															"/video/delete",
															params,
															function(data) {
																if (data.status == 200) {
																	$.messager
																			.alert(
																					'提示',
																					'删除商品成功!',
																					undefined,
																					function() {
																						$(
																								"#videoList")
																								.datagrid(
																										"reload");
																					});
																} else {
																	$.messager
																			.alert(
																					"提示",
																					data.msg);
																}
															});
										}
									});
				}
			},
			'-',
			{
				text : '禁用',
				iconCls : 'icon-remove',
				handler : function() {
					//获取选中的ID串中间使用","号分割
					var ids = getSelectionsIds();
					if (ids.length == 0) {
						$.messager.alert('提示', '未选中商品!');
						return;
					}
					$.messager
							.confirm(
									'确认',
									'确定禁用ID为 ' + ids + ' 的商品吗？',
									function(r) {
										if (r) {
											var params = {
												"ids" : ids
											};
											$
													.post(
															"/video/instock",
															params,
															function(data) {
																if (data.status == 200) {
																	$.messager
																			.alert(
																					'提示',
																					'禁用商品成功!',
																					undefined,
																					function() {
																						$(
																								"#videoList")
																								.datagrid(
																										"reload");
																					});
																}
															});
										}
									});
				}
			},
			{
				text : '启用',
				iconCls : 'icon-remove',
				handler : function() {
					var ids = getSelectionsIds();
					if (ids.length == 0) {
						$.messager.alert('提示', '未选中商品!');
						return;
					}
					$.messager
							.confirm(
									'确认',
									'确定启用ID为 ' + ids + ' 的商品吗？',
									function(r) {
										if (r) {
											var params = {
												"ids" : ids
											};
											$
													.post(
															"/video/reshelf",
															params,
															function(data) {
																if (data.status == 200) {
																	$.messager
																			.alert(
																					'提示',
																					'启用商品成功!',
																					undefined,
																					function() {
																						$(
																								"#videoList")
																								.datagrid(
																										"reload");
																					});
																}
															});
										}
									});
				}
			} ];
</script>