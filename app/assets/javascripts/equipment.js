function box_select(value){
	var ar = value.split("-");
	var ident = ar[0];
	var id = ar[1];
	var old_selected = $('#' + ident + '_box_selected').attr('value');
	var str = "box_select('" + ident + "-" + old_selected + "')";
	var txt = $('#' + ident + '-' + id).text();
	$('#' + ident + '-box_header').text(txt);

	$('#' + ident + '_box_selected').attr('class', 'box_tag');
	$('#' + ident + '_box_selected').attr('onclick', str);
	$('#' + ident + '_box_selected').attr('id', ident + '-' + old_selected);

	$('#' + ident + '-' + id).attr('class', 'box_selected');
	$('#' + ident + '-' + id).attr('onclick', '');
	$('#' + ident + '-' + id).attr('id', ident + '_box_selected');

	if (ident == 'eq'){
		get_box_text(id);
	}
}

function get_box_text(data){
	$.ajax({
        type: "GET",
        url: "/getmodeldata/" + data,
        success: function(models){
			var html = '';
			var id = '';
			var cls = '';
			var onclick = '';
			$(models).each(function(i,m){
				if (i === 0){
					$('#mdl-box_header').html(m.name);
					id = 'mdl_box_selected';
					cls = 'box_selected';
					onclick = '';
				}else{
					id = 'mdl-' + m.id;
					cls = 'box_tag';
					onclick = "onclick=box_select('" + id + "')";
				}
				html += '<div id=' + id + ' class=' + cls + ' ' + onclick + '>' + m.name + '</div>';
			});
			$('#mdl-inner_box').html(html);
        }
    });
}

function create_equipment_make(){
	console.log('need to load create equipment');
	$.ajax({
		type: "GET",
		url: "/equipment/new",
		success: function(data){
			console.log('data is ' + data);
			$('#docs_container').html(data);
		}
    });
}