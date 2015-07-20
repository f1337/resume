// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
<!--

// init Shadowbox
Shadowbox.init({ 
	players: 	[ 'iframe' ],
    handleOversize: "resize", 
     onOpen: function() { 
             if((navigator.userAgent.match(/iPhone/i))||(navigator.userAgent.match(/iPad/i))) { 
                     $("#sb-container").css("top", $(window).scrollTop()); 
                     $(window).bind('scroll', function() { 
                             $("#sb-container").css("top", $(window).scrollTop()); 
                     }); 
             } 
     }, 
     onClose: function() { 
             if((navigator.userAgent.match(/iPhone/i))||(navigator.userAgent.match(/iPad/i))) { 
                     $(window).unbind('scroll'); 
             } 
     } 
});

// do some work on DOM ready
$(document).ready(function () 
{
	// activate mailto: for humans
	$('#contact').find('.email').each(function (i)
	{
		var email = $(this).html().replace(/<span>[^<]+<\/span>/g,'');
		$(this).attr({ href: 'mailto:' + email });
	});

	// wire-up all the vanilla links to open in shadowbox
	$('a:not([rel])').not('[class]').each(function (i)
	{
    	// set "click" handler
    	$(this).click(function ()
    	{
    		// open shadowbox
    		Shadowbox.open({
    	        content:    $(this).attr('href'),
    	        player:     'iframe',
    	        title:      $(this).text()
    	    });
    		return false;
    	});
	});
});
//-->