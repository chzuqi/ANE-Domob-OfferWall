// index.js
;
var DATA = {}, 
	ITEMS = {}, 
	APPEAL = {},
	IMPLIST_ID = [],
	IMPLIST_TR = [],
	UNIT = '积分';
	NULL_CONTENT = '亲，今天的奖励赠送完了，<br/>您可以体验已经安装过的应用，<br/>或者明天再来领取新的奖励～';
	DEV = DATA.unit_name?true:false;

function initTemplateCallback (jsonObj) {
	DATA = jsonObj;
	UNIT = DATA && DATA.unit_name || UNIT;
	init();
}
function init(){
	//清空 展示报告列表、item map
	IMPLIST_ID = [];
	IMPLIST_TR = [];
	ITEMS = {};

	if(!(DATA&&DATA.control)){
		__showMsg();
		return
	}
	UNIT = DATA && DATA.unit_name || UNIT;
	$('.unit').html(UNIT);


	var tmpList = [];
	if(!(DATA.todo_list && __alterList(DATA.todo_list, 'game'))){
		__showMsg(NULL_CONTENT);
	}
	if(!(DATA.signin_list && __alterList(DATA.signin_list, 'open', true))){
		$('#open_wrapper').hide();
	}
	if(!(DATA.done_list && __alterList(DATA.done_list, 'done', true))){
		$('#done_wrapper').hide();
	}
	if(!DATA.control.appeal_enable){
		$('#btn_repo').hide();
	}
	if(DATA.control.video_enable){
		$('#video_wrapper').show();
	}
	__sdk('impReport', {'ids':IMPLIST_ID.join(','), 'trs':IMPLIST_TR.join(',')});
	__showPage();
}
function __alterList (list, listName, action_string) {
	var tmpList = [];
	for (var i = 0; i < list.length ; i++) {
		if(!list[i].installed){
			ITEMS[list[i].id] = list[i];
			list[i].action_url += '&id='+ list[i].id;
			tmpList.push(list[i]);
			IMPLIST_ID.push(list[i].id);
			IMPLIST_TR.push(list[i].tr);
		}
	};
	$('#'+listName+'list').empty().append(__buildItems(tmpList, action_string));
	if(tmpList.length)$('#'+listName+'_wrapper').show();
	return tmpList.length>0;
}
function __showMsg(msg) {
	$('#gamelist').empty().append('<li><div id="msgs"><p class="empty">'+(msg?msg:'亲，您的网络好像有问题哦，<br/>请检查网络连接，或刷新重试。')+'</p><p><button class="btn_refresh ac_refresh" type="button">刷新</button></p></div></li>');
	__showPage();
}
function __showLog(msg) {
	$('#gamelist').prepend('<li><div id="msgs"><p class="empty">'+(msg?msg:'亲，您的网络好像有问题哦，<br/>请检查网络连接，或刷新重试。')+'</p><p><button class="btn_refresh ac_refresh" type="button">刷新</button></p></div></li>');
	__showPage();
}
var __refreshTimeout;
var __refresh =  window.refresh = function(msg) {
	$('#gamelist').empty().append('<li><div id="msgs" class="loading"></div></li>');
	$('.ac_back2list').each(function(){
		if(parseInt($(this).closest('.box').css('marginLeft')) === 0){
			$(this).trigger('touchend')
		}
	});
	$('#open_wrapper, #done_wrapper').hide();

	if(__refreshTimeout) clearTimeout(__refreshTimeout);
	scroll_list && scroll_list.destroy && scroll_list.destroy();

	__refreshTimeout=setTimeout((function(){
		if(DEV){
			init();
		}else{
			__sdk('refresh', {'callback':'initTemplateCallback'});
		}
	}),1000);
}
var scroll_list,scroll_help, __scale = 1;
function __showPage() {
	setTimeout((function(){
		scroll_list && scroll_list.destroy && scroll_list.destroy();
		scroll_help && scroll_help.destroy && scroll_help.destroy();

		scroll_list = new iScroll('game_scroller', {"bounce":false});
		scroll_help = new iScroll('help_scroller', {"bounce":false});
	}), 500);
}
function __buildTag(tag) {
	switch(tag){
		case "1":
		case 1:
			return '<span class="bg tag new">new</span>';
		case "2":
		case 2:
			return '<span class="bg tag hot">hot</span>';
		default:
			return '';
	}
}

function __buildItems(items, nodetail, action_string) {
	if(!items.length) return '';

	var tmp = [], tagHTML;
	for(var i=0; i< items.length; i++){
		if(action_string)items[i].action_string = action_string;
		if(nodetail)items[i].opendetails = false;
		tagHTML = __buildTag(items[i].ad_tag);	

		tmp.push(['<li class="'+(items[i].opendetails?'ac_go_detail':'ac_do_action')+'" srv="'+items[i].id+'">',
					'<div class="game_banner">',
						'<span href="javascript:void(0)" class="link_detail">',
							tagHTML,
							'<img class="game_icon" alt="'+items[i].name+'" src="'+items[i].logo+'">',
						'</span>',
						'<h4 class="game_name">'+items[i].name+'</h4>',
						'<p class="todo">'+items[i].texts+'</p>',
					'</div>',
					'<div class="download_info">',
						'<p class="points">'+items[i].point+UNIT+'</p>',
						'<span class="bg icon_go link_go" srv="'+items[i].action_url+'" href="javascript:void(0);">'+items[i].action_string+'</span>',
					'</div>',
				'</li>'].join(''));
	}
	return tmp.join('');
}

var __scroll_detail;
function __openDetail(target) {
	var app_id = $(target).attr('srv'), 
		item = ITEMS[app_id]||{},
		tmpHTML,
		tagHTML,
		thumbHTML = '';
	if(!item.id)return;

	if(__scroll_detail&&__scroll_detail.destroy){
		__scroll_detail.destroy();
		__scroll_detail = null;
	}
	tagHTML = __buildTag(item.ad_tag);
	if(item.screenshot && item.screenshot.length){
		var thumbItems = [];
		for (var i = 0; i < item.screenshot.length; i++) {
			thumbItems.push('<li><img alt="" src="'+item.screenshot[i]+'"></li>');
		};
		thumbHTML =	['<div class="screenshots">',
						'<ul>',
							thumbItems.join(''),
						'</ul>',
					'</div>'].join('');
	}
	tmpHTML = ['<div class="game">',
					'<div class="game_banner">',
						'<span href="javascript:void(0)" class="link_detail">',
							// tagHTML,
							'<img class="game_icon" alt="'+item.name+'" src="'+item.logo+'">',
						'</span>',
						'<h4 class="game_name">'+item.name+'</h4>',
						'<p class="todo">版本：<em>'+item.ver+'</em>  大小：<em>'+item.size+'</em></p>',
					'</div>',
					'<div class="download_info ac_do_action" srv="'+item.id+'">',
						'<span class="bg icon_go link_go" srv="'+item.action_url+'">'+item.action_string+'</span>',
					'</div>',
				'</div>',
				'<div class="offer">',
					'<h4>'+item.point+UNIT+'</h4>',
					'<div class="offer_content">',
						item.detail.replace(/\n/g,'<br/>'),
					'</div>',
				'</div>',
				thumbHTML,
				'<div class="description">',
					'<h2 name="description_title" id="description_title">简介</h2>',
					'<div id="description_content" class="content">',
						item.description.replace(/\n/g,'<br/>'),
					'</div>',
				'</div>',
			'</div>'].join('');
	$('#detail .detail_body').empty().append(tmpHTML);
	$('#detail .screenshots li:last').addClass('last');
	$('#detail .btn_action').attr('href', item.action_url);
	$('#detail').css('marginLeft', 0);
	$('#detail .screenshots img').bind('load', function(){__updateDetailScroll()});
	__updateDetailScroll(500);
}
var __updateDetailScrollTimeout;
function __updateDetailScroll (delay){
	if(__updateDetailScrollTimeout)clearTimeout(__updateDetailScrollTimeout);
	__updateDetailScrollTimeout = setTimeout((function(){
		if(__scroll_detail&&__scroll_detail.destroy){
			__scroll_detail.destroy();
			__scroll_detail = null;
		}
		__scroll_detail = new iScroll('detail_scroller', {"bounce":false});
	}),delay || 100);
}
function __removeTags (item){
	// setTimeout((function(){$(item).find('.tag').remove();}),1000);
}
function appealCallback (jsonObj) {
	APPEAL = jsonObj;

	var tmpHTML = ['<option value="" disabled>下载安装的应用名称</option>'];
	if(APPEAL.doneList){
		$.each(APPEAL.doneList, function (app_id, app_info) {
			tmpHTML.push('<option value="'+app_id+'">'+app_info.name+'</option>')
		})
	}
	$('#repo_email').val(APPEAL.email||'');
	$('#sdk_version').html(APPEAL.sdk_version||'');
	$('#device_id').html(APPEAL.device_id||'');
	$('#select_repo_app').empty().append(tmpHTML.join(''));
	$('#repo').css('marginLeft',0);
	__hasBack = true;
}
// TODO: 投诉结果
function appealResult() {
	alert(JSON.stringify(arguments));
}
function __sdk (functionName, data) {
	var tmpData = [],
		req = 'domob://' + functionName + '/';
	if(data){
		$.each(data, function (key, value){
			tmpData.push(key + '=' + encodeURIComponent(value));
		});
		req += '?' + tmpData.join('&');
	}
	DEV?(console?console.log(req):__showLog(req)):(window.location = req);
}

var __hasBack = false;
function back(){
	if(__hasBack){
		$('.ac_back2list').each(function(){
			if(parseInt($(this).closest('.box').css('marginLeft')) === 0){
				$(this).trigger('touchend')
			}
		});
	}else{
		__sdk('close');
	}
	// __hasBack = false;
	document.body.style.zoom = __scale;
}

var __lastClickTime=1;
function __cancelDoubleTouchEnd(event){
	var now = event.timeStamp || (new Date()).valueOf()*1;
	if(now - __lastClickTime < 1000){
		event.cancelBubble = true;
		event.preventDefault();
		return false;
	}
	__lastClickTime = now;
	return true;
}
$(function(){
	if(navigator.userAgent.match(/AppleWebKit\/(\d+)/) && navigator.userAgent.match(/AppleWebKit\/(\d+)/)[1] <= 533){
		$('body').addClass('quirk');
	}
	//初始化列表
	if(DEV){
		init();
	}else{
		__sdk('initTemplate', {'callback':'initTemplateCallback'});
	}
	setTimeout((function(){
		__zoomToFill();
		document.body.style.opacity = "1";
	}), 300);
	function __zoomToFill(){
		// var deviceWidth = document.documentElement.clientWidth,
		// 	deviceHeight = document.documentElement.clientHeight;

		// __scale = deviceWidth/360;
		// document.body.style.zoom = __scale;
	}
	$(window).on('resize', function(){setTimeout(scrollTo,0,0,0);__zoomToFill();__showPage();__updateDetailScroll(500);})
		.on('load', function(){setTimeout(scrollTo,0,0,0);});
	
	//事件绑定
	$('body')
		.on('touchend', '.ac_quit', function(e){
			if(e && !__cancelDoubleTouchEnd(e))return false;

			__sdk('close');
		})
		.on('touchend', '.ac_back2list', function(e){
			if(e && !__cancelDoubleTouchEnd(e))return false;

			var $box = $(this).closest('.box');
			$box.css('marginLeft', '100%');
			__hasBack = false;
		})
		.on('click', '.ac_do_action', function(e){
			if(e && !__cancelDoubleTouchEnd(e))return false;

			var app_id = $(this).attr('srv');
			window.location.href = $('.link_go',this).attr('srv');
			__removeTags(this);
		})
		.on('click', '.ac_go_detail', function(e){
			if(e && !__cancelDoubleTouchEnd(e))return false;

			__openDetail(this);
			__hasBack = true;
			__removeTags(this);
		})
		.on('touchend', '.ac_refresh', function(e){
			if(e && !__cancelDoubleTouchEnd(e))return false;
			
			__refresh();
		})
		.on('touchend', '#btn_repo', function(e){
			if(e && !__cancelDoubleTouchEnd(e))return false;
			
			// window.sdk.initAppeal('appealCallback');
			__sdk('initAppeal', {'callback':'appealCallback'});
		})
		.on('touchend', '#btn_help', function(e){
			if(e && !__cancelDoubleTouchEnd(e))return false;
			
			$('#help').css('marginLeft',0);
			__hasBack = true;
		});
	$('#select_repo_app').change(function(){
		$('#repo_app_pkg').val(APPEAL.doneList[this.value].pkg);
	});
});
