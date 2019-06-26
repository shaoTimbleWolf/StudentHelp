<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<table class="easyui-datagrid" id="itemList" title="用户列表"
	data-options="singleSelect:false,fitColumns:true,collapsible:true,pagination:true,url:'/user/query',method:'get',pageSize:20,toolbar:toolbar">
	<thead>
		<tr>
			<th data-options="field:'ck',checkbox:true"></th>
			<th data-options="field:'id',width:150">用户ID</th>
			<th data-options="field:'name',width:150">学生姓名</th>
			<th data-options="field:'phone',width:150">手机号码</th>
			<th data-options="field:'barcode',width:200">收藏题目</th>
			<th
				data-options="field:'status',width:60,align:'center',formatter:KindEditorUtil.formatItemStatus">状态</th>
			<th
				data-options="field:'createdtime',width:200,align:'center',formatter:KindEditorUtil.formatDateTime">注册日期</th>
			<th
				data-options="field:'updatetime',width:200,align:'center',formatter:KindEditorUtil.formatDateTime">更新日期</th>
		</tr>
	</thead>
</table>
<div id="itemEditWindow" class="easyui-window" title="编辑用户"
	data-options="modal:true,closed:true,iconCls:'icon-save',href:'/page/user-edit'"
	style="width: 80%; height: 80%; padding: 10px;"></div>
<script>

    function getSelectionsIds(){
    	//利用Id选择器获取list对象
    	var itemList = $("#itemList");
    	/*[item,item,item,item]*/
    	//获取选中的对象,用数组保存
    	var sels = itemList.datagrid("getSelections");
    	var ids = [];	//定义数组
    	for(var i in sels){
    		ids.push(sels[i].id);
    	}
    	//将数组拼接成串 1,2,3,4,5
    	ids = ids.join(",");
    	return ids;
    }
    
    var toolbar = [{
        text:'删除',
        iconCls:'icon-cancel',
        handler:function(){
        	//选中id  100,200,300,4500
        	var ids = getSelectionsIds();
        	if(ids.length == 0){
        		$.messager.alert('提示','未选中用户!');
        		return ;
        	}
        	$.messager.confirm('确认','确定删除ID为 '+ids+' 的用户吗？',function(r){
        	    if (r){
        	    	var params = {"ids":ids};
                	$.post("/user/delete",params, function(data){
            			if(data.status == 200){
            				$.messager.alert('提示','删除用户成功!',undefined,function(){
            					$("#itemList").datagrid("reload");
            				});
            			}else{
            				$.messager.alert("提示",data.msg);
            			}
            		});
        	    }
        	});
        }
    },'-',{
        text:'禁用',
        iconCls:'icon-remove',
        handler:function(){
        	//获取选中的ID串中间使用","号分割
        	var ids = getSelectionsIds();
        	if(ids.length == 0){
        		$.messager.alert('提示','未选中用户!');
        		return ;
        	}
        	$.messager.confirm('确认','确定禁用ID为 '+ids+' 的用户吗？',function(r){
        	    if (r){
        	    	var params = {"ids":ids};
                	$.post("/user/instock",params, function(data){
            			if(data.status == 200){
            				$.messager.alert('提示','禁用用户成功!',undefined,function(){
            					$("#itemList").datagrid("reload");
            				});
            			}
            		});
        	    }
        	});
        }
    },{
        text:'启用',
        iconCls:'icon-remove',
        handler:function(){
        	var ids = getSelectionsIds();
        	if(ids.length == 0){
        		$.messager.alert('提示','未选中用户!');
        		return ;
        	}
        	$.messager.confirm('确认','确定启用ID为 '+ids+' 的用户吗？',function(r){
        	    if (r){
        	    	var params = {"ids":ids};
                	$.post("/user/reshelf",params, function(data){
            			if(data.status == 200){
            				$.messager.alert('提示','启用用户成功!',undefined,function(){
            					$("#itemList").datagrid("reload");
            				});
            			}
            		});
        	    }
        	});
        }
    }];
</script>