

	$("#stake_amount").change(function(){
		alert('ok');
	$.ajax({
	
	url: 'betting/index',
	data: {amount: $('#stake_amount').val()
		},
	dataType: "html"
	//do nothing
	

	});
});

