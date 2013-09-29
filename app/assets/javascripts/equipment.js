
$( document ).ready(function() {
	$('#file_upload_toggledddd').click(function (event) {
		var val = $('#upload_docs_container').css('display');
		console.log("val is " + val)
		if (val == 'none'){
			$('#file_upload_toggle').text('close');
		}else{
			$('#file_upload_toggle').text('Upload Document');
		}
		$('#upload_docs_container').toggle('slow', function(){
		});
	  event.preventDefault(); // Prevent link from following its href
	});

	$('#search_box').keyup(function(){
		console.log("searching")
		if (this.value.length > 2 || $('#search_container').is(':visible')){
			$('#search_container').show('slow', function(){});
			$.ajax({
				type: "Post",
				data: {"value" : this.value},
				beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
				url: "/equipment/search_documents",
				success: function(data){
					$('#search_container').html(data);
				}
			});
		}
	});
	scrolltop_equipment()
	scrolltop_model()
});

$('#search_box').keyup(function(){
	console.log("searching")
	if (this.value.length > 2 || $('#search_container').is(':visible')){
		$('#search_container').show('slow', function(){});
		$.ajax({
			type: "Post",
			data: {"value" : this.value},
			beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
			url: "/equipment/search_documents",
			success: function(data){
				$('#search_container').html(data);
			}
		});
	}
});

function upload_toggle(){
	var val = $('#upload_docs_container').css('display');
	if (val == 'none'){
		$('#file_upload_toggle').text('close');
	}else{
		$('#file_upload_toggle').text('Upload Document');
	}
	$('#upload_docs_container').toggle('slow', function(){
	});
}

function close_search_container(){
	$('#search_container').hide('slow', function(){
		$('#search_box').attr('value', '');
	})}

	function box_select(value){
		var ar = value.split("-");
		var ident = ar[0];
		var id = ar[1];
		var old_selected = $('#' + ident + '_box_selected').attr('value');
		var str = "javascript:box_select('" + ident + "-" + old_selected + "')";
		var txt = $('#' + ident + '-' + id).text();
		var old_txt = $('#' + ident + '_box_selected').text();
		$('#' + ident + '-box_header').text(txt);

		$('#' + ident + '_box_selected').attr('class', 'box_tag');
		$('#' + ident + '_box_selected').html('<a href="' + str + '">' + old_txt + '</a>');
		$('#' + ident + '_box_selected').attr('id', ident + '-' + old_selected);


		$('#' + ident + '-' + id).attr('class', 'box_selected');
		$('#' + ident + '-' + id).html(txt);
		$('#' + ident + '-' + id).attr('id', ident + '_box_selected');

		if (ident == 'eq'){
			$('#eqp-edit').attr('href', 'javascript:edit_equipment(' + id + ')');
			$('#eqp-delete').attr('href', 'javascript:remove_equipment(' + id + ')');
			get_model_list(id);
		}else if (ident == 'md'){
			$('#mdl-edit').attr('href', 'javascript:edit_model(' + id + ')');
			$('#mdl-delete').attr('href', 'javascript:remove_model(' + id + ')');
			get_document_list('NULL',id);
		}
	}

	function get_document_list(equipment_id = 'NULL', model_id = 'NULL'){
		equipment_name = $('#eq_box_selected').text();
		$('#docs_equipment').html($('#eq_box_selected').text());
		if(model_id == 'NULL'){
			if($('#md_box_selected').length){
				model_id = $('#md_box_selected').attr('value');
			}
		}
		$('#docs_model').html($('#md_box_selected').text());
		$.ajax({
			beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Tokclose_formen', $('meta[name="csrf-token"]').attr('content'))},
			type: "GET",
			url: "/equipment/docs_container/" + equipment_id + "/" + model_id,
			success: function(html){
				$('#docs_container').html(html);
			}
		});
	}

	function get_equipment_list(equipment_id){
		$.ajax({
			beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Tokclose_formen', $('meta[name="csrf-token"]').attr('content'))},
			type: "GET",
			url: "/getequipmentlist/" + equipment_id,
			success: function(html){
				$('#eqp-inner_box').html(html);
				scrolltop_equipment()
				scrolltop_model()
				get_model_list(equipment_id)
			}
		});
	}

	function get_model_list(equipment_id, model_id = 'NULL'){
		$.ajax({
			beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Tokclose_formen', $('meta[name="csrf-token"]').attr('content'))},
			type: "GET",
			url: "/model/view/" + equipment_id + "/" + model_id,
			success: function(html){
				$('#mdl-inner_box').html(html);
				get_document_list(equipment_id, model_id);
			}
		});
	}

	function put_model_data(data){
		$.ajax({
			type: "GET",
			url: "/model/view/" + data,
			success: function(html){
				$('#mdl-inner_box').html(html);

			}
		});
	}

	function equipment_make_form(){
		$.ajax({
			type: "GET",
			url: "/equipment/add",
			success: function(data){
				load_inner_forms_container(data);
			}
		});
	}

	function load_inner_forms_container(data){
		$('#inner_forms_container').html(data);
		$('#forms_container').show('slow', function(){});
	}

	function model_make_form(equipment_id){
		$.ajax({
			type: "GET",
			url: "/model/add/" + equipment_id,
			success: function(data){
				load_inner_forms_container(data)
			}
		});
	}

	function edit_equipment(id){
		$.ajax({
			type: "GET",
			beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
			url: "/equipment/edit/" + id,
			success: function(data){
				load_inner_forms_container(data)
			}
		});
	}

	function edit_model(id){
		$.ajax({
			type: "GET",
			url: "/model/edit/" + id,
			success: function(data){
				load_inner_forms_container(data)
			}
		});
	}

	function equipment_update(id){
		var equipment_name = $('input[id=equipment_name]').val().trim();
		console.log("name is " + equipment_name)
		if (!equipment_name || equipment_name == ''){
			$('#warning').html("Can not be blank.")
			$('#warning').show('slow', function() {});
		}else{
			$('#warning').hide('slow', function() {});
			$.ajax({
				type: "Post",
				data: {"name" : equipment_name, "id" : id},
				beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
				dataType: 'json',
				url: "/equipment/update",
				success: function(data){
					if (data.response.status == "success"){
						get_equipment_list(data.response.select_id)
						$('#messaging').html(data.response.message);
						$('#messaging').show('slow', function() {
							$('#messaging').fadeOut(10000, function() {});
						});
						set_equipment_crumb(data.response.name);
					}else{
						$('#warning').html(data.response.message)
						$('#warning').show('slow', function() {});
					}
				}
			});
		}
	}

	function model_update(id){
		var model_name = $('input[id=model_name]').val().trim();
		console.log("name is " + model_name)
		if (!model_name || model_name == ''){
			$('#warning').html("Can not be blank.")
			$('#warning').show('slow', function() {});
		}else{
			$('#warning').hide('slow', function() {});
			$.ajax({
				type: "Post",
				beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
				data: {"name" : model_name, "id" : id},
				dataType: 'json',
				url: "/model/update",
				success: function(data){
					if (data.response.status == "success"){
						$('#messaging').html(data.response.message);
						$('#messaging').show('slow', function() {
							$('#messaging').fadeOut(10000, function() {});
						});
						console.log("data is " + JSON.stringify(data))
						get_model_list(data.response.equipment_select_id, data.response.model_select_id)
					//set_equipment_crumb(data.response.name);
					
				}else{
					$('#warning').html(data.response.message)
					$('#warning').show('slow', function() {});
				}
			}
		});
		}
	}

	function remove_equipment(id){
		var r = confirm("Are you sure you want to delete this?")
		if (r == true){
			$.ajax({
				type: "Post",
				beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Tokclose_formen', $('meta[name="csrf-token"]').attr('content'))},
				data: {"id" : id},
				dataType: 'json',
				url: "/equipment/remove",
				success: function(data){
					if (data.response.status == "success"){
						get_equipment_list(data.response.select_id)
						$('#messaging').html(data.response.message);
						$('#messaging').show('slow', function() {
							$('#messaging').fadeOut(10000, function() {});
						});
					}else{
						$('#warning').html(data.response.message)
						$('#warning').show('slow', function() {});
					}
				}
			});
		}
	}

	function remove_model(id){
		var r = confirm("Are you sure you want to delete this?")
		if (r == true){
			$.ajax({
				type: "Post",
				beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
				data: {"id" : id},
				dataType: 'json',
				url: "/model/remove",
				success: function(data){
					if (data.response.status == "success"){

						get_model_list(data.response.equipment_id)
						$('#messaging').html(data.response.message);
						$('#messaging').show('slow', function() {
							$('#messaging').fadeOut(10000, function() {});
						});
					}else{
						$('#warning').html(data.response.message)
						$('#warning').show('slow', function() {});
					}
				}
			});
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
				beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Tokclose_formen', $('meta[name="csrf-token"]').attr('content'))},
				success: function(data){
					if (data.response.status == "success"){
						$('#forms_container').fadeOut('slow', function(){
							$('#inner_forms_container').html('');
							get_equipment_list(data.response.select_id)
						});
						$('#messaging').html(data.response.message);
						$('#messaging').show('slow', function() {
							$('#messaging').fadeOut(10000, function() {});
						});
					}else{
						$('#warning').html(data.response.message)
						$('#warning').show('slow', function() {});
					}
				}
			});
		}
	}

	function model_create(equipment_id){
		var model_name = $('input[id=model_name]').val().trim();
		if (!model_name || model_name == ''){
			$('#warning').html("Can not be blank.")
			$('#warning').show('slow', function() {});
		}else{
			$('#warning').hide('slow', function() {});
			$.ajax({
				type: "GET",
				url: "/model/create/" + model_name + "/" + equipment_id,
				success: function(data){
					if (data.response.status == "success"){
						console.log("data is " + JSON.stringify(data))
						get_model_list(data.response.equipment_select_id, data.response.model_select_id)
						$('#messaging').html(data.response.message);
						$('#messaging').show('slow', function() {
							$('#messaging').fadeOut(10000, function() {});
						});
					}else{
						$('#warning').html(data.response.message)
						$('#warning').show('slow', function() {});
					}
				}
			});
		}
	}

	function toggle_upload_file(){
		console.log("togling")
	}

	function close_forms_container(){
		$('#forms_container').fadeOut('slow', function(){
			$('#inner_forms_container').html('');
		});
	}

	function set_equipment_crumb(name){
		$('#docs_equipment').fadeOut(1000, function(){
			$('#docs_equipment').html(name);
			$('#docs_equipment').fadeIn(1000, function(){

			});
		});

	}

	function scrolltop_equipment(){
		var top = $('#equipment_box').scrollTop();
		var cntr = 0
		var offset = 0;
		$('#equipment_box').children('div').each(function () {

			if($(this).attr('class') == 'box_selected'){
				return false;
			} 
			offset += $(this).outerHeight(true) -2;
			cntr ++;
		});
		$('#equipment_box').animate({scrollTop: offset},200);
	}

	function scrolltop_model(){
		var top = $('#equipment_box').scrollTop();
		var cntr = 0
		var offset = 0;
		$('#model_box').children('div').each(function () {

			if($(this).attr('class') == 'box_selected'){
				return false;
			} 
			offset += $(this).outerHeight(true) -2;
			cntr ++;
		});
		$('#model_box').animate({scrollTop: offset},200);
	}


