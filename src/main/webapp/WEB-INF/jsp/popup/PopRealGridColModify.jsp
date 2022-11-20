<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : PopRealGridColModify
	화면명    : 팝업-리얼그리드 컬럼변경
-->
<div id="popRealGridColModify" class="pop_wrap" style="overflow: hidden;">
	<div class="ct_left_wrap">
		<div class="grid_top_wrap">
			<div class="grid_top_left">표시 컬럼</div>
			<div class="grid_top_right">
				<button type="button" class="cmb_normal" onclick="fn_realgridRowUp()" title="위로">↑</button>
				<button type="button" class="cmb_normal" onclick="fn_realgridRowDown()" title="아래로">↓</button>
				<button type="button" class="cmb_normal" onclick="fn_realgridRowallhide()" title="모두숨김">모두숨김</button>
			</div>
		</div>
		<div id="grid_popRealGridColModify1"></div>
	</div>
	<div class="ct_right_wrap">
		<div class="grid_top_wrap">
			<div class="grid_top_left">숨김 컬럼</div>
			<div class="grid_top_right">
				<button type="button" class="cmb_normal" onclick="fn_realgridRowallshow()" title="모두표시">모두표시</button>
			</div>
		</div>
		<div id="grid_popRealGridColModify2"></div>
	</div>
</div>

<script type="text/javascript">
$(function() {
	var popcolumns, invisible = [];
	$('#popRealGridColModify').lingoPopup({
		title: '컬럼 변경',
		width: 500,
		height: 450,
		buttons: {
			'저장': {
				text: '저장',
				click: function() {
					var resultdata = [];
					var showdata = $('#grid_popRealGridColModify1').gfn_getDataList(true, false);
					var hidedata = $('#grid_popRealGridColModify2').gfn_getDataList();
					
					for (var i=0, len=showdata.length; i<len; i++) {
						var tempdata = popcolumns.filter(function (a) { return a.name === showdata[i].name && a.type === 'group' });
						if (tempdata.length > 0) {
							showdata[i].columns = tempdata[0].columns;
							showdata[i].type = tempdata[0].type;
							showdata[i].header = tempdata[0].header;
						}
						delete showdata[i].text;
						delete showdata[i].required;
						
						resultdata.push(showdata[i]);
					}
					
					for (var i=0, len=hidedata.length; i<len; i++) {
						var tempdata = popcolumns.filter(function (a) { return a.name === hidedata[i].name && a.type === 'group' });
						if (tempdata.length > 0) {
							hidedata[i].columns = tempdata[0].columns;
							hidedata[i].type = tempdata[0].type;
							hidedata[i].header = tempdata[0].header;
						}
						delete hidedata[i].text;
						delete hidedata[i].required;
						
						resultdata.push(hidedata[i]);
					}
					
					for (var i=0, len=invisible.length; i<len; i++) {
						delete invisible[i].text;
						delete invisible[i].required;
						
						resultdata.push(invisible[i]);
					}
					
					$(this).lingoPopup('setData', resultdata);
					$(this).lingoPopup('close', 'SAVE');
				}
			},
			'취소': {
				text: '취소',
				click: function() {
					$(this).lingoPopup('setData', '');
					$(this).lingoPopup('close');
				}
			}
		},
		open: function(data) {
			grid_Load_popRealGridColModify1();
			grid_Load_popRealGridColModify2();
			
			popcolumns = data.columns;
			var showdata = [], hidedata = [];
			
			for (var i=0, len=popcolumns.length; i<len; i++) {
				var required = (typeof popcolumns[i].requiredMessage !== 'undefined' && popcolumns[i].requiredMessage !== null) ? true : false;
				var col = {name:popcolumns[i].name, fieldName:popcolumns[i].fieldName, required:required, visible:popcolumns[i].visible, text:popcolumns[i].header.text, width:popcolumns[i].width};
				
				if (popcolumns[i].tag === 'invisible') {
					invisible.push(col);
					continue;
				}
				
				if (col.visible) {
					showdata.push(col);
				} else {
					hidedata.push(col);
				}
			}
			
			$('#grid_popRealGridColModify1').gfn_setDataList(showdata);
			$('#grid_popRealGridColModify2').gfn_setDataList(hidedata);
		}
	});
});

function grid_Load_popRealGridColModify1() {
	var gid = 'grid_popRealGridColModify1', $grid = $('#' + gid);
	var columns = [
		{name:'text',header:{text:'컬럼명'},width:100},
		{name:'required',header:{text:' '},width:15,imageList:'images1',renderer:{type:'icon',textVisible:false},dataType:'bool',
			styles: {iconIndex:0, iconLocation:'center', iconAlignment:'center'},cursor:'pointer',
			dynamicStyles: [{
			    criteria: 'value',
			    styles: 'iconIndex=-1'
			}]
		},
		{name:'name',header:{text:'컬럼키'},width:100,visible:false},
		{name:'fieldName',header:{text:'필드키'},width:100,visible:false},
		{name:'width',header:{text:'가로크기'},width:100,dataType:'number',visible:false},
		{name:'visible',header:{text:'숨김여부'},width:100,dataType:'bool',visible:false}
    ];
	
	//그리드 생성
	$grid.gfn_createGrid(columns, 
		{panelflg:false,headerflg:false,footerflg:false,indicator:false,sortable:false,cellFocusVisible:false,contextmenu:false,fitStyle:'evenFill'}
	);
	
	$grid.gfn_setGridEvent(function(gridView, dataProvider) {
		var imgs = new RealGridJS.ImageList('images1', '/images/lfw2/');
	    imgs.addUrls(['icon_minus.png', 'icon_plus.png']);
		gridView.registerImageList(imgs);
		
		gridView.onDataCellClicked = function(gridview, column) {
			if (column.column === 'required') {
				var rowData = $grid.gfn_getDataRow(column.dataRow);

				if (rowData.required === true || rowData.required === 'true') {
					cfn_msg('WARNING', '필수컬럼은 숨길 수 없습니다.')
					return false;
				}
				
				$grid.gfn_delRow(column.dataRow);
				rowData.visible = false;
				$('#grid_popRealGridColModify2').gfn_addRow(rowData);
			}
		}; 
	});
}

function grid_Load_popRealGridColModify2() {
	var gid = 'grid_popRealGridColModify2', $grid = $('#' + gid);
	var columns = [
		{name:'text',header:{text:'컬럼명'},width:100},
		{name:'required',header:{text:' '},width:15,imageList:'images1',renderer:{type:'icon',textVisible:false},dataType:'bool',
			styles: {iconIndex:1, iconLocation:'center', iconAlignment:'center'},cursor:'pointer'
		},
		{name:'name',header:{text:'컬럼키'},width:100,visible:false},
		{name:'fieldName',header:{text:'필드키'},width:100,visible:false},
		{name:'width',header:{text:'가로크기'},width:100,dataType:'number',visible:false},
		{name:'visible',header:{text:'숨김여부'},width:100,dataType:'bool',visible:false}
    ];
	
	//그리드 생성
	$grid.gfn_createGrid(columns, 
		{panelflg:false,headerflg:false,footerflg:false,indicator:false,sortable:false,cellFocusVisible:false,contextmenu:false,fitStyle:'evenFill'}
	);
	
	$grid.gfn_setGridEvent(function(gridView, dataProvider) {
		var imgs = new RealGridJS.ImageList('images1', '/images/lfw2/');
	    imgs.addUrls(['icon_minus.png', 'icon_plus.png']);
		gridView.registerImageList(imgs);
		
		gridView.onDataCellClicked = function(gridview, column) {
			if (column.column === 'required') {
				var rowData = $grid.gfn_getDataRow(column.dataRow);
				$grid.gfn_delRow(column.dataRow);
				rowData.visible = true;
				$('#grid_popRealGridColModify1').gfn_addRow(rowData);
			}
		}; 
	});
}

//위로 버튼 클릭
function fn_realgridRowUp() {
	var $grid = $('#grid_popRealGridColModify1');
	var rowidx = $grid.gfn_getCurRowIdx();
	var prevRowidx = $grid.gridView().getItemIndex(rowidx - 1);
	
	if (prevRowidx >= 0) {
		$grid.dataProvider().moveRow(rowidx, prevRowidx);
		$grid.gridView().setCurrent({dataRow: prevRowidx});
	}
}

//아래로 버튼 클릭
function fn_realgridRowDown() {
	var $grid = $('#grid_popRealGridColModify1');
	var rowidx = $grid.gfn_getCurRowIdx();
	var nextRowidx = $grid.gridView().getItemIndex(rowidx + 1);
	
	if (nextRowidx >= 0) {
		$grid.dataProvider().moveRow(rowidx, nextRowidx);
		$grid.gridView().setCurrent({dataRow: nextRowidx});
	}
}

//모두표시 버튼 클릭
function fn_realgridRowallshow() {
	var gridData = $('#grid_popRealGridColModify2').gfn_getDataList();
	var showIdxList = [], showList = [];
	
	for (var i=0, len=gridData.length; i<len; i++) {
		if (!gridData[i].required) {
			showIdxList.push($('#grid_popRealGridColModify2').gridView().getDataRow(i));
			gridData[i].visible = true;
			showList.push(gridData[i]);
		}
	}
	
	$('#grid_popRealGridColModify2').gfn_delRows(showIdxList);
	$('#grid_popRealGridColModify1').gfn_addRows(showList);
}

//모두숨김 버튼 클릭
function fn_realgridRowallhide() {
	var gridData = $('#grid_popRealGridColModify1').gfn_getDataList();
	var hideIdxList = [], hideList = [];
	
	for (var i=0, len=gridData.length; i<len; i++) {
		if (!gridData[i].required) {
			hideIdxList.push($('#grid_popRealGridColModify1').gridView().getDataRow(i));
			gridData[i].visible = false;
			hideList.push(gridData[i]);
		}
	}
	
	$('#grid_popRealGridColModify1').gfn_delRows(hideIdxList);
	$('#grid_popRealGridColModify2').gfn_addRows(hideList);
}
</script>