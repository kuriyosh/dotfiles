
((digest . "eb43dd34909df2f5750532bbdd389c3e") (undo-list nil (1014 . 1015) nil (1012 . 1013) ("(" . -1012) ((marker . 1012) . -1) (1012 . 1014) ("(" . -1012) ((marker . 1012) . -1) ((marker . 1012) . -1) (1012 . 1013) nil (1004 . 1012) ("make" . -1004) ((marker . 1015) . -4) 1008 nil (1003 . 1008) nil (1001 . 1003) nil ("s" . -1001) ((marker . 1015) . -1) 1002 nil (1000 . 1002) nil ("i" . -1000) ((marker . 1015) . -1) ("h" . -1001) ((marker . 1015) . -1) 1002 nil (999 . 1002) nil (484 . 486) (t 23300 6020 309958 453000) nil (21 . 35) nil ("Thr" . -21) ((marker . 1015) . -3) 24 nil ("e" . -24) ((marker . 1015) . -1) 25 nil (21 . 25) nil ("parabora" . -21) ((marker . 1015) . -8) 29 (t 23300 5910 101462 693000) nil (989 . 991) (990 . 991) ("		" . 989) (989 . 991) (988 . 990) (t 23300 5860 17215 514000) nil (1494 . 1495) nil ("}" . -1494) ((marker . 999) . -1) ((marker . 1015) . -1) ((marker*) . 1) ((marker) . -1) ((marker) . -1) ((marker . 1523) . -1) 1495 nil (1495 . 1497) ("		" . 1495) ((marker . 1015) . -2) 1497 (t 23300 5856 518402 222000) nil (1499 . 1500) nil ("
" . -1495) ((marker . 1015) . -1) ((marker . 997) . -1) 1496 nil (1499 . 1500) ("}" . -1499) (1499 . 1500) (t 23300 5836 434889 385000) nil (1494 . 1495) ("}" . -1494) (1494 . 1495) nil (1479 . 1494) nil (1478 . 1479) ("	" . 1477) (1477 . 1478) (1477 . 1478) ("	" . 1477) ((marker . 1015) . -1) 1478 nil (1476 . 1478) nil (1475 . 1476) ("}" . -1475) (1475 . 1476) nil (1449 . 1475) nil (1448 . 1449) ("	" . 1447) (1447 . 1448) (1447 . 1448) ("	" . 1447) ((marker . 1015) . -1) 1448 nil (1446 . 1448) nil ("t" . -1446) ((marker . 1015) . -1) 1447 nil (1445 . 1447) ("}" . -1445) (1445 . 1446) nil ("	" . -1431) 1446 nil (1431 . 1446) nil (1430 . 1431) ("	" . 1429) (1429 . 1430) (1429 . 1430) ("	" . 1429) ((marker . 1015) . -1) 1430 nil (1428 . 1430) nil (1427 . 1428) ("}" . -1427) (1427 . 1428) (t 23300 5786 881966 844000) nil (1412 . 1427) nil (1411 . 1412) ("	" . 1410) (1410 . 1411) (1410 . 1411) ("	" . 1410) ((marker . 1015) . -1) 1411 nil (1409 . 1411) (t 23300 5778 623264 642000) nil (1412 . 1413) 1082 nil (992 . 1409) nil (991 . 992) ("	" . 990) (990 . 991) (990 . 991) ("	" . 990) ((marker . 1015) . -1) 991 nil (989 . 991) nil (988 . 989) ("}" . -988) (988 . 989) nil (988 . 991) ("		" . 988) ((marker . 999) . -2) ((marker . 1015) . -2) ((marker . 1016) . -2) 990 nil (977 . 990) nil (976 . 977) ("	" . 975) (975 . 976) (975 . 976) ("	" . 975) ((marker . 1015) . -1) ((marker . 1016) . -1) 976 nil (974 . 976) nil (484 . 974) nil (483 . 484) ("	" . 482) (482 . 483) (482 . 483) ("	" . 482) ((marker . 1015) . -1) ((marker . 1016) . -1) 483 nil (481 . 483) nil ("
" . -477) ((marker . 1508) . -1) ((marker . 1015) . -1) ((marker . 997) . -1) 478 nil ("		// 係数(alpha)の決定
		this.alpha = Math.floor( Math.random() * 2 ) + 1;
		this.minusFrag = Math.floor( Math.random() * 2 );
		if(this.minusFrag) this.alpha= - this.alpha;

		// 頂点(x,y)の決定
		if(Math.floor( Math.random() * 2 )){
			this.x = Math.floor( Math.random() * 9 ) + 1;
		}else{
			this.x = - Math.floor( Math.random() * 9 ) + 1;
		}
		
		if((this.alpha % 2) == 0){
			if(this.minusFrag) this.y = - (Math.floor( Math.random() * 4 ) + 1) * 2;
			else this.y = - (Math.floor( Math.random() * 4 ) + 1) * 2;
		}else{
			if(this.minusFrag) this.y = - (Math.floor( Math.random() * 9) + 1);
			else this.y = Math.floor( Math.random() * 9 ) + 1;
		}

		// 答えの計算
		var tmp_answer = Math.abs(this.y / this.alpha);
		if(tmp_answer == 1) this.answer = '2';
		else if(tmp_answer == 4) this.answer = '4';
		else if(tmp_answer == 8) this.answer = '4√2';
		else if(tmp_answer == 9) this.answer = '6';
		else this.answer = '2√' + String(tmp_answer);
		
		console.log(this.answer);" . -478) ((marker . 1015) . -967) ((marker) . -967) ((marker . 997) . -940) 1445 nil (465 . 1449) nil (464 . 465) ("	" . 463) (463 . 464) (463 . 464) ("	" . 463) ((marker . 1015) . -1) ((marker . 1016) . -1) 464 nil (462 . 464) nil (15 . 462) nil (13 . 15) nil (nil rear-nonsticky nil 12 . 13) (1 . 13) nil ("'use strict'

var RED_COLOR;
var BLUE_COLOR;
var BACK_COLOR;
var YELLOW_COLOR;
var ORANGE_COLOR;
var NORMAL_LINE_COLOR;
var LINE_WIDTH;

class triangleApp extends App{
	constructor(){
		super();
		
		this.canvas4 = document.getElementById('canvas-layer4');
		this.context4 = this.canvas4.getContext('2d');
		
		this.setColor();
		
		this.explainFrag = 0;
		this.explainState = 0;
		this.hintState = 0;
		this.score = 0;
		this.answerFrag = 0;
		this.canvas3.globalAlpha = 1;
		this.fadeTimer = null;
	}" . 1) ((marker . 999) . -135) ((marker . 1508) . -502) ((marker . 1) . -137) ((marker . 1) . -19) ((marker) . -502) ((marker . 1016) . -13) nil (138 . 503) nil (136 . 138) nil (1 . 136) (t . -1)))
