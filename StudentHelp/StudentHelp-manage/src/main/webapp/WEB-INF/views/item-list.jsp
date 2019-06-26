<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<table class="easyui-datagrid" id="questionsList" title="试题列表"
	data-options="singleSelect:false,fitColumns:true,collapsible:true,pagination:true,url:'/questions/query',method:'get',pageSize:20,toolbar:toolbar">
	<thead>
		<tr>
			<th data-options="field:'ck',checkbox:true"></th>
			<th data-options="field:'id',width:60">试题ID</th>
			<th data-options="field:'title',width:100">试题标题</th>
			<th data-options="field:'grade',width:100">所属年级</th>
			<th data-options="field:'course',width:100">所属科目</th>
			<th data-options="field:'knowledge',width:100">所属科目</th>
			<th data-options="field:'question',width:150">试题详情</th>
			<th data-options="field:'answer',width:150">试题答案</th>
			<th
				data-options="field:'status',width:60,align:'center',formatter:KindEditorUtil.formatItemStatus">状态</th>
			<th
				data-options="field:'createdtime',width:130,align:'center',formatter:KindEditorUtil.formatDateTime">创建日期</th>
			<th
				data-options="field:'updatetime',width:130,align:'center',formatter:KindEditorUtil.formatDateTime">更新日期</th>
		</tr>
	</thead>
</table>
<div id="itemEditWindow" class="easyui-window" title="编辑试题"
	data-options="modal:true,closed:true,iconCls:'icon-save',href:'/page/item-edit'"
	style="width: 80%; height: 80%; padding: 10px;"></div>
<script>

function getSelectionsIds(){
	//利用Id选择器获取list对象
	var questionsList = $("#questionsList");
	/*[item,item,item,item]*/
	//获取选中的对象,用数组保存
	var sels = questionsList.datagrid("getSelections");
	var ids = [];	//定义数组
	for(var i in sels){
		ids.push(sels[i].id);
	}
	//将数组拼接成串 1,2,3,4,5
	ids = ids.join(",");
	return ids;
}

var toolbar = [{
    text:'新增',
    iconCls:'icon-add',
    handler:function(){
    	$(".tree-title:contains('新增试题')").parent().click();
    }
},{
    text:'删除',
    iconCls:'icon-cancel',
    handler:function(){
    	//选中id  100,200,300,4500
    	var ids = getSelectionsIds();
    	if(ids.length == 0){
    		$.messager.alert('提示','未选中商品!');
    		return ;
    	}
    	$.messager.confirm('确认','确定删除ID为 '+ids+' 的商品吗？',function(r){
    	    if (r){
    	    	var params = {"ids":ids};
            	$.post("/questions/delete",params, function(data){
        			if(data.status == 200){
        				$.messager.alert('提示','删除商品成功!',undefined,function(){
        					$("#questionsList").datagrid("reload");
        				});
        			}else{
        				$.messager.alert("提示",data.msg);
        			}
        		});
    	    }
    	});
    }
},'-',{
    text:'隐藏',
    iconCls:'icon-remove',
    handler:function(){
    	//获取选中的ID串中间使用","号分割
    	var ids = getSelectionsIds();
    	if(ids.length == 0){
    		$.messager.alert('提示','未选中商品!');
    		return ;
    	}
    	$.messager.confirm('确认','确定隐藏ID为 '+ids+' 的试题吗？',function(r){
    	    if (r){
    	    	var params = {"ids":ids};
            	$.post("/questions/instock",params, function(data){
        			if(data.status == 200){
        				$.messager.alert('提示','隐藏试题成功!',undefined,function(){
        					$("#questionsList").datagrid("reload");
        				});
        			}
        		});
    	    }
    	});
    }
},{
    text:'展示',
    iconCls:'icon-remove',
    handler:function(){
    	var ids = getSelectionsIds();
    	if(ids.length == 0){
    		$.messager.alert('提示','未选中商品!');
    		return ;
    	}
    	$.messager.confirm('确认','确定上架ID为 '+ids+' 的商品吗？',function(r){
    	    if (r){
    	    	var params = {"ids":ids};
            	$.post("/questions/reshelf",params, function(data){
        			if(data.status == 200){
        				$.messager.alert('提示','上架商品成功!',undefined,function(){
        					$("#questionsList").datagrid("reload");
        				});
        			}
        		});
    	    }
    	});
    }
}];
   
</script>