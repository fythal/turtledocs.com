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
	$('#eqp-edit').attr('onclick', 'update_equipment(' + id + ')');
	$('#eqp-delete').attr('onclick', 'delete_equipment(' + id + ')');

	if (ident == 'eq'){
		put_model_data(id);
	}
}

function get_equipment_list(id){
	$.ajax({
        type: "GET",
        url: "/getequipmentlist/" + id,
        success: function(html){
			$('#eqp-inner_box').html(html);
        }
    });
}

function put_model_data(data){
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

function equipment_make_form(){
	console.log('need to load create equipment');
	$.ajax({
		type: "GET",
		url: "/equipment/add",
		success: function(data){
			$('#docs_container').html(data);
		}
    });
}

function update_equipment(id){
	alert("Update equipment " + id)
}

function delete_equipment(id){
	var r = confirm("Are you sure you want to delete this?")
	if (r == true){
		alert("delete equipment " + id)
	}
}

function equipment_create(){
	var equipment_name = $('input[id=equipment_name]').val().trim();
	if (!equipment_name || equipment_name == ''){
		$('#warning').html("Can not be blank.")
		$('#warning').show('slow', function() {});
	}else{
		$('#warning').hide('slow', function() {});
		$.ajax({
			type: "GET",
			url: "/equipment/create/" + equipment_name,
			success: function(data){
				if (data.response.status == "success"){
					get_equipment_list(data.response.select_id)
				}else{
					$('#warning').html(data.response.message)
					$('#warning').show('slow', function() {});
				}
			}
    	});
	}
}



