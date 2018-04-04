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
	
		$('h1').text(title);
		$('#main').html(
			`<article id="intro">` + texts[0] + `</article>`
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
	$("#nav-arrow").css("transform", "rotate(180deg)");
}

var close_menu = function() {
	$("#nav-arrow").css("transform", "rotate(0deg)");
}

$(document).ready(function() {
	build_nav();
	load_topic('home');
});