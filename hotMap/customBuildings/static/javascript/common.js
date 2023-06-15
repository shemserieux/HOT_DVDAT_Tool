
	var loading = 0;
	$.ajaxSetup({
		beforeSend: function(){
			loading++;
			var bws = getWindowHeight();
			loadingGif = $('img.nowloading');
			
			loadingGif.css('top', ((parseInt(bws.height) - parseInt(loadingGif.css("height"))) / 2) + "px");
			loadingGif.css('left', ((parseInt(bws.width) - parseInt(loadingGif.css("width"))) / 2) + "px");			
			loadingGif.css('display', 'block');
			$messagebox = $('.msg a');
			$messagebox.parent().hide();
		},
		complete: function(){
			loading--;
			if(loading < 1){
			
				loadingGif = $('img.nowloading');
				loadingGif.css('display', 'none');
				loading = 0;
			}
		}
	});
		
	function displayError(context, response){
		message = ""
		if(typeof response.responseText === 'object'){
				message = responseText.error
		}
		else{
			try{
				message = JSON.parse(response.responseText).error.message
			} catch(e){
				message = response.responseText
			}
		}
		
		$(context + " .msg.msg-error p strong").html(message);
		$(context + " .msg.msg-error").show(500);
		$('html, body').animate({
			scrollTop: $(context + " .msg.msg-error").offset().top
		}, 500);
	}
	
	
	function displaySuccess(context, message){
		$(context + " .msg.msg-ok p strong").html(message);
		$(context + " .msg.msg-ok").show(500);
		$('html, body').animate({
			scrollTop: $(context + " .msg.msg-ok").offset().top
		}, 500);
	}
	
	function getBrowserHeight() {
		return { width: $(document).width(), height: $(document).height() };
	}      
	function getWindowHeight() {
		return { width: $(window).width(), height: $(window).height() };
	} 

	function setLayerPosition(event) {
		var shadow = $("#shadow");
		var question = $("#question");


		var bws = getBrowserHeight();
	
		shadow.css("width", bws.width + "px");
		shadow.css("height", bws.height + "px");
		
		question.css("margin-left",  (parseInt(bws.width) - parseInt(question.css("width"))) / 2);
		
		if(event){
		    var halfwindow = (parseInt(question.css("height")) / 2);			
			var heightPos = 0;
			
			if((parseInt(event.pageY) + halfwindow) >= parseInt(bws.height)){ //if placing the window at the cursor will overflow the bottom
				heightPos = parseInt(bws.height) - (2 * halfwindow) - 20; //set the window at the bottom
			}else if ((parseInt(event.pageY) - halfwindow) <= parseInt(bws.height)){ //if placing the window at the cursor will overflow the top
				heightPos = 20; //set the window at the top
			}else{//set the window at the cursor
				heightPos = (parseInt(event.pageY) - halfwindow);
			}
			
			question.css("margin-top",  heightPos);
		}else{
			question.css("margin-top",  (parseInt(bws.height) - parseInt(question.css("height"))) / 2);
		}

	}	
			
	function clearForm(contextText){
		$elements = $(contextText +" input[type=text]");
		if($elements){$elements.val("");}
		
		$elements = $(contextText +" input[type=email]");
		if($elements){$elements.val("");}
		
		$elements = $(contextText +" input[type=tel]");
		if($elements){$elements.val("");}
		
		$elements = $(contextText +" input[type=hidden]");
		if($elements){$elements.val("");}
		
		$elements = $(contextText +" input[type=radio]");
		if($elements){$elements.prop("checked", false);}
		
		$elements = $(contextText +" input[type=checkbox]");
		if($elements){$elements.prop("checked", false);}
		
		$elements = $(contextText +" textarea");
		if($elements){$elements.val("");}
		
		$elements = $(contextText +" input[type=number]");
		if($elements){$elements.val("");}
				
		$elements = $(contextText +" label.field");
		if($elements){$elements.html("");}
		
		$elements = $(contextText +" select option:first-child");
		if($elements){$elements.attr("selected", true);}
	}				
	
	function hideLayer() {
		clearForm('#question');
		$("#shadow").css("display", "none");
		$("#question").css("display", "none");
		$(".subItem").css("display", "none");
	}

	function getHash(window) {	
		var match = (window || this).location.href.match(/#(.*)$/);
		return match ? match[1] : 0;
	}
	
	function preventDefaultBehaviour(event){		
        if(event.preventDefault){
			event.preventDefault();
		}else{;
			//for Internet Explorer
			event.returnValue = false;
		}
	}