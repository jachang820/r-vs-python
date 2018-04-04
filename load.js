var title;

var build_nav = function() {
	fetch("menu.xml")
		.then(function(response) {
			if (response.ok) {
				return response.text();
			} 
		})
		.then(function(xml) { return $.parseXML(xml); })
		.then(function(menu) {
			var items = $(menu).find("item");
			var str = `<ul>`;
			$(items).each(function(index) {
				str += `<li onclick="load_topic('${$(this).children('name').text()}')">${$(this).children('text').text()}</li>`;
			});
			str += `</ul>`;
			$('nav').html(str);
		});
}

var load_topic = function(topic) {

	$('#main').html("");

	fetch("html/" + topic + ".html")
		.then(function(response) { return response.text(); })
		.then(function(html) {
			$('h1').text(title);
			$('#main').html(
				`<article id="intro">` + html + `</article>`
			);
			MathJax.Hub.Queue(["Typeset", MathJax.Hub]);
		}).catch(function() {});

	fetch("r/" + topic + ".r")
		.then(function(response) { return response.text(); })
		.then(function(code) {
			$('#main').append(add_lang(code, 'r', 'r'));
			Prism.highlightElement($('#r')[0]);
		}).catch(function() {});

	fetch("python/" + topic + ".py")
		.then(function(response) { return response.text(); })
		.then(function(code) {
			$('#main').append(add_lang(code, 'python', 'python'));
			Prism.highlightElement($('#python')[0]);
		}).catch(function() {});

	fetch("tensorflow/" + topic + ".py")
		.then(function(response) { return response.text(); })
		.then(function(code) {
			$('#main').append(add_lang(code, 'python', 'tensorflow'));
			Prism.highlightElement($('#tensorflow')[0]);
		}).catch(function() {});

}

var add_lang = function(content, language, title) {
	return (`<div class="lang"><div class="title">${title}</div><pre class="language-${language} line-numbers"><code class="language-${language}" id="${title}">${content}</code></pre></div>`);
}

var expand_menu = function() {
	$("#nav-arrow").css("transform", "rotate(180deg)");
}

var close_menu = function() {
	$("#nav-arrow").css("transform", "rotate(0deg)");
}

$(document).ready(function() {
	build_nav();
	load_topic('home');
});

$(document).click(function(event) {
	title = $(event.target).text();
});