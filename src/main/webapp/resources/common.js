
function cfn_ajaxRequest(url, type, param, callback)
{
	$.ajax(
	{
		/*
		beforeSend: function(xhr)
		{
			xhr.setRequestHeader('Content-Type', 'application/json');
		},
		*/
		type: type,
		async: false,
		dataType: 'json',
		accept: 'application/json',
		contentType: 'application/json',
		url: url,
		//data: JSON.stringify(param),
		data: param,
		success: function(result)
		{
			console.log(result);
			
			return result;
		},
		error: function(result)
		{
			return result;
		},
		complete: function(result)
		{
			if(callback != null)
			{
				callback(result);
			}
		} 
	});
		
}