var title = "Machine Learning: R vs Python";
var menu_timeout;
var menu_is_open = false;
var MOBILE_WIDTH = 576;

var build_nav = function() {
	fetch("static/menu.xml")
		.then(function(response) {
			if (response.ok) {
				return response.text();
			} 
		})
		.then(function(xml) { return $.parseXML(xml); })
		.then(function(menu) {
			
			var home = $(menu).children("item");
			var str = `<ul>\n`;
			str = `\t<li onclick="load_topic('${$(home).text()}')">${$(home).attr('text')}</li>\n`;
			str = `</ul>\n`;

			var folders = $(menu).find("folder");
			$(folders).each(function(index) {
				str += `<button class="accordian">${$(this).attr('text')}</button>\n`;
				str += `\t<div class="panel">\n`;

				var items = $(this).find("item");
				str += `\t\t<ul>\n`;
				
				$(items).each(function(index) {
					str += `\t\t\t<li onclick="load_topic('${$(this).text()}')">${$(this).attr('text')}</li>\n`;
				});

				str += `\t\t</ul>\n`;
				str += `\t</div>\n`;

			});

			$('nav').html(str);

			$(".accordian").click(function() {
				$(this).toggleClass("active");
				var is_active = $(this).hasClass("active");
				
				var panel = $(this).next(".panel");

				if (is_active == true) {
					$(panel).show();
				} else {
					$(panel).hide();
				}
			});
		});
}

var load_topic = function(topic) {

	if (menu_is_open) {
		expand_menu();
	}

	$('#main').html("");
	urls = ["html/" + topic + ".html",
					"r/" + topic + ".r",
					"python/" + topic + ".py",
					"tensorflow/" + topic + ".py"];

	Promise.all(urls.map(function(url) {

		return fetch(url).then(function(response) { 
			if (response.status >= 200 && response.status < 300) { 
				return response.text();
			} else {
				return null;
			}
		}).catch(function() {});

	})).then(function(texts) {

		$('#main').html(
			`<h1>${title}</h1><article id="intro">${texts[0]}</article>`
		);
		MathJax.Hub.Queue(["Typeset", MathJax.Hub]);

		var str = "";
		if (texts[1] != null) {
			str += add_lang(texts[1], 'r', 'r');
		}
		if (texts[2] != null) {
			str += add_lang(texts[2], 'python', 'python');
		}
		if (texts[3] != null) {
			str += add_lang(texts[3], 'python', 'tensorflow');
		}
		$('#main').append(str);
		Prism.highlightAll()

	}).catch(function() {});

}

var add_lang = function(content, language, title) {
	return (`<div class="lang"><div class="title">${title}</div><pre class="language-${language} line-numbers"><code class="language-${language}" id="${title}">${content}</code></pre></div>`);
}

var expand_menu = function() {
	if (!menu_is_open) {
		$('#nav-expand').attr('id', 'nav-expand-open');
		if ($(window).width() > MOBILE_WIDTH) {
			$('#nav-arrow').css("transform", "rotate(180deg)");
		} else {
			$('#nav-arrow').css("transform", "rotate(-90deg)");
		}
		menu_timeout = setTimeout(function() {
			$('nav').show();
			menu_is_open = true;	
		}, 1500);

	} else {
		$('#nav-expand-open').attr('id', 'nav-expand');
		if ($(window).width() > MOBILE_WIDTH) {
			$('#nav-arrow').css("transform", "rotate(0deg)");
		} else {
			$('#nav-arrow').css("transform", "rotate(90deg)");
		}
		$('nav').hide();
		clearTimeout(menu_timeout);
		menu_is_open = false;
	}
}

var close_menu = function() {
	$('#nav-arrow').css("transform", "rotate(0deg)");
	clearTimeout(menu_timeout);
}

$(document).ready(function() {
	build_nav();
	load_topic('home');
});

$(document).click(function(event) {
	title = $(event.target).text();
});

$(window).resize(function() {
	var deg;
	if ($(window).width() > MOBILE_WIDTH && menu_is_open) {
		deg = '180deg';
	} else if ($(window).width() > MOBILE_WIDTH && !menu_is_open) {
		deg = '0deg';
	} else if ($(window).width() <= MOBILE_WIDTH && menu_is_open) {
		deg = '-90deg';
	} else {
		deg = '90deg';
	}

	$('#nav-arrow').css('transform', `rotate(${deg})`);
});