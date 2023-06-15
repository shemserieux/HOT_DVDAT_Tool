
row_template = {
 "1" : "<tr><td><input type='date' name='date' class='main_works'</input></td><td><select name='attribute_name' required><option value = ''>Select the Damage type</option><option value = 'flooding'>Flooding</option><option value = 'landslide'>Landslide</option></select></td><td><input type='text' name='metric_value' class='main_works' placeholder= '10' pattern='[0-9]*(\.[0-9]{2})?'></input></td><td><img class='file_display fill' alt='damage type image' src='/static/images/download_01.ico' /><span class = 'cellButtonGroup'><img src='/images/upload_01.ico' style='cursor:pointer' class='file_upload' title='upload file' alt='upload file' /><img src='static/images/download_01' style='cursor:pointer;' class='file_download last'  title='download file' alt='download file' /><input type = 'hidden' name = 'id' /></span></td></tr>",
 "2" : "<tr><td><textarea name='item' class='main_works'></textarea></td><td><textarea name='description' class='main_works'></textarea></td><td><textarea name='age_and_condition' class='main_works'></textarea></td><td><textarea name='ownership_status' class='main_works'></textarea></td></tr>",
 "3" : "<tr><td><textarea name='institution' class='main_works'></textarea></td><td><input type='text' name='available_resources' class='main_works' placeholder='1870.50' pattern='[0-9]*(\.[0-9]{2})?' ></input></td><td><textarea name='reference_name' class='main_works'></textarea></td><td><textarea name='reference_address' class='main_works'></textarea></td><td><textarea name='reference_tel_or_fax' class='main_works'></textarea></td><td><img class='file_display fill' style = 'display:none;' alt='image of evidence letter' /><span class = 'cellButtonGroup'><img src='images/upload_01.ico' style='cursor:pointer' class='file_upload' alt='upload file' /><img src='images/download_01.ico' style='cursor:pointer; display:none' class='file_download last' alt='download file' /><input type = 'hidden' name = 'evidence' value= '' /><input type='file' name='certificate_upload' accept='image/*' class='main_works' style='display:none' /></span></td></tr>",
 "4" : "<tr><td><textarea name='position' class='main_works'></textarea></td><td><textarea name='name' class='main_works'></textarea></td><td><textarea name='years_experience' class='main_works'></textarea></td><td><textarea name='qualifications' class='main_works'></textarea></td></tr>"
}

function appendRowBasedOnId(){
	emptyDmg = {"date":"", "metric_value":"", "id":""};
	var elementId = $(this).attr('id');
	var identifier = elementId.substring(elementId.length - 1);
	$("#tbl_row_append_" + identifier).append(_.template($("#tbl_row_append_template_" +  identifier).html(), (emptyDmg)));
}

function resetTables(){				
	var $mult_tables = $("tbody.table_form_edit");
	$mult_tables.html("");
	$.each($mult_tables, appendRowBasedOnId);
}

$(document).ready(function() {

	$("div.append_row").click(appendRowBasedOnId);
	//Button Styling
	$("div.append_row").mousedown( function(){
		$(this).addClass("buttonclick");
	}).mouseup( function(){
		$(this).removeClass("buttonclick");
	});
/*
	$("div.append_row").mouseenter( function(){
		$(this).addClass("buttonclick");
	}).mouseleave( function(){
		$(this).removeClass("buttonclick");
	});*/

});