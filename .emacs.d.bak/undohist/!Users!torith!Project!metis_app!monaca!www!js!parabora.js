
((digest . "714e980bb1ae8ac473f67dfcefc72d63") (undo-list nil ("	var page = event.target;
	if (page.matches('#parallel-page')) {
		quiz = draw_parallel();
		let button_list = page.querySelectorAll('.number_button');
		for(var i = 0; i < button_list.length; i++) {
			button_list[i].onclick = function() {
				input_number(page,this);
			};
		}	
		page.querySelector('#refresh').onclick = function() {
			canvas = document.getElementById(\"canvas\");
			context = canvas.getContext('2d');
			context.clearRect(0, 0, canvas.width, canvas.height);
			quiz = draw_parallel();
		};

		page.querySelector('#ENTER').onclick = function() {
			if(check_answer(quiz.answer)) {
				canvas = document.getElementById(\"canvas\");
				context = canvas.getContext('2d');
				context.clearRect(0, 0, canvas.width, canvas.height);
				quiz = draw_parallel();
			}
		};
	}
});


function check_answer(answer) {
	if( document.getElementsByClassName('left_side')[0].innerText == String(answer[1]) + ':' + String(answer[0])){
		document.getElementsByClassName('left_side')[0].innerText = \"\";
		return 1;
	}else{
		console.log('wrong');
		return 0;
	}
}


function make_quiz() {
	// 1:1, 1:2, 2:1 から一つを選ぶ
	var basic_ratio = [[1,1],[1,2],[2,1]][ Math.floor( Math.random() * 3 )];
	var tmp_right = ( basic_ratio[0] + basic_ratio[1] ) * Math.floor( Math.random() * 2 + 1 );
	var gcd = function(a, b) {
		if ( ! b) {
			return a;
		}
		return gcd(b, a % b);
	};
	var candidate = [];
	for(var i = 1; i < tmp_right; i++) {
		gcd(tmp_right,i) == 1 ? candidate.push(i) : null;
	}
	var tmp_left = candidate[ Math.floor( Math.random() * candidate.length )];

	// 答え計算
	var answer = [tmp_right * basic_ratio[0] / (basic_ratio[0] + basic_ratio[1]),tmp_left];
	answer = [answer[0]/gcd(answer[0],answer[1]), answer[1]/gcd(answer[0],answer[1])];
	
	return { 'basic': basic_ratio,
			 'optional': [tmp_right,tmp_left],
			 'answer': answer
		   };
}

function divide_edge(ratio,A,B) {
	return [ A[0] * ratio[1] / (ratio[0] + ratio[1]) + B[0] * ratio[0] / (ratio[0] + ratio[1]),
			 A[1] * ratio[1] / (ratio[0] + ratio[1]) + B[1] * ratio[0] / (ratio[0] + ratio[1])];
}

/*
// canvasに図形の描画を行う
// @param 
// @return 
*/
function draw_parallel() {
	// 描画する線の初期化
	canvas = document.getElementById(\"canvas\");
	context = canvas.getContext('2d');
	context.lineWidth = 5;
 	context.fillStyle = '#fff';
	context.font = \"25px 'tanuki'\";
	
	// 三角形の外形の決定
	var nodes = {'A': [[100,180,260][Math.floor( Math.random() * 3 )],30],
				 'B': [60,230],
				 'C': [290,230]
				};

	// 出題する辺をランダムに変更
	var first_node = String.fromCharCode(65 + Math.floor( Math.random() * 3 ));
	
	// first_node以外の内1つのノードを取得
	var array = ['A','B','C'];
	array.some(function(v, i){
		if (v == first_node) array.splice(i,1);
	});
	var second_node = array[ Math.floor( Math.random() * 2 ) ];
	
	// first_node,second_node以外のノードを取得
	array.some(function(v, i){
		if (v==second_node) array.splice(i,1);
	});
	var third_node = array[0];
	
	// quizの生成
	var quiz_data = make_quiz();
	var basic_ratio = quiz_data.basic;
	var optional_ratio = quiz_data.optional;
	var answer = quiz_data.answer;
	
	nodes.BP = divide_edge(basic_ratio,nodes[first_node],nodes[second_node]); // 移動元辺の間の点
	nodes.SP = divide_edge(optional_ratio,nodes[second_node],nodes[third_node]); // 移動先辺の間の点
	var mediam_ratio = [basic_ratio[0] * ((optional_ratio[0]+optional_ratio[1])/optional_ratio[1]),basic_ratio[1]];
	nodes.MP = divide_edge(mediam_ratio,nodes[first_node],nodes.SP); // 三角形の中の点

	console.log(quiz_data);

	context.beginPath();
	context.strokeStyle = '#fff';
	context.moveTo(nodes[third_node][0], nodes[third_node][1]);
	context.lineTo(nodes[first_node][0], nodes[first_node][1])
	
	context.moveTo(nodes[third_node][0], nodes[third_node][1]);
	context.lineTo(nodes.BP[0], nodes.BP[1]);
	context.moveTo(nodes[first_node][0], nodes[first_node][1]);
	context.lineTo(nodes.SP[0], nodes.SP[1]);
	context.stroke();

	// ノード間に線を引いて三角形を描画
	var line_frag = Math.floor( Math.random() * 2 );

	console.log(line_frag);

	context.beginPath();
	if (line_frag == 0) {
		context.strokeStyle = RED_COLOR;
	}else{
		context.strokeStyle = BLUE_COLOR;	
	}

	context.moveTo(nodes[first_node][0], nodes[first_node][1]);
	context.lineTo(nodes[second_node][0], nodes[second_node][1]);
	context.stroke();
	
	context.beginPath();
	if (line_frag == 0) {
		context.strokeStyle = BLUE_COLOR;
	}else{
		context.strokeStyle = RED_COLOR;	
	}
	context.moveTo(nodes[second_node][0], nodes[second_node][1]);
	context.lineTo(nodes[third_node][0], nodes[third_node][1]);
	context.stroke();


	// 文字を描画する処理
	context.fillStyle = '#FCF17A';
	context.fillText(\"A\", nodes.A[0], nodes.A[1]-7);
	context.fillText(\"B\", nodes.B[0]-20, nodes.B[1]);
	context.fillText(\"C\", nodes.C[0]+7, nodes.C[1]);

	var query_text;
	if (first_node == \"B\" || ((first_node == \"A\") && (second_node == \"B\"))) {
		context.fillText(\"D\", nodes.BP[0], nodes.BP[1]);
		context.fillText(\"E\", nodes.SP[0], nodes.SP[1]);
		query_text = third_node + \"F:FD=\"
	}else if (first_node == \"C\" || ((first_node == \"A\") && (second_node == \"C\"))) {
		context.fillText(\"E\", nodes.BP[0], nodes.BP[1]);
		context.fillText(\"D\", nodes.SP[0], nodes.SP[1]);
		query_text = third_node + \"F:FE=\"
	}
	context.fillText(\"F\", nodes.MP[0], nodes.MP[1]);
	context.fill();

	context.beginPath();
	context.font = \"18px 'tanuki'\";

	context.textAlign = \"center\";
	context.textBaseline = \"middle\";
	context.lineWidth = 4;
	
	// 比率を描画する処理
	var tmp_edge;
	var tmp_color;
	// 最初の比の描画
	if (!line_frag) {
		tmp_color = RED_COLOR;
	}else{
		tmp_color = BLUE_COLOR;
	}

	context.beginPath();
	context.fillStyle = '#1A261A';
	context.strokeStyle = tmp_color;
	tmp_edge = divide_edge([1,1],nodes[first_node],nodes.BP);
	context.arc(tmp_edge[0], tmp_edge[1], ARC_RADIUS, 0, Math.PI*2, false);
	context.stroke();
	context.fill();

	context.beginPath();
	context.fillStyle = tmp_color;
	context.fillText(String(basic_ratio[0]), tmp_edge[0], tmp_edge[1]);
	context.fill();

	context.beginPath();
	context.fillStyle = '#1A261A';
	context.strokeStyle = tmp_color;
	tmp_edge = divide_edge([1,1],nodes.BP,nodes[second_node]);
	context.arc(tmp_edge[0], tmp_edge[1], ARC_RADIUS, 0, Math.PI*2, false);
	context.stroke();
	context.fill();

	context.beginPath();
	context.fillStyle = tmp_color;
	context.fillText(String(basic_ratio[1]), tmp_edge[0], tmp_edge[1]);
	context.fill();

	// 次の比の描画
	if (!line_frag) {
		tmp_color = BLUE_COLOR;
	}else{
		tmp_color = RED_COLOR;
	}

	context.beginPath();
	context.fillStyle = '#1A261A';
	context.strokeStyle = tmp_color;
	tmp_edge = divide_edge([1,1],nodes[second_node],nodes.SP);
	context.arc(tmp_edge[0], tmp_edge[1], ARC_RADIUS, 0, Math.PI*2, false);
	context.stroke();
	context.fill();

	context.beginPath();
	context.fillStyle = tmp_color;
	context.fillText(String(optional_ratio[0]), tmp_edge[0], tmp_edge[1]);
	context.fill();

	context.beginPath();
	context.fillStyle = '#1A261A';
	context.strokeStyle = tmp_color;	
	tmp_edge = divide_edge([1,1],nodes.SP,nodes[third_node]);
	context.arc(tmp_edge[0], tmp_edge[1], ARC_RADIUS, 0, Math.PI*2, false);
	context.stroke();
	context.fill();

	context.beginPath();
	context.fillStyle = tmp_color;
	context.fillText(String(optional_ratio[1]), tmp_edge[0], tmp_edge[1]);
	context.fill();
	
	document.getElementsByClassName('right_side')[0].innerText = query_text;
	console.log(nodes);

	// 答え合わせをさせるために
	return { 'nodes': nodes,
			 'answer': answer
		   };
}

/*
// オリジナルキーボードの入力を画面に反映させる
// @param {page Object} page ページイベント, {bt_obj} button 押されたボタンオブジェクト
// @return なし
*/
function input_number(page,bt_obj) {
	if (bt_obj.id == 'BS') {
		page.querySelector('.left_side').textContent = page.querySelector('.left_side').textContent.slice(0,-1);
	}else if(bt_obj.id == 'ENTER'){
		if(page.querySelector('.left_side').textContent == '2'){
			console.log('correct');
		}else{
			console.log('wrong');
		}
	}else{
		page.querySelector('.left_side').textContent += bt_obj.id;
	}" . -184) ((marker . 49) . -7866) ((marker . 1) . -7279) ((marker . 1) . -7864) ((marker . 1) . -7864) ((marker) . -7803) ((marker) . -7803) ((marker) . -7795) ((marker) . -7795) ((marker) . -7791) ((marker) . -7791) ((marker) . -7766) ((marker) . -7766) ((marker) . -7757) ((marker) . -7757) ((marker) . -7730) ((marker) . -7730) ((marker) . -7671) ((marker) . -7671) ((marker) . -7638) ((marker) . -7638) ((marker) . -7531) ((marker) . -7531) ((marker) . -7505) ((marker) . -7505) ((marker) . -7468) ((marker) . -7468) ((marker) . -7465) ((marker) . -7465) ((marker) . -7451) ((marker) . -7451) ((marker) . -7383) ((marker) . -7383) ((marker) . -7357) ((marker) . -7357) ((marker) . -7354) ((marker) . -7354) ((marker) . -7353) ((marker) . -7353) ((marker) . -7351) ((marker) . -7351) ((marker) . -7343) ((marker) . -7343) ((marker) . -7322) ((marker) . -7322) ((marker) . -7296) ((marker) . -7296) ((marker) . -7279) ((marker) . -7279) ((marker) . -7866) ((marker*) . 1) ((marker) . -7866) ((marker*) . 65) ((marker) . -7866) ((marker . 184) . -7865) ((marker . 184) . -7866) 8050 nil (1 . 8053) (t . -1)))
