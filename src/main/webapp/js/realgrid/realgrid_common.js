/**
 * RealGrid 공통 js
 * @author 2017-07-05 KaiKim
 */
(function(){
	var gridObj = {};

	$.fn.gfn_createGrid = function(columns, options, fields) {
		var _options = $.extend({
			indicator: true, //Row번호 여부
			stateBar: false, //상태바 여부
			checkBar: false, //체크바 여부
			panelflg: false, //상단 그룹핑패널 보임 여부
			headerflg: true, //상단 헤더 보임 여부
			pagerflg: false, //하단 페이징패널 보임 여부
			footerflg: true, //합계행 보임 여부
			treeflg: false, //트리그리드 여부
			sortable: true, //정렬 가능여부
			copyflg: true, //셀 복사 여부
			pasteflg: false, //셀 붙여넣기 여부
			cellFocusVisible: true, //셀 포커스 배경적용 여부
			rowFocusVisible: true, //행 포커스 배경적용 여부
			headerSelectFocusVisible: true, //셀선택 포커스 헤더 배경적용 여부
			contextmenu: true, //기본 우클릭메뉴 여부
			cmenuColChangeflg: true, //우클릭메뉴 - 컬럼변경 여부
			cmenuColSaveflg: true, //우클릭메뉴 - 컬럼저장 여부
			cmenuColInitflg: true, //우클릭메뉴 - 컬럼초기화 여부
			cmenuGroupflg: true, //우클릭메뉴 - 그룹핑 여부
			cmenuExcelflg: true, //우클릭메뉴 - 엑셀저장 여부
			cmenuCsvflg: true, //우클릭메뉴 - CSV저장 여부
			fitStyle: 'none', //컬럼들을 너비 비율 설정 (none: 컬럼width, even: 컬럼전체너비가 그리드너비보다 작을경우 채움, evenFill: 그리드너비로 채움, fill: fillWidth속성을 이용해 채움)
			width: '100%',
			height: '100%',
			popupArr: [],
			calendarArr: [],
			mstGrid:'' //해당 그리드의 마스터 그리드를 설정
		}, options);
		var _columns = [], _fields = [], uniq = [];

		for (var i=0, len=columns.length; i<len; i++) {
			var col = gfn_colSetting(columns[i], _options);

			if (col.type === 'group') {
				var subcols = col.columns;

				for (var j=0, len2=subcols.length; j<len2; j++) {
					var subcol = gfn_colSetting(subcols[j], _options);
					col.columns[j] = subcol;

					if (subcol.type === 'group') {
						var sub2cols = subcol.columns;

						for (var k=0, len3=sub2cols.length; k<len3; k++) {
							var sub2col = gfn_colSetting(sub2cols[k], _options);
							col.columns[j].columns[k] = sub2col;

							if (uniq.indexOf(sub2col.fieldName) < 0) {
								uniq.push(sub2col.fieldName);
								_fields.push(sub2col);
							}
						}
					} else {
						if (uniq.indexOf(subcol.fieldName) < 0) {
							uniq.push(subcol.fieldName);
							_fields.push(subcol);
						}
					}
				}
			} else {
				if (uniq.indexOf(col.fieldName) < 0) {
					uniq.push(col.fieldName);
					_fields.push(col);
				}
			}

			_columns.push(col);
		}

		if (typeof fields !== 'undefined' && fields !== null) {
			_fields = fields;
		}

		this.gfn_makeRealGrid(_columns, _fields, _options);
	}

	$.fn.gfn_makeRealGrid = function(columns, fields, options) {
		var $g = this, gid = this.attr('id');
		/* 하단 페이징바 여부 */
		if (options.pagerflg) {
			var pagerTag = '<div id="' + gid + '_pager" class="grid_pager">' +
				'<div id="' + gid + '_pager_left" class="pager_left"></div>' +
				'<div id="' + gid + '_pager_center" class="pager_center">'+
				/*정산관리 페이징*/
                    '<div id="first_paginbottom" class="ui-corner-all ui-state-disabled" title="First Page" style="float:left; margin-top : 1.5px;"><span class="ui-icon ui-icon-seek-first"></span></div>'+
                    '<div id="prev_paginbottom" class="ui-corner-all ui-state-disabled" title="Previous Page" style="float:left; margin-top : 1.5px;"><span class="ui-icon ui-icon-seek-prev"></span></div>'+
                    '<div class=" ui-state-disabled"><span class="ui-separator" style="float:left; margin-top : 1.5px;"></span></div>'+
                    '<div dir="ltr" style="float:left; margin-top : 1.5px;">페이지 <input id="input_paginbottom" class="ui-pg-input ui-corner-all" type="text" size="2" maxlength="7" value="0" role="textbox"> / <span id="sp_1_paginbottom">0</span></div>'+
                    '<div class=" ui-state-disabled" style="float:left; margin-top : 1.5px;"><span class="ui-separator"></span></div>'+
                    '<div id="next_paginbottom" class="ui-corner-all ui-state-disabled" title="Next Page" style="cursor: default; float:left; margin-top : 1.5px;"><span class="ui-icon ui-icon-seek-next"></span></div>'+
                   ' <div id="last_paginbottom" class="ui-corner-all ui-state-disabled" title="Last Page" style="float:left; margin-top : 1.5px;"><span class="ui-icon ui-icon-seek-end"></span></div>'+
				'</div>' +
				'<div id="' + gid + '_pager_right" class="pager_right">' +
				/*정산관리 페이징*/
					'<div id="paginbottom_right" dir="ltr" style="text-align:right" class="ui-paging-info"></div>'+
				'</div>'+
				'</div>';
			this.after(pagerTag);
		}

		/* 그리드 리사이징 */
		var topHeight = this.prev('div.grid_top_wrap').length > 0 ? this.prev('div.grid_top_wrap').outerHeight(true) : 0;
		var pagerHeight = this.next('#' + gid + '_pager').length > 0 ? this.next('#' + gid + '_pager').outerHeight(true) : 0;
		var exheight = topHeight + pagerHeight;
		this.css({width: options.width, height: 'calc(' + options.height + ' - ' + exheight + 'px)'});

		/* 그리드 생성 */
		try {
			RealGridJS.setTrace(false);
			RealGridJS.setRootContext('/js/realgrid');
		} catch (exception) {
			cfn_msg('ERROR', 'RealGrid 라이센스가 유효하지 않습니다.');
		}

		var dataProvider = (typeof options.treeflg === 'undefined' || options.treeflg === null || !options.treeflg) ? new RealGridJS.LocalDataProvider() : new RealGridJS.LocalTreeDataProvider();
		var gridView = (typeof options.treeflg === 'undefined' || options.treeflg === null || !options.treeflg) ? new RealGridJS.GridView(gid) : new RealGridJS.TreeView(gid);
		gridView.setDataSource(dataProvider);
		gridView.setColumns(columns);
		dataProvider.setFields(fields);

		/* 그리드 컬럼 사용자 저장 정보 적용 */
		var saveColumns = JSON.parse(localStorage.getItem(cfn_getCurProgramcd() + this.attr('id')));
		if (!cfn_isEmpty(saveColumns)) {
			for (var i=0, len=columns.length; i<len; i++) {
				var exist = false;
				for (var j=0, len2=saveColumns.length; j<len2; j++) {
					if (columns[i].name === saveColumns[j].name) {
						exist = true;
						break;
					}
				}

				if (!exist) {
					saveColumns.push(columns[i]);
				}
			}

			gridView.setColumnLayout(saveColumns);
		}

		/* 그리드 스타일 설정 */
		gridView.setStyles({
			grid: {fontFamily: '나눔 고딕', fontSize: '13', border: '#b9b9b9,1', line: '#b9b9b9,1'},
			panel: {background: '#dfebf7', foreground: '#505050',
				borderTop: '#b9b9b9,0', borderRight: '#b9b9b9,0', borderBottom: '#b9b9b9,2px', borderLeft:'#b9b9b9,0'},
			header: {background: '#dfebf7', foreground: '#2a2a2a', hoveredBackground: null,
				borderTop: '#b9b9b9,0', borderRight: '#b9b9b9,1', borderBottom: '#b9b9b9,1', borderLeft: '#b9b9b9,0',
				group: {background: '#dfebf7', borderTop: '#b9b9b9,0', borderBottom: '#b9b9b9,1', borderRight: '#b9b9b9,1'}
			},
            body: {
            	paddingLeft: '3', background: '#FFFFFF', foreground: '#2A2A2A',
            	borderTop: '#b9b9b9,0', borderLeft: '#b9b9b9,0', borderRight: '#b9b9b9,1', borderBottom: '#b9b9b9,1',
            	dynamicStyles: [{
                    criteria: '(row mod 2) = 0',
                    styles: {background: '#FFFFFF'}
                }, {
                    criteria: '(row mod 2) = 1',
                    styles: {background: '#F9F9F9'}
                }]
            },
            indicator: {background: '#dfebf7', foreground: '#2A2A2A', borderRight: '#b9b9b9,1', borderBottom: '#b9b9b9,1'},
            stateBar: {borderRight: '#b9b9b9', borderBottom: '#b9b9b9'},
            checkBar: {borderRight: '#b9b9b9', borderBottom: '#b9b9b9'},
            rowGroup: {
            	footer: {borderRight: '#b9b9b9,1'}
            },
            footer: {background: '#fffde3', foreground: '#444444', fontBold: true, paddingTop: 4, paddingBottom: 4,
            		borderTop: '#b9b9b9,1', borderLeft: '#b9b9b9,0', borderRight: '#b9b9b9,1', borderBottom: '#b9b9b9,0'
            }
        });

		/* 그리드 셀선택 포커스 헤더 배경적용 여부 */
		if (!options.headerSelectFocusVisible) {
			gridView.setStyles({
				header: {selectedBackground: null, selectedForeground: null}
			});
		}

		/* contextMenu CSS 적용 */
        gridView.setEditorOptions({useCssStylePopupMenu: true});

        /* 그리드 리사이징 */
		$(window).bind('resize', function(e) {
			gridView.resetSize();
		});

		/* 그리드 설정 */
		gridView.setOptions({
			indicator: {visible: options.indicator}, //Row번호 설정
			stateBar: {visible: options.stateBar}, //상태바 설정
			checkBar: {visible: options.checkBar, width: 25, styles: {figureSize: 18}}, //체크바 설정
			sorting: {
				enabled: options.sortable,
				toast: {visible: true, message: '정렬 중입니다.'}
			}, //정렬 설정
			filtering: {toast: {visible: true, message: '필터링 중입니다.'}},
			grouping: {toast: {visible: true, message: '그룹핑 중입니다.'}}, //행 그룹핑 설정
			panel: {visible:options.panelflg}, //그룹핑 패널 설정
			header: {height: 0, minHeight: 28, visible: options.headerflg}, //헤더 설정
			display: { //Row옵션 설정
				rowFocusVisible: true,
				rowFocusBackground: '#3366ccff',
				rowHeight: 25,
				fitStyle: options.fitStyle
			},
			hideDeletedRows: true //삭제된 행의 표시 여부를 지정한다.
		});

		/* 그리드 셀 복사 설정 */
		gridView.setCopyOptions({
			enabled: options.copyflg
		});

		/* 그리드 셀 붙여넣기 설정 */
		gridView.setPasteOptions({
			enabled: options.pasteflg,
			startEdit: true,
			commitEdit:true,
			enableAppend:true,
			stopOnError:true,
			noEditEvent:true
		});

		if (options.sortable) {
			gridView.setOptions({sortMode: 'explicit'});
			gridView.setSortingOptions({keepFocusedRow: true});
		}

		gridView.setDisplayOptions({
			focusVisible: options.cellFocusVisible,
			rowFocusVisible: options.rowFocusVisible
		});

        /* 합계행 설정 */
        gridView.setFooter({visible: options.footerflg});

        /* Row삭제상태 설정 */
        dataProvider.setOptions({softDeleting: true, deleteCreated: true});

        /* 기본 우클릭메뉴 여부 */
        if (options.contextmenu) {
        	/* ContextMenu 설정 */
        	var cmenuArr = [];

        	if (options.cmenuColChangeflg) {
        		cmenuArr.push({label: '컬럼변경'});
        	}
        	if (options.cmenuColSaveflg) {
        		cmenuArr.push({label: '컬럼저장'});
        	}
        	if (options.cmenuColInitflg) {
        		cmenuArr.push({label: '컬럼초기화'});
        	}
        	if (options.cmenuGroupflg) {
        		cmenuArr.push({label: '그룹핑표시숨김'});
        	}
        	if (options.cmenuExcelflg) {
        		cmenuArr.push({label: '엑셀저장'});
        	}
        	if (options.cmenuCsvflg) {
        		cmenuArr.push({label: 'CSV저장'});
        	}

            gridView.setContextMenu(cmenuArr);

            /* ContextMenu 클릭 이벤트 */
            gridView.onContextMenuItemClicked = function(grid, label, index) {
            	if (label.label === '컬럼변경' && options.cmenuColChangeflg) {
            		var columns = gridView.getColumns();

            		columns = columns.sort(function(a, b) {
            			return a.displayIndex < b.displayIndex ? -1 : a.displayIndex > b.displayIndex ? 1 : 0;
            		});

            		pfn_popupOpen({
            			url: '/comm/realgrid/popRealGridColModify/view.do',
            			params: {columns:columns},
            			selfFrameFlg: true,
            			returnFn: function(data, type) {
            				if (type === 'SAVE') {
            					gridView.setColumnLayout(data);
            					var columns = JSON.stringify(data);
                    			var sendData = {paramData:{APPKEY:cfn_getCurProgramcd(),GRIDID:gid,COLJSON:columns}};
                    			var url = '/comm/realgrid/setColumns.do';

                    			gfn_ajax(url, true, sendData, function(data, xhr) {
                    				localStorage.setItem(cfn_getCurProgramcd() + gid, columns);
                    				cfn_msg('INFO', '저장되었습니다.');
                    			});
            				}
            			}
            		});
            	} else if (label.label === '컬럼저장' && options.cmenuColSaveflg) {
            		var saveColumns = gridView.saveColumnLayout();
            		var columns = JSON.stringify(saveColumns);
        			var sendData = {paramData:{APPKEY:cfn_getCurProgramcd(),GRIDID:gid,COLJSON:columns}};
        			var url = '/comm/realgrid/setColumns.do';

        			gfn_ajax(url, true, sendData, function(data, xhr) {
        				localStorage.setItem(cfn_getCurProgramcd() + gid, columns);
        				cfn_msg('INFO', '저장되었습니다.');
        			});
            	} else if (label.label === '컬럼초기화' && options.cmenuColInitflg) {
        			localStorage.removeItem(cfn_getCurProgramcd() + gid);

    				var sendData = {paramData:{APPKEY:cfn_getCurProgramcd(),GRIDID:gid}};
        			var url = '/comm/realgrid/deleteColumns.do';

        			gfn_ajax(url, true, sendData, function(data, xhr) {
        				gridView.restoreColumns();
        				cfn_msg('INFO', '초기화되었습니다.');
        			});
            	} else if (label.label === '엑셀저장' && options.cmenuExcelflg) {
                	gfn_excelExport(gid);
                } else if (label.label === 'CSV저장' && options.cmenuCsvflg) {
                	gfn_csvExport(gid);
                } else if (label.label === '그룹핑표시숨김' && options.cmenuGroupflg) {
                	var _panel = gridView.getPanel();
                	if (_panel.visible) {
                		gridView.setOptions({panel: {visible:false}});
                	} else {
                		gridView.setOptions({panel: {visible:true}});
                	}
                }
            };
        }

        /* 총 Row수 출력 이벤트 */
        dataProvider.onRowCountChanged = function(provider, count) {
        	var $span = $g.prev('div.grid_top_wrap').find('div.grid_top_left span');
        	if ($span.length > 0) {
        		$span.text('(총 ' + count + '건)');
        	}

        	var stateRows = $g.dataProvider().getAllStateRows();
    		var createdLen = stateRows.created.length;
    		var updatadLen = stateRows.updated.length;
    		var deletedLen = stateRows.deleted.length;

    		// 행추가시 정렬기능 안되도록
        	if(createdLen > 0 || updatadLen > 0 || deletedLen > 0){
        		gridView.setOptions({
        			sorting: {
        				enabled: false,
        				toast: {visible: true, message: '정렬 중입니다.'}
        			}
        		});

        		if(options.mstGrid !== 'undefined' && options.mstGrid !== null && options.mstGrid !== ''){
        			$('#'+options.mstGrid).gridView().setOptions({
            			sorting: {
            				enabled: false,
            				toast: {visible: true, message: '정렬 중입니다.'}
            			}
            		});
        		}
        	} else {
        		gridView.setOptions({
        			sorting: {
        				enabled: options.sortable,
        				toast: {visible: true, message: '정렬 중입니다.'}
        			}
        		});
        	}
        };

        /* 셀 수정 이벤트 */
        gridView.onEditChange = function(grid, column, value) {
        	/* 팝업 이벤트 설정 */
        	for (var i=0, len=options.popupArr.length; i<len; i++) {
        		if (column.column === options.popupArr[i].name) {
        			if (typeof options.popupArr[i].outparam !== 'undefined') {
        				$.each(options.popupArr[i].outparam, function(k, v) {
        					if (v !== column.column) {
        						gridView.setValue(column.itemIndex, v, '');
        					}
        				});
        			}
        		}
        	}

    		// 데이터 수정시 정렬기능 안되도록
    		gridView.setOptions({
    			sorting: {
    				enabled: false,
    				toast: {visible: true, message: '정렬 중입니다.'}
    			}
    		});

    		if(options.mstGrid !== 'undefined' && options.mstGrid !== null && options.mstGrid !== ''){
    			$('#'+options.mstGrid).gridView().setOptions({
        			sorting: {
        				enabled: false,
        				toast: {visible: true, message: '정렬 중입니다.'}
        			}
        		});
    		}
		};

		/* 셀 수정완료 이벤트 */
		gridView.onCellEdited = function(grid, itemIdx, dataRow, fieldIdx) {
			grid.commit();
			/* 달력 이벤트 설정 */
        	for (var i=0, len=options.calendarArr.length; i<len; i++) {
        		if (dataProvider.getFieldName(fieldIdx) === options.calendarArr[i].name && gridView.getValue(itemIdx, options.calendarArr[i].name) != null &&
        				gridView.getValue(itemIdx, options.calendarArr[i].name).length > 0) {

        			var _val = gridView.getValue(itemIdx, options.calendarArr[i].name);
	        		if (cfn_isDateTime(_val)) {
	        			var _format = options.calendarArr[i].format;
	        			if (_format === 'yyyy-mm-dd') {
	        				_format = 'yyyyMMdd';
	        			} else if (_format === 'yyyy-mm-dd hh:ii:ss') {
	        				_format = 'yyyyMMddhhmmss';
	        			} else if (_format === 'yyyy-mm') {
	        				_format = 'yyyyMM';
	        			} else if (_format === 'yyyy-mm-dd hh:ii') {
	        				_format = 'yyyyMMddhhmm';
	        			} else if (_format === 'hh:ii:ss') {
		        			_format = 'hhmmss';
		        		} else if (_format === 'hh:ii') {
		        			_format = 'hhmm';
		        		}
	        			gridView.setValue(itemIdx, options.calendarArr[i].name, cfn_getDateFormat(_val, _format));
		            } else {
		            	gridView.setValue(itemIdx, options.calendarArr[i].name, '');
		            }
        		}
        	}

        	/* 팝업 이벤트 설정 */
			for (var i=0, len=options.popupArr.length; i<len; i++) {
        		if (dataProvider.getFieldName(fieldIdx) === options.popupArr[i].name &&
        				gridView.getValue(itemIdx, options.popupArr[i].name).length > 0 && options.popupArr[i].url !== '/sys/popup/popPost/view.do') {
        			var opt = {
        				gid: gid,
        				rowIdx: itemIdx,
        				colkey: dataProvider.getFieldName(fieldIdx),
        				url: options.popupArr[i].url,
        				inparam: options.popupArr[i].inparam,
        				outparam: options.popupArr[i].outparam,
        				params: options.popupArr[i].params,
        				returnFn: options.popupArr[i].returnFn,
        				btnflg: typeof options.popupArr[i].btnflg === 'undefined' ? false : options.popupArr[i].btnflg
        			};
    				gfn_popupProc(opt);
        		}
        	}

			var stateRows = dataProvider.getAllStateRows();
    		var createdLen = stateRows.created.length;
    		var updatadLen = stateRows.updated.length;
    		var deletedLen = stateRows.deleted.length;

    		// 행추가시 정렬기능 안되도록
        	if(createdLen > 0 || updatadLen > 0 || deletedLen > 0){
        		gridView.setOptions({
        			sorting: {
        				enabled: false,
        				toast: {visible: true, message: '정렬 중입니다.'}
        			}
        		});

        		if(options.mstGrid !== 'undefined' && options.mstGrid !== null && options.mstGrid !== ''){
        			$('#'+options.mstGrid).gridView().setOptions({
            			sorting: {
            				enabled: false,
            				toast: {visible: true, message: '정렬 중입니다.'}
            			}
            		});
        		}
        	} else {
        		gridView.setOptions({
        			sorting: {
        				enabled: options.sortable,
        				toast: {visible: true, message: '정렬 중입니다.'}
        			}
        		});
        	}
		};

        /* 버튼클릭 */
        gridView.onImageButtonClicked = function(grid, itemIdx, column, btnIdx, name) {
        	gridView.commit(true);

        	/* 달력 이벤트 설정 */
        	var calendarArr = options.calendarArr;
        	for (var i=0, len=calendarArr.length; i<len; i++) {
	        	if (column.name === calendarArr[i].name) {
	        		var cellPos = gridView.getCellBounds(itemIdx, column.name, true);
	        		var tag = '<div class="grid_datetimepicker_wrap" style="visibility:hidden;position:absolute;width:' + cellPos.width + 'px;height:' + cellPos.height +
					'px;top:'+cellPos.y+'px;left:'+cellPos.x+'px;background:red"><input type="text" class="grid_datetimepicker" /></div>';
	        		$('body').append(tag);
	        		var clickFn = calendarArr[i].clickFn;
	        		var calFn = calendarArr[i].calFn;

	        		$('input.grid_datetimepicker').datetimepicker({
	    	            language: 'ko',
	    	            format: calendarArr[i].format,
	    	            autoclose: true,
	    	            startView: calendarArr[i].startView,
	    	            minView: calendarArr[i].minView,
	    	            todayBtn: true,
	    	    		todayHighlight: true,
	    	    		showMeridian: true,
	    	    		forceParse: false
	    			}).on('hide', function(e) {
	    				$(this).datetimepicker('remove');
	    				$('div.grid_datetimepicker_wrap').remove();
	    			}).on('show', function(e) {
	    				$(this).datetimepicker('setPickerPosition', 'top-right');
	    				var date = gfn_dateFormat(gridView.getValue(itemIdx, column.name));
	    				$(this).val(date).datetimepicker('update');
	    			}).on('changeDate', function(e) {
	    				var date = $(e.target).val().replace(/[^0-9]/g, '');
	    				gridView.setValue(itemIdx, column.name, date);
	    				gridView.setFocus();

	    				if (typeof clickFn === 'function') {
	    					clickFn($('input.grid_datetimepicker'), itemIdx, date);
	    				}
	    			});

	        		if (typeof calFn === 'function') {
	        			calFn($('input.grid_datetimepicker'));
	        			$('input.grid_datetimepicker').datetimepicker('update').datetimepicker('show');
	        		} else {
	        			$('input.grid_datetimepicker').datetimepicker('show');
	        		}
	        	}
        	}

        	/* 팝업 이벤트 설정 */
        	var popupArr = options.popupArr;
        	for (var i=0, len=popupArr.length; i<len; i++) {
        		if (column.name === popupArr[i].name) {
        			var opt = {
        				gid: gid,
        				rowIdx: itemIdx,
        				colkey: column.name,
        				url: popupArr[i].url,
        				inparam: popupArr[i].inparam,
        				outparam: popupArr[i].outparam,
        				params: popupArr[i].params,
        				returnFn: options.popupArr[i].returnFn,
        				btnflg: true
        			};
    				gfn_popupProc(opt);
        		}
        	}
        }

    	gridObj[gid + 'dataProvider'] = dataProvider;
    	gridObj[gid + 'gridView'] = gridView;
    	gridObj[gid + 'options'] = options;
    	gridObj[gid + 'columns'] = columns;

	    return this;
	}

	$.fn.dataProvider = function() {
		return gridObj[this.attr('id') + 'dataProvider'];
	}

	$.fn.gridView = function() {
		return gridObj[this.attr('id') + 'gridView'];
	}

	$.fn.options = function() {
		return gridObj[this.attr('id') + 'options'];
	}
	
	$.fn.columns = function() {
		return gridObj[this.attr('id') + 'columns'];
	}

	$.fn.gfn_setGridEvent = function(fn) {
		var onRowCountChanged = this.dataProvider().onRowCountChanged;
		var onEditChange = this.gridView().onEditChange;
		var onCellEdited = this.gridView().onCellEdited;
		var onImageButtonClicked = this.gridView().onImageButtonClicked;
		var onContextMenuItemClicked = this.gridView().onContextMenuItemClicked;
		var contextMenu = typeof this.gridView()._gv._contextMenu === 'undefined' || this.gridView()._gv._contextMenu === null ? [] : this.gridView()._gv._contextMenu._items;

		fn(this.gridView(), this.dataProvider());

		var fnstr = fn.toString();
		var onRowCountChanged_new = this.dataProvider().onRowCountChanged;
		var onEditChange_new = this.gridView().onEditChange;
		var onCellEdited_new = this.gridView().onCellEdited;
		var onImageButtonClicked_new = this.gridView().onImageButtonClicked;
		var onContextMenuItemClicked_new = this.gridView().onContextMenuItemClicked;
		var contextMenu_new = typeof this.gridView()._gv._contextMenu === 'undefined' || this.gridView()._gv._contextMenu === null ? [] : this.gridView()._gv._contextMenu._items;

		if (fnstr.indexOf('onRowCountChanged') >= 0) {
			this.dataProvider().onRowCountChanged = function(provider, count) {
				var flg = onRowCountChanged_new(provider, count);
				if (typeof flg === 'undefined' || flg) {
					onRowCountChanged(provider, count);
				}
			}
		}

		if (fnstr.indexOf('onEditChange') >= 0) {
			this.gridView().onEditChange = function(grid, column, value) {
				var flg = onEditChange_new(grid, column, value);
				if (typeof flg === 'undefined' || flg) {
					onEditChange(grid, column, value);
				}
			}
		}

		if (fnstr.indexOf('onCellEdited') >= 0) {
			this.gridView().onCellEdited = function(grid, itemIdx, dataRow, fieldIdx) {
				var flg = onCellEdited_new(grid, itemIdx, dataRow, fieldIdx);
				if (typeof flg === 'undefined' || flg) {
					onCellEdited(grid, itemIdx, dataRow, fieldIdx);
				}
			}
		}

		if (fnstr.indexOf('onImageButtonClicked') >= 0) {
			this.gridView().onImageButtonClicked = function(grid, itemIdx, column, btnIdx, name) {
				var flg = onImageButtonClicked_new(grid, itemIdx, column, btnIdx, name);
				if (typeof flg === 'undefined' || flg) {
					onImageButtonClicked(grid, itemIdx, column, btnIdx, name);
				}
			}
		}

		if (fnstr.indexOf('onContextMenuItemClicked') >= 0) {
			this.gridView().onContextMenuItemClicked = function(grid, label, index) {
				var flg = onContextMenuItemClicked_new(grid, label, index);
				if (typeof flg === 'undefined' || flg) {
					onContextMenuItemClicked(grid, label, index);
				}
			}
		}

		if (fnstr.indexOf('setContextMenu') > 0) {
			var arr = [];
			for (var i=0; i<contextMenu_new.length; i++) {
				arr.push({label:contextMenu_new[i]._label});
			}
			if (contextMenu_new.length > 0 && contextMenu.length > 0) {
				arr.push({label:'-'});
			}
			for (var i=0; i<contextMenu.length; i++) {
				arr.push({label:contextMenu[i]._label});
			}

			this.gridView().setContextMenu(arr);
		}
	}

	/**
	 * 현재 선택된 Row 및 Column 정보 가져오기
	 * $('#그리드ID').gfn_getCurrent()
	 * @return {Json} dataRow: Row번호, itemIndex: 행번호, fieldIndex: 필드번호, column: 컬럼키, fieldName: 필드키
	 */
	$.fn.gfn_getCurrent = function() {
		return this.gridView().getCurrent();
	}

	/**
	 * 현재 선택된 DataRow번호 가져오기
	 * $('#그리드ID').gfn_getCurRowIdx()
	 * @return {Number} Row번호 (선택된게 없을땐 -1 반환)
	 */
	$.fn.gfn_getCurRowIdx = function() {
		return this.gridView().getCurrent().dataRow;
	}

	/**
	 * 현재 선택된 행번호 가져오기
	 * $('#그리드ID').gfn_getCurItemIdx()
	 * @return {Number} 행번호 (선택된게 없을땐 -1 반환)
	 */
	$.fn.gfn_getCurItemIdx = function() {
		return this.gridView().getCurrent().itemIndex;
	}

	/**
	 * 현재 선택된 Column명 가져오기
	 * $('#그리드ID').gfn_getCurColkey()
	 * @return {String} 컬럼키 (선택된게 없을땐 빈값 반환)
	 */
	$.fn.gfn_getCurColkey = function() {
		return this.gridView().getCurrent().dataRow !== -1 ? this.gridView().getCurrent().column : '';
	}

	/**
	 * 현재 선택된 Field번호 가져오기
	 * $('#그리드ID').gfn_getCurFieldIdx()
	 * @return {Number} 필드번호 (선택된게 없을땐 -1 반환)
	 */
	$.fn.gfn_getCurFieldIdx = function() {
		return this.gridView().getCurrent().dataRow !== -1 ? this.gridView().getCurrent().fieldIndex : -1;
	}

	/**
	 * 단일 Row 추가
	 * $('#그리드ID').gfn_addRow(data, position, rowidx, focusflg)
	 * @param {Json} data : 적용할 JSON 데이터
	 * @param {String} position : 추가할 Row위치 (first, last(기본값), before, after)
	 * @param {Boolean} rowidx : before, after일때 추가할 DataRow번호 위치 지정
	 * @param {Boolean} focusflg : 자동 포커스 여부 (기본값 true)
	 */
	$.fn.gfn_addRow = function(data, position, rowidx, focusflg) {
		this.gridView().commit(true);
		var _data = typeof data === 'undefined' || data === null ? {} : data;
		var _focusflg = typeof focusflg === 'undefined' || focusflg === null ? true : focusflg;
		var _rowidx = 0;

		if (position === 'first') {
			this.dataProvider().insertRow(_rowidx, _data);
		} else if (position === 'before') {
			this.dataProvider().insertRow(rowidx, _data);
			_rowidx = rowidx;
		} else if (position === 'after') {
			this.dataProvider().insertRow(rowidx + 1, _data);
			_rowidx = rowidx + 1;
		} else {
			this.dataProvider().addRow(_data);
			_rowidx = this.dataProvider().getRowCount() - 1;
		}

		if (_focusflg) {
			var index = {dataRow: _rowidx};
			this.gridView().setCurrent(index);
			this.gridView().showEditor();
			this.gridView().setFocus();
		}

		return this;
	}

	/**
	 * 다중 Row 추가
	 * $('#그리드ID').gfn_addRows(data, checkflg, focusflg)
	 * @param {Array} data : 적용할 배열 데이터
	 * @param {Boolean} focusflg : 자동 포커스 여부 (기본값 true)
	 */
	$.fn.gfn_addRows = function(data, focusflg) {
		this.gridView().commit(true);

		this.dataProvider().fillJsonData(data, {fillMode:'append'});

		if (typeof focusflg === 'undefined' || focusflg === null || focusflg) {
			var count = this.dataProvider().getRowCount() - 1;
			var index = {dataRow:count};
			this.gridView().setCurrent(index);
			this.gridView().showEditor();
			this.gridView().setFocus();
		}

		return this;
	}

	/**
	 * 단일 Row 삭제
	 * $('#그리드ID').gfn_delRow(rowidx)
	 * @param {String} rowidx : 삭제하려는 DataRow번호
	 */
	$.fn.gfn_delRow = function(rowidx) {
		this.gridView().commit(true);
		this.dataProvider().removeRow(rowidx);

		return this;
	}

	/**
	 * 다중 Row 삭제
	 * $('#그리드ID').gfn_delRows(rowidxs)
	 * @param {Array} rowidxs : 삭제하려는 Data Row번호 배열
	 */
	$.fn.gfn_delRows = function(rowidxs) {
		this.gridView().commit(true);
		this.dataProvider().removeRows(rowidxs);

		return this;
	}

	/**
	 * 셀 값 가져오기
	 * $('#그리드ID').gfn_getValue(rowidx, colkey)
	 * @param {String} rowidx : DataRow번호
	 * @param {String} colkey : 컬럼키
	 * @return 해당 셀 데이터
	 */
	$.fn.gfn_getValue = function(rowidx, colkey) {
		var itemidx = this.gridView().getItemIndex(rowidx);
		return this.gridView().getValue(itemidx, colkey);
	}

	/**
	 * 셀 값 넣기
	 * $('#그리드ID').gfn_setValue(rowidx, colkey, val)
	 * @param {String} rowidx : DataRow번호
	 * @param {String} colkey : 컬럼키
	 * @param {String} val : 넣을 값
	 */
	$.fn.gfn_setValue = function(rowidx, colkey, val) {
		var itemidx = this.gridView().getItemIndex(rowidx);
		return this.gridView().setValue(itemidx, colkey, val);
	}

	/**
	 * 그리드 전체 데이터 가져오기
	 * $('#그리드ID').gfn_getDataList(allflg, delflg)
	 * @param {Boolean} allflg : true: 모든 데이터, false: Row 상태별 데이터 (기본값 true)
	 * @param {Boolean} delflg : true: 삭제 데이터 포함, false: 삭제 데이터 미포함 (기본값 true)
	 * @return {Array} 그리드 배열 데이터
	 */
	$.fn.gfn_getDataList = function(allflg, delflg) {
		this.gridView().commit(true);
		var $g = this;
		var gridData = [];
		var _allflg = typeof allflg === 'undefined' || allflg === null ? true : allflg;
		var _delflg = typeof delflg === 'undefined' || delflg === null ? true : delflg;

		var stateRows = $g.dataProvider().getAllStateRows();
		var createdLen = stateRows.created.length;
		var updatadLen = stateRows.updated.length;
		var deletedLen = stateRows.deleted.length;

		if (_allflg) {
			gridData = $g.dataProvider().getJsonRows(0, -1);

			if (createdLen > 0) {
		        for (var i=0; i<createdLen; i++) {
					gridData[stateRows.created[i]].IDU = 'I';
				}
		    }

			if (updatadLen > 0){
				for (var i=0; i<updatadLen; i++) {
					gridData[stateRows.updated[i]].IDU = 'U';
				}
		    }

		    if (deletedLen > 0) {
	    		stateRows.deleted.sort(function(a, b) {
	    		    return b - a;
	    		});

	    		for (var i=0; i<deletedLen; i++) {
	    			if (_delflg) {
	    				gridData[stateRows.deleted[i]].IDU = 'D';
	    			} else {
	    				gridData.splice(stateRows.deleted[i], 1);
	    			}
	    		}
		    }
		} else {
			if (createdLen > 0) {
		        for (var i=0; i<createdLen; i++) {
					var rowData = $g.dataProvider().getJsonRow(stateRows.created[i]);
					rowData.IDU = 'I';
					gridData.push(rowData);
				}
		    }

			if (updatadLen > 0){
				for (var i=0; i<updatadLen; i++) {
					var rowData = $g.dataProvider().getJsonRow(stateRows.updated[i]);
					rowData.IDU = 'U';
					gridData.push(rowData);
				}
		    }

		    if (deletedLen > 0 && _delflg) {
		    	for (var i=0; i<deletedLen; i++) {
					var rowData = $g.dataProvider().getJsonRow(stateRows.deleted[i]);
					rowData.IDU = 'D';
					gridData.push(rowData);
				}
		    }
		}

		return gridData;
	}

	/**
	 * 그리드 다중 Rows 데이터 가져오기
	 * $('#그리드ID').gfn_getDataRows(rowidxs, allflg)
	 * @param {Array} rowidxs : Data Row번호 배열
	 * @param {Boolean} allflg : true: 모든 데이터, false: Row 상태별 데이터 (기본값 true)
	 * @return {Array} 그리드 배열 데이터
	 */
	$.fn.gfn_getDataRows = function(rowidxs, allflg) {
		var gridData = [];

		if (!Array.isArray(rowidxs) || rowidxs.length < 1) {
			return gridData;
		}

		this.gridView().commit(true);
		var _allflg = typeof allflg === 'undefined' || allflg === null ? true : allflg;

		for (var i=0, len=rowidxs.length; i<len; i++) {
			var rowData = this.dataProvider().getJsonRow(rowidxs[i]);
			var stateRow = this.dataProvider().getRowState(rowidxs[i]);

			if (stateRow === 'created') {
				rowData.IDU = 'I';
			} else if (stateRow === 'updated') {
				rowData.IDU = 'U';
			} else if (stateRow === 'deleted') {
				rowData.IDU = 'D';
			} else {
				if (_allflg) {
					rowData.IDU = '';
				} else {
					continue;
				}
			}
			gridData.push(rowData);
		}

		return gridData;
	}

	/**
	 * 그리드 단일 Row 데이터 가져오기
	 * $('#그리드ID').gfn_getDataRow(rowidx)
	 * @param {String} rowidx : DataRow번호
	 * @return {Json} 그리드 Row 데이터
	 */
	$.fn.gfn_getDataRow = function(rowidx) {
		var rowData = {};

		if (rowidx < 0) {
			return rowData;
		}

		this.gridView().commit(true);
		rowData = this.dataProvider().getJsonRow(rowidx);
		var stateRow = this.dataProvider().getRowState(rowidx);

		if (stateRow === 'created') {
			rowData.IDU = 'I';
		} else if (stateRow === 'updated') {
			rowData.IDU = 'U';
		} else if (stateRow === 'deleted') {
			rowData.IDU = 'D';
		} else {
			rowData.IDU = '';
		}

		return rowData;
	}

	/**
	 * 그리드 단일 Row 데이터 넣기
	 * $('#그리드ID').gfn_setDataRow(rowidx, data)
	 * @param {String} rowidx : DataRow번호
	 * @param {Json} data : 바인딩할 Row 데이터
	 */
	$.fn.gfn_setDataRow = function(rowidx, data) {
		this.gridView().commit(true);
		this.dataProvider().updateStrictRow(rowidx, data);

		return this;
	}

	/**
	 * 그리드 전체 데이터 바인딩
	 * $('#그리드ID').gfn_setDataList(gridData)
	 * @param {Array} gridData : 바인딩할 그리드 데이터
	 */
	$.fn.gfn_setDataList = function(gridData) {
		this.gfn_clearData();
		this.dataProvider().fillJsonData(gridData, {fillMode: 'set'});

		return this;
	}

	/**
	 * 그리드 전체 데이터 지움
	 * $('#그리드ID').gfn_clearData()
	 */
	$.fn.gfn_clearData = function() {
		this.gridView().hideEditor();
		this.gridView().commit();
		this.gridView().setAllCheck(false);
		this.dataProvider().clearRows();

		return this;
	}

	/**
	 * 그리드 데이터 전체 유효성 검사
	 * $('#그리드ID').gfn_checkValidateCells()
	 * @param {Array} rowidxs : 유효성검사할 DataRow번호 배열
	 * @return {Boolean} true: 에러 존재, false: 에러 없음
	 */
	$.fn.gfn_checkValidateCells = function(rowidxs) {

		// 팝업입력 내역 우선 확인
		var isPop = this.gfn_checkPopupValue();
		if(!isPop) return true;

		this.gridView().clearInvalidCellList();
		this.gridView().commit();
		var itemidx, checks, flg = false, msg = '';
		var columns = this.gridView().getColumns();

		for (var i=0, len=columns.length; i<len; i++) {
			if (typeof columns[i].requiredMessage !== 'undefined' && columns[i].requiredMessage !== null) {/*유효성 필수 값인지 체크*/
				if(!isNaN(columns[i].requiredMessage)){/*필수 값이 숫자인지 체크*/
					var minVal=columns[i].requiredMessage;
					this.gridView().setColumnProperty(columns[i].name, 'validations', [{criteria:"(value is not empty) and (value >= " + minVal + ")", message:columns[i].header.text+"는(은) "+minVal+" 이상 입력해야 합니다.", mode: "always",level: "error"}]);
				} else {
					this.gridView().setColumnProperty(columns[i].name, 'validations', [{criteria:"(value is not empty)", message:columns[i].header.text+"는(은) 필수입력입니다.", mode: "always", level: "error"}]);
				}
			}
		}

		if (typeof rowidxs === 'undefined' || rowidxs === null || rowidxs.length < 1) {
			checks = this.gridView().checkValidateCells();
		} else {
			itemidxs = this.gridView().getItemsOfRows(rowidxs);
			checks = this.gridView().checkValidateCells(itemidxs);
		}

		if (Array.isArray(checks) && checks.length > 0) {
			var _tmp = [];
			msg = '총 ' + checks.length + '건의 입력 오류가 있습니다.';

			for (var i=0, len=checks.length; i<len; i++) {
				if ($.inArray(checks[i].message, _tmp) === -1) {
					msg += '\n' + checks[i].message;
					_tmp.push(checks[i].message);
				}
			}

			flg = true;
			cfn_msg('WARNING', msg);
		}

		for (var i=0, len=columns.length; i<len; i++) {
			if (typeof columns[i].requiredMessage !== 'undefined' && columns[i].requiredMessage !== null) {
				this.gridView().setColumnProperty(columns[i].name, 'required', false);
				validations = null;
				this.gridView().setColumnProperty(columns[i].name, 'validations', validations);
			}
		}
		return flg;
	}

	/**
	 * 그리드 데이터중 팝업 내역에 대한 유효성 검사
	 * $('#그리드ID').gfn_checkPopupValue()
	 * @param {Array} rowidxs : 유효성검사할 DataRow번호 배열 default value = currentIdx
	 * @return {Boolean} false: 에러 존재, true: 에러 없음
	 */
	$.fn.gfn_checkPopupValue = function() {

		this.gridView().commit(true);
		var cidx = this.gridView().getCurrent().dataRow;
		var popupArr = this.options().popupArr;

		for (var i=0, len=popupArr.length; i<len; i++) {

			var popVal = this.gridView().getValue(cidx, popupArr[i].name);

			//우편번호는 체크하지 않음
			//분류 제외 
    		if (popVal !== 'undefined' && popVal != null && popVal !='' && popupArr[i].url !== '/sys/popup/popPost/view.do' && popupArr[i].url !== '/alexcloud/popup/popP018/view.do' && popupArr[i].url !== '/alexcloud/popup/popP017/view.do') {
    			var opt = {
    				gid: $(this).attr('id'),
    				rowIdx: cidx,
    				colkey: popupArr[i].name,
    				url: popupArr[i].url,
    				inparam: popupArr[i].inparam,
    				outparam: popupArr[i].outparam,
    				params: popupArr[i].params,
    				returnFn: popupArr[i].returnFn,
    				btnflg: typeof popupArr[i].btnflg === 'undefined' ? false : popupArr[i].btnflg
    			};

    			if(!gfn_popupValidation(opt))
    				return false;
    		}
    	}
		return true;
	}

	/**
	 * 코드/명칭 입력폼 팝업 이벤트 처리
	 * @param {object} opt : key/value 형태
	 */
	function gfn_popupValidation(opt) {
		var resultData, resultType, resultGridData = [];
		var $g = $('#' + opt.gid);

		var _inparam = {};

		$.each(opt.inparam, function(k, v) {
			if (opt.colkey !== v || !opt.btnflg) {
				_inparam[k] = $g.gridView().getValue(opt.rowIdx, v);
			}
		});

		$.each(opt.params, function(k, v) {
			_inparam[k] = v;
		});

		var rtnV = false;
		if (!opt.btnflg) {
			var sendData = {'paramData':_inparam};

			var url = opt.url.replace('/view.do', '/check.do');

			gfn_ajax(url, false, sendData, function(data, xhr) {
				resultGridData = data.resultList;

				if (resultGridData.length == 1) {
					rtnV = true;
				}
			});
		}

		return rtnV;
	}

	/**
	 * 컬럼 동적 Disabled 설정
	 * $('#그리드ID').gfn_setColDisabled(colkeys, flg)
	 * @param {Array} colkeys : Disabled 설정할 컬럼키
	 * @param {Boolean} flg : true: 수정가능, false: 수정불가
	 */
	$.fn.gfn_setColDisabled = function(colkeys, flg) {
		for (var i=0, len=colkeys.length; i<len; i++) {
			var imageobj = this.gridView().getColumnProperty(colkeys[i], 'imageButtons');
			var imageflg = 'none';
			if (typeof imageobj !== 'undefined' && imageobj !== null && flg) {
				imageflg = 'image';
			}

			this.gridView().setColumnProperty(colkeys[i], 'editable', flg);
			this.gridView().setColumnProperty(colkeys[i], 'button', imageflg);
		}
	}

	/**
	 * Row 동적 Disabled 설정
	 * $('#그리드ID').gfn_setRowDisabled(flg, excols)
	 * @param {Boolean} flg : true: 수정가능, false: 수정불가
	 * @param {Array} excols : Disabled 설정하지 않을 예외 컬럼키
	 */
	$.fn.gfn_setRowDisabled = function(flg, excols) {
		var cols = this.gridView().getColumnNames(false);

		if (typeof excols !== 'undefined' && excols !== null) {
			_.remove(cols, function(n) {
				var _flg = false;
				for (var i=0; i<excols.length; i++) {
					if (n === excols[i]) {
						_flg = true;
					}
				}
				return _flg;
			});
		}

		for (var i=0, len=cols.length; i<len; i++) {
			var imageobj = this.gridView().getColumnProperty(cols[i], 'imageButtons');
			var imageflg = 'none';
			if (typeof imageobj !== 'undefined' && imageobj !== null && flg) {
				imageflg = 'image';
			}

			this.gridView().setColumnProperty(cols[i], 'editable', flg);
			this.gridView().setColumnProperty(cols[i], 'button', imageflg);
		}
	}

	/**
	 * 그리드 행 포커스 처리
	 * $('#그리드ID').gfn_focusPK()
	 */
	$.fn.gfn_focusPK = function() {
		var gid = $(this).attr('id');

		if (typeof ctObj[gid + 'PKObj'] !== 'undefined') {
			var _fields = [], _values = [];

			$.each(ctObj[gid + 'PKObj'], function(k, v) {
				_fields.push(k);
				_values.push(v);
			});

			var options = {fields: _fields, values: _values, select: true};
			var itemindex = this.gridView().searchItem(options);
		}

		ctObj[gid + 'PKObj'] = undefined;
	}

	/**
	 * 그리드 행 포커스 저장
	 * $('#그리드ID').gfn_setFocusPK(colkeys, flg)
	 * @param {Json} data : Disabled 설정할 컬럼키
	 * @param {Array} pkArr : true: 수정가능, false: 수정불가
	 */
	$.fn.gfn_setFocusPK = function(data, pkArr) {
		var gid = $(this).attr('id');
		var pkobj = {};

		$.each(data, function(k, v) {
			for (var i=0, len=pkArr.length; i<len; i++) {
				if (k === pkArr[i]) {
					pkobj[k] = v;
				}
			}
		});

		ctObj[gid + 'PKObj'] = pkobj;
	}
})();

function gfn_colSetting(column, options) {
	var col = $.extend({
		styles: {textAlignment:'near'},
		editable: false
	}, column);

	if (typeof col.fieldName === 'undefined' || col.fieldName === null) {
		col.fieldName = col.name;
	}

	if (col.editable) {
		col.editor = $.extend({textAlignment:col.styles.textAlignment}, col.editor);
	}

	if (col.required) {
		col.required = false;
		/*20171013 유효성 검사 추가사항
		 * OTOO 현재 숫자입력그리드에는 양수만 입력할수있음
		 * 숫자를 입력 받는 컬럼에서 0을 포함하여 유효성검사를 하거나 0을 미포함하여 유효성검사를 하는 기능 추가
		 * 그리드 생성시 required:true 설정한 컬럼에서만 minVal 값을 설정할수있다.
		 * minVal:0 설정시 0을 미포함하여 유효성 검사를 진행 - 결론 0입력시 오류메시지 발생
		 * 0이외의 숫자를 입력시 입력한 숫자의 이상의 값만 유효성 검사를 진행한다.
		 *
		 * if(col.minVal != 'undefined' && col.minVal != null){
			col.requiredMessage = col.minVal;
		   } else {
			col.requiredMessage = col.header.text + '는(은) 필수 입력 입니다.';
		   }
		 *
		 * */

		//col.requiredMessage = col.header.text + '는(은) 필수 입력 입니다.';
		if(col.minVal != 'undefined' && col.minVal != null){
			col.requiredMessage = col.minVal;
		} else {
			col.requiredMessage = col.header.text + '는(은) 필수 입력 입니다.';
		}
		col.header.subText = '*';
		col.header.subTextGap = 1;
		col.header.subTextLocation = 'left';
		col.header.subStyles = {foreground: '#FF0000', fontSize: 12};
	}

	if (typeof col.show !== 'undefined' && col.show !== null && !col.show) {
		col.visible = false;
		col.tag = 'invisible';
	}

	//데이터 포맷 셋팅
	switch(col.formatter) {
		case 'date':
			col.editor = $.extend(col.editor, {type:'text', mask:'9999-99-99'});
			col.displayRegExp = '([0-9]{4})([0-9]{2})([0-9]{2})';
			col.displayReplace = '$1-$2-$3';
			if (col.editable) {
				col.button = 'image';
				col.buttonVisibility = 'rowfocused';
				col.imageButtons = $.extend({width: 22, height: 22, images: [{
					up:'/images/lingoframework/cmmn/btn_calendar.png',
					hover:'/images/lingoframework/cmmn/btn_calendar.png',
					down:'/images/lingoframework/cmmn/btn_calendar.png'
				}]}, col.imageButtons);
				options.calendarArr.push({name: col.name, format: 'yyyy-mm-dd', startView: 'month', minView: 'month', calFn: col.calFn, clickFn: col.clickFn});
			}
			break;
		case 'datetime':
			col.editor = $.extend(col.editor, {type:'text', mask:'9999-99-99 99:99:99'});
			col.displayRegExp = '([0-9]{4})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})';
			col.displayReplace = '$1-$2-$3 $4:$5:$6';
			if (col.editable) {
				col.button = 'image';
				col.buttonVisibility = 'rowfocused';
				col.imageButtons = $.extend({width: 22, height: 22, images: [{
					up:'/images/lingoframework/cmmn/btn_calendar.png',
					hover:'/images/lingoframework/cmmn/btn_calendar.png',
					down:'/images/lingoframework/cmmn/btn_calendar.png'
				}]}, col.imageButtons);
				options.calendarArr.push({name: col.name, format: 'yyyy-mm-dd hh:ii:ss', startView: 'month', minView: 'day', calFn: col.calFn, clickFn: col.clickFn});
			}
			break;
		case 'datehm':
			col.editor = $.extend(col.editor, {type:'text', mask:'9999-99-99 99:99'});
			col.displayRegExp = '([0-9]{4})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})';
			col.displayReplace = '$1-$2-$3 $4:$5';
			if (col.editable) {
				col.button = 'image';
				col.buttonVisibility = 'rowfocused';
				col.imageButtons = $.extend({width: 22, height: 22, images: [{
					up:'/images/lingoframework/cmmn/btn_calendar.png',
					hover:'/images/lingoframework/cmmn/btn_calendar.png',
					down:'/images/lingoframework/cmmn/btn_calendar.png'
				}]}, col.imageButtons);
				options.calendarArr.push({name: col.name, format: 'yyyy-mm-dd hh:ii', startView: 'month', minView: 'day', calFn: col.calFn, clickFn: col.clickFn});
			}
			break;
		case 'yearmonth':
			col.editor = $.extend(col.editor, {type:'text', mask:'9999-99'});
			col.displayRegExp = '([0-9]{4})([0-9]{2})';
			col.displayReplace = '$1-$2';
			if (col.editable) {
				col.button = 'image';
				col.buttonVisibility = 'rowfocused';
				col.imageButtons = $.extend({width: 22, height: 22, images: [{
					up:'/images/lingoframework/cmmn/btn_calendar.png',
					hover:'/images/lingoframework/cmmn/btn_calendar.png',
					down:'/images/lingoframework/cmmn/btn_calendar.png'
				}]}, col.imageButtons);
				options.calendarArr.push({name: col.name, format: 'yyyy-mm', startView: 'year', minView: 'year', calFn: col.calFn, clickFn: col.clickFn});
			}
			break;
		case 'time':
			col.editor = $.extend(col.editor, {type:'text', mask:'99:99:99'});
			col.displayRegExp = '([0-9]{2})([0-9]{2})([0-9]{2})';
			col.displayReplace = '$1:$2:$3';
			if (col.editable) {
				col.button = 'image';
				col.buttonVisibility = 'rowfocused';
				col.imageButtons = $.extend({width: 22, height: 22, images: [{
					up:'/images/lingoframework/cmmn/btn_calendar.png',
					hover:'/images/lingoframework/cmmn/btn_calendar.png',
					down:'/images/lingoframework/cmmn/btn_calendar.png'
				}]}, col.imageButtons);
				options.calendarArr.push({name: col.name, format: 'hh:ii:ss', startView: 'day', minView: 'day', calFn: col.calFn, clickFn: col.clickFn});
			}
			break;
		case 'timehm':
			col.editor = $.extend(col.editor, {type:'text', mask:'99:99'});
			col.displayRegExp = '([0-9]{2})([0-9]{2})';
			col.displayReplace = '$1:$2';
			if (col.editable) {
				col.button = 'image';
				col.buttonVisibility = 'rowfocused';
				col.imageButtons = $.extend({width: 22, height: 22, images: [{
					up:'/images/lingoframework/cmmn/btn_calendar.png',
					hover:'/images/lingoframework/cmmn/btn_calendar.png',
					down:'/images/lingoframework/cmmn/btn_calendar.png'
				}]}, col.imageButtons);
				options.calendarArr.push({name: col.name, format: 'hh:ii', startView: 'day', minView: 'day', calFn: col.calFn, clickFn: col.clickFn});
			}
			break;
		case 'combo':
			var comboData = gfn_getCombo(col.comboValue);
			col.values = comboData.values;
			col.labels = comboData.labels;
			col.lookupDisplay = true;
			if (col.editable) {
				col.editor = $.extend({type: 'dropDown', dropDownCount: 10, domainOnly: true}, col.editor);
			}
			break;
		case 'popup':
			if (col.editable) {
				col.button = 'image';
				col.buttonVisibility = 'rowfocused';
				col.imageButtons = $.extend({width: 22, height: 22, images: [{
					up:'/images/lingoframework/cmmn/btn_search2.png',
					hover:'/images/lingoframework/cmmn/btn_search2.png',
					down:'/images/lingoframework/cmmn/btn_search2.png'
				}]}, col.imageButtons);
				options.popupArr.push($.extend({name:col.name}, col.popupOption));
			}
			break;
		case 'link':
			col.styles = $.extend({fontUnderline: true, foreground: '#3366cc'}, col.styles);
			col.cursor = 'pointer';
			break;
		case 'checkbox':
			col.styles = $.extend({figureBackground: '#008800'}, col.styles);
			col.renderer = $.extend({type: 'check', trueValues:'Y,y,1', falseValues: 'N,n,0', startEditOnClick: true, editable: true}, col.renderer);
			break;
		case 'btnsearch':
			col.button = 'image';
			col.alwaysShowButton = true;
			col.groupable = false;
			col.sortable = false;
			col.resizable = false;
			col.cursor = 'pointer';
			col.imageButtons = $.extend({width: 22, height: 22, margin: 8, images: [{
				up:'/images/lingoframework/cmmn/btn_search2.png',
				hover:'/images/lingoframework/cmmn/btn_search2.png',
				down:'/images/lingoframework/cmmn/btn_search2.png'
			}]}, col.imageButtons);
			break;
		case 'progressbar':
			col.defaultValue = '0';
			col.styles = $.extend(col.styles, {figureSize: '70%', textAlignment: 'center', fontBold: true, suffix: '%'});
			col.renderer = $.extend(col.renderer, {type: 'bar', minimum: 0, maximum: 100, showLabel: true});
			break;
	}

	delete col.formatter;
	delete col.comboValue;
	delete col.popupOption;
	delete col.show;

	return col;
}

/**
 * 그리드 콤보 데이터로 변환
 * @param {string} str : key/value 리스트의 문자열 (key1:value1;key2:value2)
 */
function gfn_getCombo(str) {
	var rtnobj = {values:[],labels:[]};

	if (typeof str === 'undefined' || str === null || str.replace(/(^\s*)|(\s*$)/gi, '').length === 0) {
		return rtnobj;
	}

	var arr = str.split(';');

	for (var i=0, len=arr.length; i<len; i++) {
		var kv = arr[i].split(':');
		rtnobj.values.push(kv[0]);
		rtnobj.labels.push(kv[1]);
	}

	return rtnobj;
}

/**
 * 그리드 데이터 CSV Export 처리
 * @param {string} gid : 그리드ID
 */
function gfn_csvExport(gid) {
	var $g = $('#' + gid);
	var title = 'gridCSV';
	if ($g.prev('div.grid_top_wrap').children('div.grid_top_left').length > 0) {
		var str = $g.prev('div.grid_top_wrap').children('div.grid_top_left').html().replace(/(^\s*)|(\s*$)/gi, '');
		if (str.length > 0 && str.indexOf('<span>') >= 0) {
			title = str.substring(0, str.indexOf('<span>'));
		}
		title = title.replace(/(^\s*)|(\s*$)/gi, '');
	}

	var gridData = $g.gfn_getDataList(true);
	var columns = $g.gridView().getColumns();
	var colNames = [], excludeColumns = [];

	if (cfn_isEmpty(gridData)) {
		cfn_msg('WANRING', '데이터가 없습니다.');
		return false;
	}

	$.each(gridData[0], function(k, v) {
		if ($g.gridView().getColumnProperty(k, 'visible')) {
			colNames.push($g.gridView().getColumnProperty(k, 'header').text);
		} else {
			excludeColumns.push(k);
		}
	});

	cfn_exportCSV({
		data: gridData,
		headers: colNames,
		excludeColumns: excludeColumns,
		fileName: title
	});
}

/**
 * 그리드 데이터 엑셀 Export 처리
 * @param {string} gid : 그리드ID
 */
function gfn_excelExport(gid) {
	var $g = $('#' + gid);
	var title = 'gridExcel';
	if ($g.prev('div.grid_top_wrap').children('div.grid_top_left').length > 0) {
		var str = $g.prev('div.grid_top_wrap').children('div.grid_top_left').html().replace(/(^\s*)|(\s*$)/gi, '');
		if (str.length > 0 && str.indexOf('<span>') >= 0) {
			title = str.substring(0, str.indexOf('<span>'));
		}
		title = title.replace(/(^\s*)|(\s*$)/gi, '');
	}

	$g.gridView().exportGrid({
        type: 'excel',
        target: 'local',
        fileName: title + '.xlsx',
        showProgress: 'Y',
        applyDynamicStyles: true,
        progressMessage: '엑셀 Export중입니다.',
        indicator: 'default',
        header: 'default',
        footer: 'default',
        compatibility: '2010',
        lookupDisplay:true,
        done: function() {
        }
    });
}

/**
 * 코드/명칭 입력폼 팝업 이벤트 처리
 * @param {object} opt : key/value 형태
 */
function gfn_popupProc(opt) {
	var resultData, resultType, resultGridData = [];
	var $g = $('#' + opt.gid);

	var _inparam = {};

	$.each(opt.inparam, function(k, v) {
		if (opt.colkey !== v || !opt.btnflg) {
			_inparam[k] = $g.gridView().getValue(opt.rowIdx, v);
		}
	});

	$.each(opt.params, function(k, v) {
		_inparam[k] = v;
	});

	if (!opt.btnflg) {
		var sendData = {'paramData':_inparam};
		var url = opt.url.replace('/view.do', '/search.do');

		gfn_ajax(url, false, sendData, function(data, xhr) {
			resultGridData = data.resultList;

			if (resultGridData.length === 1) {
				$.each(opt.outparam, function(k, v) {
					$g.gridView().setValue(opt.rowIdx, v, resultGridData[0][k]);
				});

				if (typeof opt.returnFn === 'function') {
					opt.returnFn(resultGridData);
				}
			}
		});
	}

	if (resultGridData.length === 1) {
		return false;
	}

	_inparam.gridData = resultGridData;

	pfn_popupOpen({
		url: opt.url,
		pid: opt.pid,
		params: _inparam,
		selfFrameFlg: false,
		returnFn: function(data, type) {
			resultType = type;
			resultData = data;
			if (cfn_isEmpty(data) && !opt.btnflg) {
				$.each(opt.outparam, function(k, v) {
					$g.gridView().setValue(opt.rowIdx, v, '');
				});
			} else if (data.length === 1) {
				$.each(opt.outparam, function(k, v) {
					$g.gridView().setValue(opt.rowIdx, v, data[0][k]);
				});
			}

			$g.gridView().setFocus();

			if (typeof opt.returnFn === 'function') {
				opt.returnFn(resultData, resultType);
			}
		}
	});
}

/**
 * 날짜 형식으로 변환
 */
function gfn_dateFormat(val) {
	var _val = val;

	if (!cfn_isEmpty(_val)) {
		_val = _val.replace(/[^0-9]/g, '');

		if (_val.length === 6) {
			_val = _val.substring(0, 4) + '-' + _val.substring(4, 6);
		} else if (_val.length === 8) {
			_val = _val.substring(0, 4) + '-' + _val.substring(4, 6) + '-' + _val.substring(6, 8);
		} else if (_val.length === 12) {
			_val = _val.substring(0, 4) + '-' + _val.substring(4, 6) + '-' + _val.substring(6, 8) +
					' ' + _val.substring(8, 10) + ':' + _val.substring(10, 12);
		} else if (_val.length === 14) {
			_val = _val.substring(0, 4) + '-' + _val.substring(4, 6) + '-' + _val.substring(6, 8) +
					' ' + _val.substring(8, 10) + ':' + _val.substring(10, 12) + ':' + _val.substring(12, 14);
		}
	} else {
		_val = '';
	}

	return _val;
}

/**
 * 엑셀업로드
 * gfn_fixdata,gfn_handleXlsFile,gfn_process_wb,gfn_setFieldsSetColumns,gfn_to_json
 * 엑셀 데이터 변경
 */

function gfn_fixdata(data) {
	var o = "", l = 0, w = 10240;
	for (; l < data.byteLength / w; ++l) o += String.fromCharCode.apply(null, new Uint8Array(data.slice(l * w, l * w + w)));
	o += String.fromCharCode.apply(null, new Uint8Array(data.slice(l * w)));

	return o;
}
/**
 * 엑셀 파일 읽기
 */ 
function gfn_handleXlsFile(e, gid, gridColumns) {
	
	var fileName = e.target.files[0].name;
	if(fileName.substr(fileName.length - 4, 4) !== 'xlsx'){
		cfn_msg('ERROR', 'EXCEL파일을 올리시기 바랍니다.');
		return false;
	}
	
	if (cfn_isEmpty(e.target.files[0]) === false) {
		$('#'+gid).dataProvider().clearRows();
	}
	
	var files = e.target.files;
	var i, f;
	for (i = 0, f = files[i]; i != files.length; ++i) {
		var reader = new FileReader();
		var name = f.name;
		reader.onload = function (e) {
			var data = e.target.result;
			var arr = gfn_fixdata(data);
			var workbook = XLSX.read(btoa(arr), { type: 'base64' });
 
			gfn_process_wb(workbook, gid, gridColumns);
		};
		
		reader.readAsArrayBuffer(f); 
	}
}
/**
 * 
 */ 
function gfn_process_wb(wb, gid, gridColumns) {
	var output = gfn_to_json(wb, gridColumns);
	var sheetNames = Object.keys(output);
	if (sheetNames.length > 0) {
		var colsObj = output[sheetNames[0]][0]; // 1번 시트의 내역만 가져오도록 함
		if (colsObj) {
			// gfn_setFieldsSetColumns(colsObj, gid);
			$('#'+gid).dataProvider().fillJsonData(output, { rows: sheetNames[0], start: 1 })
		}
	}
}

function gfn_to_json(workbook, gridColumns) {
	var result = {};
	workbook.SheetNames.forEach(function (sheetName) {
		var roa = XLSX.utils.sheet_to_row_object_array(workbook.Sheets[sheetName], { header: gridColumns });
		if (roa.length > 0) {
			result[sheetName] = roa;
		}
	});
	
	return result;
}