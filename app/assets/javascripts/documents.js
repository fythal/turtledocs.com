function edit_document(id){
	console.log("edit doc " + id)
	$.ajax({
		type: "GET",
		beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
		url: "/documents/edit/" + id,
		success: function(data){
			//$('#docs_list').html(data);
			load_inner_forms_container(data);

		}
    });
}

function document_update(id){
	var document_name = $('input[id=doc_name]').val().trim();
	console.log("names is " + document_name)
	if (!document_name || document_name == ''){
		$('#warning').html("Can not be blank.")
		$('#warning').show('slow', function() {});
	}else{
		$('#warning').hide('slow', function() {});
		$.ajax({
			type: "Post",
			data: {"name" : document_name, "id" : id},
			beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
			dataType: 'json',
			url: "/documents/update",
			success: function(data){
				console.log(JSON.stringify(data))
				if (data.response.status == "success"){
					get_document_list(data.response.model_id);
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

function remove_document(id){
	var r = confirm("Are you sure you want to delete this?")
	if (r == true){
		$.ajax({
			type: "Post",
			beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
			data: {"id" : id},
			dataType: 'json',
			url: "/documents/remove",
			success: function(data){
				if (data.response.status == "success"){
					get_document_list(data.response.model_id)
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
